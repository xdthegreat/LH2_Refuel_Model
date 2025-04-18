
close all
%% This is used to generate the nice graphs used for the actual report. 
% Reads processed data from spreadsheets instead of simOut

line_width = 2;

baseline_results = readmatrix('Graphs\normal_tank_filling_time_total_consumption_results.xlsx');
warm_tank_time_baseline = baseline_results(1);
cold_tank_time_baseline = baseline_results(2);
warm_tank_UAM_consumption_baseline = baseline_results(3);
warm_tank_GS_consumption_baseline = baseline_results(4);
cold_tank_UAM_consumption_baseline = baseline_results(5);
cold_tank_GS_consumption_baseline = baseline_results(6);

AC_tank_conductivity_results = readmatrix('Graphs\AC_tank_conductivity_sweep_results.xlsx');
feed_pres_sweep_results = readmatrix('Graphs\feed_pressure_sweep_results.xlsx');
feed_temp_sweep_results = readmatrix('Graphs\feed_temp_sweep_results.xlsx');
hose_insulation_sweep_results = readmatrix('Graphs\hose_insulation_sweep_results.xlsx');
hose_length_sweep_results = readmatrix('Graphs\hose_length_sweep_results.xlsx');
liquid_heat_sweep_results = readmatrix('Graphs\liqudi_heat_sweep_results.xlsx');
m_LH2_sweep_results = readmatrix('Graphs\M_LH2_sweep_results.xlsx');
valve_diameter_sweep_results = readmatrix('Graphs\vaalve_diameter_sweep_results.xlsx');
valve_discharge_coeff_sweep_results = readmatrix('Graphs\vaalve_discharge_coeff_sweep_results.xlsx');
vapour_heat_sweep_results = readmatrix('Graphs\vapour_heat_sweep_results.xlsx');
target_tank_pressure_sweep_results = readmatrix('Graphs\target_tank_pressure_sweep_results.xlsx');


normal_flow_rate_results = readmatrix('Graphs\normal flow rate details.xlsx');
normal_mass_flow_rate_results = readmatrix('Graphs\normal mass flow rate details.xlsx');

all_results = {AC_tank_conductivity_results, ...
feed_pres_sweep_results, ...
feed_temp_sweep_results, ...
hose_insulation_sweep_results, ...
hose_length_sweep_results, ...
liquid_heat_sweep_results, ...
m_LH2_sweep_results, ...
valve_diameter_sweep_results, ...
valve_discharge_coeff_sweep_results, ...
vapour_heat_sweep_results, ...
target_tank_pressure_sweep_results, ...
normal_flow_rate_results, ...
normal_mass_flow_rate_results};

% cell array for results attangement
result_arrangement = {"UAM tank conductivity", ...
    "Feed pressure", ...
    "Feed temperature", ...
    "Hose conductivity", ...
    "Hose length", ...
    "UAM liquid heat transfer coefficient", ...
    "Tank size", ...
    "Valve diameter", ...
    "Valve discharge coefficient", ...
    "UAM vapour heat transfer coefficient", ...
    "Target tank pressure"};

% check dimensions
for i = 1:length(all_results)-2
   result_size = size(all_results{i});
    if result_size(2) == 9
        break
    else
        disp(i)
        disp("This one has unexpected dimensions")
    end
end

%reparsing data from sweeps
input_vector = {};
LH2_consumed_warm_fill_output = {};
LH2_in_AC_tank_warm_fill_output = {};
frac_useful_LH2_warm_fill_output = {};
LH2_consumed_cold_fill_output = {};
LH2_in_AC_tank_cold_fill_output = {};
frac_useful_LH2_cold_fill_output = {};
time_warm_refuel_output = {};
time_cold_refuel_output = {};

for i = 1:length(all_results)-2
    input_vector{i} = all_results{i}(:, 1);
    LH2_consumed_warm_fill_output{i} = all_results{i}(:, 2);
    LH2_in_AC_tank_warm_fill_output{i} = all_results{i}(:, 3);
    frac_useful_LH2_warm_fill_output{i} = all_results{i}(:, 4);
    LH2_consumed_cold_fill_output{i} = all_results{i}(:, 5);
    LH2_in_AC_tank_cold_fill_output{i} = all_results{i}(:, 6);
    frac_useful_LH2_cold_fill_output{i} = all_results{i}(:, 7);
    time_warm_refuel_output{i} = all_results{i}(:, 8);
    time_cold_refuel_output{i} = all_results{i}(:, 9);
