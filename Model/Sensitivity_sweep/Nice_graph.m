
close all
%% This is used to generate the nice graphs used for the actual report. 
% Reads processed data from spreadsheets instead of simOut

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
normal_flow_rate_results, ...
normal_mass_flow_rate_results, ...
target_tank_pressure_sweep_results};

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

end





%% SENS-001, SENS-002, valve diameter and valve discharge ratio
close all

target_dataset = find(strcmp([result_arrangement{:}], "Valve diameter"));
figure(1)
yyaxis left
plot(input_vector{target_dataset}./0.01, time_warm_refuel_output{target_dataset})
xlabel("Fraction of valve that is unblocked")
ylabel('Time taken per warm tank refuel (s)')
ylim([300, 310])

yyaxis right
hold on
plot(input_vector{target_dataset}./0.01, LH2_consumed_warm_fill_output{target_dataset})
plot(input_vector{target_dataset}./0.01, LH2_in_AC_tank_warm_fill_output{target_dataset})
hold off
ylabel('LH2 consumed (kg)')
ylim([0, 40])
legend(["Supplied by ground station", "Stored in UAM tank"])

title({"Time taken for warm tank refuel and LH2", ...
    "consumption with different valve orifice diameter"})
saveas(gcf, 'Nicer_graphs/' + result_arrangement{target_dataset} +'.png')


target_dataset = find(strcmp([result_arrangement{:}], "Valve discharge coefficient"));

figure(3)
plot(input_vector{target_dataset}./0.01, time_warm_refuel_output{target_dataset})
xlabel("UAM valve discharge coefficient")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel", ...
    "with different valve discharge coefficient"})
ylim([300, 310])
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{9} +'.png')

figure(4)
hold on
plot(input_vector{9}, LH2_consumed_warm_fill_output{9})
plot(input_vector{9}, LH2_in_AC_tank_warm_fill_output{9})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("UAM valve discharge coefficient")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different UAM valve discharge coefficient"})
ylim([0, 40])
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs ' + result_arrangement{9} +'.png')


%% SENS-003, SENS-004 liquid/vapour heat transfer coefficients
close all

target_dataset = find(strcmp([result_arrangement{:}], "UAM liquid heat transfer coefficient"));
figure(1)
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset})
xlabel("Liquid heat transfer coefficient (W/K m^2)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different UAM tank wall liquid heat transfer coefficient"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(2)
hold on
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("Liquid heat transfer coefficient (W/K m^2)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different UAM tank wall liquid heat transfer coefficient"})
ylim([25, 40])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs ' + result_arrangement{target_dataset} +'.png')


target_dataset = find(strcmp([result_arrangement{:}], "UAM vapour heat transfer coefficient"));
figure(3)
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset})
xlabel("Vapour heat transfer coefficient (W/K m^2)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different UAM tank wall vapour heat transfer coefficient"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(4)
hold on
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("Liquid heat transfer coefficient (W/K m^2)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different UAM tank wall vapour heat transfer coefficient"})
ylim([25, 40])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs ' + result_arrangement{target_dataset} +'.png')

%% SENS-005 hose length
close all

target_dataset = find(strcmp([result_arrangement{:}], "Hose length"));
figure(1)
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset})
xlabel("Length of flexible hoses (m)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different UAM tank wall heat transfer coefficient"})
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')


%% SENS-006 UAM tank wall heat transfer coefficient
close all

target_dataset = find(strcmp([result_arrangement{:}], "UAM tank conductivity"));
figure(1)
plot(input_vector{target_dataset}*(Ambient_temp-20)/AC_wall_thickness, time_warm_refuel_output{target_dataset})
xlabel("UAM tank wall heat transfer coefficient (W/m^2)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different UAM tank wall heat transfer coefficient"})
set(gca, 'XScale', 'log')
ylim([290, 320])
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(2)
hold on
plot(input_vector{target_dataset}*(Ambient_temp-20)/AC_wall_thickness, LH2_consumed_warm_fill_output{target_dataset})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("UAM tank wall heat transfer coefficient (W/m^2)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different UAM tank wall heat transfer coefficient"})
ylim([30, 35])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs ' + result_arrangement{target_dataset} +'.png')


%% SENS-008, SENS-009 feed pressure and temperature
close all

target_dataset = find(strcmp([result_arrangement{:}], "Feed pressure"));
figure(1)
plot(input_vector{target_dataset}*10, time_warm_refuel_output{target_dataset})
xlabel("Target feed pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different target feed pressure"})
ylim([290, 320])
set(gca, 'XScale', 'log')
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(2)
hold on
plot(input_vector{target_dataset}*10, LH2_consumed_warm_fill_output{target_dataset})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("Target feed pressure (bar)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different target feed pressure"})
ylim([30, 40])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs  ' + result_arrangement{target_dataset} +'.png')


target_dataset = find(strcmp([result_arrangement{:}], "Feed temperature"));
figure(3)
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset})
xlabel("LH2 feed temperature (K)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different target feed pressure"})
set(gca, 'XScale', 'log')
ylim([290, 320])
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(4)
hold on
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("LH2 feed temperature (K)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different target feed temperature"})
ylim([25, 40])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs ' + result_arrangement{target_dataset} +'.png')


%% SENS-010 hose insulation
close all

target_dataset = find(strcmp([result_arrangement{:}], "Hose conductivity"));
figure(1)
hold on
plot(input_vector{target_dataset}, time_warm_refuel_output{target_dataset})
plot([0.38, 0.38], [0, 400],  "r--")
hold off
legend(["Refuel time", "Current technology"])
xlabel("Hose conductivity (W/m)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different hose conductivity"})
set(gca, 'XScale', 'log')
ylim([290, 320])
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(2)
hold on
plot(input_vector{target_dataset}, LH2_consumed_warm_fill_output{target_dataset})
plot([0.38, 0.38], [0, 40],  "r--")
legend(["Supplied by ground station", "Current technology"])
xlabel("Hose conductivity (W/m)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different hose conductivity"})
ylim([25, 40])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs ' + result_arrangement{target_dataset} +'.png')

%% SENS-011 UAM target pressure


target_dataset = find(strcmp([result_arrangement{:}], "Target tank pressure"));
figure(1)
plot(input_vector{target_dataset}*10, time_warm_refuel_output{target_dataset})
xlabel("UAM Target tank pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for warm tank refuel with", ...
    "different target feed pressure"})
ylim([290, 320])
set(gca, 'XScale', 'log')
saveas(gcf, 'Nicer_graphs/Time taken for warm tank refuel vs ' + result_arrangement{target_dataset} +'.png')

figure(2)
hold on
plot(input_vector{target_dataset}*10, LH2_consumed_warm_fill_output{target_dataset})
legend(["Supplied by ground station", "Stored in UAM tank"])
xlabel("UAM Target feed pressure (bar)")
ylabel('LH2 consumed (kg)')
title({"LH2 consumption for warm tank refuel", ...
    "with different target feed pressure"})
ylim([30, 40])
set(gca, 'XScale', 'log')
hold off
saveas(gcf, 'Nicer_graphs/Warm tank refuel LH2 consumption vs  ' + result_arrangement{target_dataset} +'.png')