end

% finding missing data
sweep_length = 0;
for i = 1:length(input_vector)
    sweep_length = max(sweep_length, length(input_vector{i}));
end
for i = 1:length(input_vector)
    if sweep_length > length(input_vector{i})
        disp(result_arrangement{i} +  " has simulation errors")
    end
end


% auto graphing
for i = 1:length(all_results)-2
    close all

figure(1)
plot(input_vector{i}, time_warm_refuel_output{i})
xlabel(result_arrangement{i})
ylabel('Time taken (s)')
title({"Time taken for warm tank refuel", ...
    "with different "} + result_arrangement{i})
saveas(gcf, 'Auto_graph/Time taken for warm tank refuel vs ' + result_arrangement{i} + '.png')

figure(2)
hold on
plot(input_vector{i}, LH2_consumed_warm_fill_output{i})
plot(input_vector{i}, LH2_in_AC_tank_warm_fill_output{i})
hold off
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel(result_arrangement{i})
ylabel('LH2 consumed (kg)')
title({"LH2 consumed for warm tank refuel", ...
    "with different "} + result_arrangement{i})
saveas(gcf, 'Auto_graph/LH2 consumedfor warm tank refuel vs ' + result_arrangement{i} + '.png')


figure(3)
plot(input_vector{i}, time_cold_refuel_output{i})
xlabel(result_arrangement{i})
ylabel('Time taken (s)')
title({"Time taken for cold tank refuel", ...
    "with different "} + result_arrangement{i})
saveas(gcf, 'Auto_graph/Time taken for cold tank refuel vs ' + result_arrangement{i} + '.png')

figure(4)
hold on
plot(input_vector{i}, LH2_consumed_cold_fill_output{i})
plot(input_vector{i}, LH2_in_AC_tank_cold_fill_output{i})
hold off
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel(result_arrangement{i})
ylabel('LH2 consumed (kg)')
title({"LH2 consumed for cold tank refuel", ...
    "with different "} + result_arrangement{i})
saveas(gcf, 'Auto_graph/LH2 consumed for cold tank refuel vs ' + result_arrangement{i} + '.png')

end


% init percentage array
refuel_time_percentage_list = [];
warm_refuel_GS_percentage_list = [];


%% SENS-001, SENS-002, valve diameter and valve discharge ratio
close all

target_dataset = find(strcmp([result_arrangement{:}], "Valve diameter"));
figure(1)
hold on
yyaxis left
plot(input_vector{target_dataset}./0.01, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("Fraction of valve that is unblocked")
ylabel('Time taken per warm tank refuel (s)')
ylim([330, 360])

yyaxis right
plot(input_vector{target_dataset}./0.01, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth', line_width)
hold off
ylabel('LH2 consumed (kg)')
ylim([30, 40])
xlim([0.7, 1])
legend(["Time taken for warm tank refuel", "Supplied by ground station"])

title({"Time taken for warm tank refuel and LH2", ...
    "consumption with different valve orifice diameter"})
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')

[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);


target_dataset = find(strcmp([result_arrangement{:}], "Valve discharge coefficient"));

figure(3)
hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("UAM valve discharge coefficient")
ylabel('Time taken per warm tank refuel (s)')
ylim([330, 360])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([30, 40])
title({"Time taken for warm tank refuel and LH2", ...
    "consumption with different valve discharge coefficient"})
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);

%% SENS-003, SENS-004 liquid/vapour heat transfer coefficients
close all

target_dataset = find(strcmp([result_arrangement{:}], "UAM liquid heat transfer coefficient"));
figure(1)
hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("Liquid heat transfer coefficient (W/K m^2)")
ylabel('Time taken per warm tank refuel (s)')
ylim([280, 360])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([0, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different UAM tank wall liquid heat transfer coefficient"})
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);

target_dataset = find(strcmp([result_arrangement{:}], "UAM vapour heat transfer coefficient"));
figure(3)
hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("Vapour heat transfer coefficient (W/K m^2)")
ylabel('Time taken per warm tank refuel (s)')
ylim([320, 360])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([0, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different UAM tank wall vapour heat transfer coefficient"})
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')



[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);

%% SENS-005 hose length
close all

target_dataset = find(strcmp([result_arrangement{:}], "Hose length"));
figure(1)
hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("Length of flexible hoses (m)")
ylabel('Time taken per warm tank refuel (s)')
ylim([250, 360])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([25, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different flexible hoses length"})
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);


%% SENS-006 UAM tank wall heat transfer coefficient
close all

target_dataset = find(strcmp([result_arrangement{:}], "UAM tank conductivity"));
hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("UAM tank wall insulation heat transfer coefficient (W/m^2)")
ylabel('Time taken per warm tank refuel (s)')
ylim([335, 340])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([33, 37])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different UAM tank wall heat transfer coefficient"})
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')



[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);


%% SENS-007 tank size

close all

target_dataset = find(strcmp([result_arrangement{:}], "Tank size"));
figure(3)
hold on
xlabel("UAM tank capacity (kg)")

plot(input_vector{target_dataset}, frac_useful_LH2_cold_fill_output{target_dataset}, 'LineWidth',line_width)
plot(input_vector{target_dataset}, frac_useful_LH2_warm_fill_output{target_dataset}, ...
    "-.",'LineWidth',line_width)
legend(["Warm tank refuel", "Cold tank refuel"])
ylabel('LH2 consumed (kg)')
ylim([0.4, 0.9])
title({"Fraction of useful LH2 ", ...
    "with different UAM tank size"})
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


%% SENS-008, SENS-009 feed pressure and temperature
close all

target_dataset = find(strcmp([result_arrangement{:}], "Feed pressure"));
figure(1)

hold on
yyaxis left
plot(input_vector{target_dataset}*10, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("Target feed pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
ylim([300, 500])

yyaxis right
plot(input_vector{target_dataset}*10, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([30, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different target feed pressure"})
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);


target_dataset = find(strcmp([result_arrangement{:}], "Feed temperature"));
figure(3)
hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("LH2 feed temperature (K)")
ylabel('Time taken per warm tank refuel (s)')
ylim([335, 340])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([30, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different LH2 feed temperature"})
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);

%% SENS-010 hose insulation
close all

target_dataset = find(strcmp([result_arrangement{:}], "Hose conductivity"));
figure(1)

hold on
yyaxis left
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
plot([0.38, 0.38], [0, 400],  "--")
xlabel("Hose conductivity (W/m)")
ylabel('Time taken per warm tank refuel (s)')
ylim([300, 350])

yyaxis right
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Current technology", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([30, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different hose conductivity"})
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);


%% SENS-011 UAM target pressure

close all
target_dataset = find(strcmp([result_arrangement{:}], "Target tank pressure"));
figure(1)
hold on
yyaxis left
plot(input_vector{target_dataset}*10, time_warm_refuel_output{target_dataset}, ...
    'LineWidth', line_width)
xlabel("UAM Target tank pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
ylim([320, 350])

yyaxis right
plot(input_vector{target_dataset}*10, LH2_consumed_warm_fill_output{target_dataset}, ...
    "-.", 'LineWidth',line_width)
legend(["Time taken for warm tank refuel", "Supplied by ground station"])
ylabel('LH2 consumed (kg)')
ylim([30, 45])
title({"Time taken for warm tank refuel and LH2 consumption ", ...
    "with different UAM target tank pressure"})
hold off
set(gca, 'XScale', 'log')
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


[refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list);

%% plot overall bar chart

close all

bar_xlabel = ["Valve diameter",...
    "Valve discharge coefficient", ...
    "UAM vapour heat transfer coefficient", ...
    "UAM liquid heat transfer coefficient", ...
    "Hose length", ...
    "UAM tank conductivity", ...
    "Feed pressure", ...
    "Feed temperature", ...
    "Hose conductivity", ...
    "Target tank pressure"];

percentage_array = [];
for i = 1:length(refuel_time_percentage_list)
    percentage_array(i, 1) = refuel_time_percentage_list(i);
    percentage_array(i, 2) = warm_refuel_GS_percentage_list(i);
end

f = figure;
f.Position = [50 50 1500 760];
hold on
b = bar(bar_xlabel, percentage_array, "LineWidth", line_width);
ylabel("Percentage change (%)")
for k = 1:size(percentage_array,2)
    b(1).LineStyle = "-";
    b(1).FaceColor = "blue";
    b(2).LineStyle = "-.";
    b(2).FaceColor = "white";
end
legend("Percentage change for refuel time", "Percentage change for warm tank refuel LH2 consumption")
title("A graph showing the sensitivity of the model against different parameters")
saveas(gcf, 'Nicer_graphs/Sweep_percentage.png')
