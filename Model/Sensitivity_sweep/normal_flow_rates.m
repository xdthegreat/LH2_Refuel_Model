

clc
close all

%% This simulates model in normal conditions to find flow rates

mdl = "simscape_automatic";
rapid_flag = false;
accel_flag = false;

tic;
simIn = Simulink.SimulationInput(mdl); 
if rapid_flag
    simIn = simIn.setModelParameter(SimulationMode="rapid-accelerator");
elseif accel_flag
    simIn = simIn.setModelParameter('SimulationMode','accelerator');
else
    simIn = simIn.setModelParameter('SimulationMode','normal');
end

simOut = sim(simIn, ShowProgress="on");
toc;


%% graphing part
LH2_qdot = simOut.yout{9}.Values.Data;
LH2_qdot_time = simOut.yout{9}.Values.Time;
figure(1)
plot(LH2_qdot_time, LH2_qdot)
title("LH2 flow rates over time")

max_LH2_flow_speed = max(LH2_qdot)/AC_supply_line_port_inner_area;
disp("Max flow speed for LH2 is "+ max_LH2_flow_speed + "m/s.")

GH2_qdot = simOut.yout{10}.Values.Data;
GH2_qdot_time = simOut.yout{10}.Values.Time;
figure(2)
plot(GH2_qdot_time, GH2_qdot)
title("GH2 flow rates over time")

max_GH2_flow_speed = max(GH2_qdot)/AC_supply_line_port_inner_area;
disp("Max flow speed for GH2 is "+ max_GH2_flow_speed + "m/s.")


%return line quality
figure(3)
AC_return_line_vapour_frac = simOut.yout{26}.Values.Data;
AC_return_line_vapour_frac_time = simOut.yout{26}.Values.Time;
plot(AC_return_line_vapour_frac_time, AC_return_line_vapour_frac)
title("Volume fraction of GH2 in the return lines")

% find time index of data
figure(4)
AC_mode_data = simOut.yout{5}.Values.Data;
AC_mode_time = simOut.yout{5}.Values.Time;
plot(AC_mode_time, AC_mode_data)
title("AC modes")

mode_breakpoint_array = [];
for i = 2:length(AC_mode_data)
    if AC_mode_data(i-1) ~= AC_mode_data(i)
        mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(i+1)];
    end
end

start_warm_chilldown_index = find(simOut.tout == mode_breakpoint_array(1));
start_warm_tank_fill_index = find(simOut.tout == mode_breakpoint_array(2));
start_warm_warmup_index = find(simOut.tout == mode_breakpoint_array(3));
start_warm_disconnect_index = find(simOut.tout == mode_breakpoint_array(4));
idle_1_index = find(simOut.tout == mode_breakpoint_array(5));
start_engine_feed_index = find(simOut.tout == mode_breakpoint_array(6));
idle_2_index = find(simOut.tout == mode_breakpoint_array(7));
start_cold_chilldown_index = find(simOut.tout == mode_breakpoint_array(8));
start_cold_tank_fill_index = find(simOut.tout == mode_breakpoint_array(9));
start_cold_warmup_index = find(simOut.tout == mode_breakpoint_array(10));
start_cold_disconnect_index = find(simOut.tout == mode_breakpoint_array(11));
idle_3_index = find(simOut.tout == mode_breakpoint_array(12));
start_defuel_chilldown_index = find(simOut.tout == mode_breakpoint_array(13));
start_defuel_drain_index = find(simOut.tout == mode_breakpoint_array(14));
start_defuel_disconnect = find(simOut.tout == mode_breakpoint_array(15));



% GH2 flow rates
% warm tank warmup
AC_GH2_qdot_warm_warmup = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_warm_warmup_index:start_warm_disconnect_index);
AC_GH2_qdot_warm_warmup_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_warm_warmup_index:start_warm_disconnect_index);
figure(10)
plot(AC_GH2_qdot_warm_warmup_time, AC_GH2_qdot_warm_warmup)
title("GH2 flow rates during warm tank warmup")

max_GH2_flow_speed_warm_warmup = max(abs(AC_GH2_qdot_warm_warmup))/AC_supply_line_port_inner_area;
disp("Max flow speed for GH2 during warm tank warmup is "+ max_GH2_flow_speed_warm_warmup + "m/s.")
mean_GH2_flow_speed_warm_warmup = mean(abs(AC_GH2_qdot_warm_warmup))/AC_supply_line_port_inner_area;
disp("Mean flow speed for GH2 during warm tank warmup is "+ mean_GH2_flow_speed_warm_warmup + "m/s.")

% cold tank warmup
AC_GH2_qdot_cold_warmup = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_cold_warmup_index:start_cold_disconnect_index);
AC_GH2_qdot_cold_warmup_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_cold_warmup_index:start_cold_disconnect_index);
figure(11)
plot(AC_GH2_qdot_cold_warmup_time, AC_GH2_qdot_cold_warmup)
title("GH2 flow rates during cold tank warmup")

max_GH2_flow_speed_cold_warmup = max(abs(AC_GH2_qdot_cold_warmup))/AC_supply_line_port_inner_area;
disp("Max flow speed for GH2 during cold tank warmup is "+ max_GH2_flow_speed_cold_warmup + "m/s.")
mean_GH2_flow_speed_cold_warmup = mean(abs(AC_GH2_qdot_cold_warmup))/AC_supply_line_port_inner_area;
disp("Mean flow speed for GH2 during cold tank warmup is "+ mean_GH2_flow_speed_cold_warmup + "m/s.")

% defuel
AC_GH2_qdot_defuel = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_defuel_drain_index:start_defuel_disconnect);
AC_GH2_qdot_defuel_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_defuel_drain_index:start_defuel_disconnect);
figure(12)
plot(AC_GH2_qdot_defuel_time, AC_GH2_qdot_defuel)
title("GH2 flow rates during defuel tank drain")

max_GH2_flow_speed_defuel = max(abs(AC_GH2_qdot_defuel))/AC_supply_line_port_inner_area;
disp("Max flow speed for GH2 during defuel tank drain is "+ max_GH2_flow_speed_defuel + "m/s.")
mean_GH2_flow_speed_defuel = mean(abs(AC_GH2_qdot_defuel))/AC_supply_line_port_inner_area;
disp("Mean flow speed for GH2 during defuel tank drain is "+ mean_GH2_flow_speed_defuel + "m/s.")


% LH2 flow rates
% warm tank chilldown
AC_LH2_qdot_warm_chilldown = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_warm_chilldown_index:start_warm_tank_fill_index);
AC_LH2_qdot_warm_chilldown_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_warm_chilldown_index:start_warm_tank_fill_index);
figure(20)
plot(AC_LH2_qdot_warm_chilldown_time, AC_LH2_qdot_warm_chilldown)
title("LH2 flow rates during warm tank chilldown")

max_LH2_flow_speed_warm_chilldown = max(abs(AC_LH2_qdot_warm_chilldown))/AC_supply_line_port_inner_area;
disp("Max flow speed for LH2 during warm tank chilldown is "+ max_LH2_flow_speed_warm_chilldown + "m/s.")
mean_LH2_flow_speed_warm_chilldown = mean(abs(AC_LH2_qdot_warm_chilldown))/AC_supply_line_port_inner_area;
disp("Mean flow speed for LH2 during warm tank chilldown is "+ mean_LH2_flow_speed_warm_chilldown + "m/s.")

% warm tank fill
AC_LH2_qdot_warm_fill = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_warm_tank_fill_index:start_warm_warmup_index);
AC_LH2_qdot_warm_fill_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_warm_tank_fill_index:start_warm_warmup_index);
figure(21)
plot(AC_LH2_qdot_warm_fill_time, AC_LH2_qdot_warm_fill)
title("LH2 flow rates during warm tank fill")

max_LH2_flow_speed_warm_fill = max(abs(AC_LH2_qdot_warm_fill))/AC_supply_line_port_inner_area;
disp("Max flow speed for LH2 during warm tank fill is "+ max_LH2_flow_speed_warm_fill + "m/s.")
mean_LH2_flow_speed_warm_fill = mean(abs(AC_LH2_qdot_warm_fill))/AC_supply_line_port_inner_area;
disp("Mean flow speed for LH2 during warm tank fill is "+ mean_LH2_flow_speed_warm_fill + "m/s.")


% cold tank chilldown
AC_LH2_qdot_cold_chilldown = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_cold_chilldown_index:start_cold_tank_fill_index);
AC_LH2_qdot_cold_chilldown_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_cold_chilldown_index:start_cold_tank_fill_index);
figure(22)
plot(AC_LH2_qdot_cold_chilldown_time, AC_LH2_qdot_cold_chilldown)
title("LH2 flow rates during cold tank chilldown")

max_LH2_flow_speed_cold_chilldown = max(abs(AC_LH2_qdot_cold_chilldown))/AC_supply_line_port_inner_area;
disp("Max flow speed for LH2 during cold tank chilldown is "+ max_LH2_flow_speed_cold_chilldown + "m/s.")
mean_LH2_flow_speed_cold_chilldown = mean(abs(AC_LH2_qdot_cold_chilldown))/AC_supply_line_port_inner_area;
disp("Mean flow speed for LH2 during cold tank chilldown is "+ mean_LH2_flow_speed_cold_chilldown + "m/s.")

% cold tank fill
AC_LH2_qdot_cold_fill = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Data(start_cold_tank_fill_index:start_cold_warmup_index);
AC_LH2_qdot_cold_fill_time = simOut.yout{31}.Values.AC_supply_coupling_Qdot.Time(start_cold_tank_fill_index:start_cold_warmup_index);
figure(23)
plot(AC_LH2_qdot_cold_fill_time, AC_LH2_qdot_cold_fill)
title("LH2 flow rates during cold tank fill")

max_LH2_flow_speed_cold_fill = max(abs(AC_LH2_qdot_cold_fill))/AC_supply_line_port_inner_area;
disp("Max flow speed for LH2 during cold tank fill is "+ max_LH2_flow_speed_cold_fill + "m/s.")
mean_LH2_flow_speed_cold_fill = mean(abs(AC_LH2_qdot_cold_fill))/AC_supply_line_port_inner_area;
disp("Mean flow speed for LH2 during cold tank fill is "+ mean_LH2_flow_speed_cold_fill + "m/s.")


% defuel chilldown
AC_LH2_qdot_defuel_chilldown = simOut.yout{31}.Values.AC_supply_line_Qdot.Data(start_cold_chilldown_index:start_cold_tank_fill_index);
AC_LH2_qdot_defuel_chilldown_time = simOut.yout{31}.Values.AC_supply_line_Qdot.Time(start_cold_chilldown_index:start_cold_tank_fill_index);
figure(22)
plot(AC_LH2_qdot_defuel_chilldown_time, AC_LH2_qdot_defuel_chilldown)
title("LH2 flow rates during defuel chilldown")

max_LH2_flow_speed_defuel_chilldown = max(abs(AC_LH2_qdot_defuel_chilldown))/AC_supply_line_port_inner_area;
disp("Max flow speed for LH2 during defuel chilldown is "+ max_LH2_flow_speed_defuel_chilldown + "m/s.")
mean_LH2_flow_speed_defuel_chilldown = mean(abs(AC_LH2_qdot_defuel_chilldown))/AC_supply_line_port_inner_area;
disp("Mean flow speed for LH2 during defuel chilldown is "+ mean_LH2_flow_speed_defuel_chilldown + "m/s.")

normal_flow_rate_details = {"Warm tank refuel chilldown", mean_LH2_flow_speed_warm_chilldown, "m/s";
    "Warm tank refuel tank filling", mean_LH2_flow_speed_warm_fill, "m/s";
    "Warm tank refuel warmup", mean_GH2_flow_speed_warm_warmup, "m/s";
    "Cold tank refuel chilldown", mean_LH2_flow_speed_cold_chilldown, "m/s";
    "Cold tank refuel tank filling", mean_LH2_flow_speed_cold_fill, "m/s";
    "Cold tank refuel warmup", mean_GH2_flow_speed_cold_warmup, "m/s";
    "Defuel chilldown", mean_LH2_flow_speed_defuel_chilldown, "m/s";
    "Defuel wamrup", mean_GH2_flow_speed_defuel, "m/s"};

normal_flow_rate_details_table = cell2table(normal_flow_rate_details, ...
    'VariableNames', {'Operation phase' 'Mean flow rate' 'Unit'});
writetable(normal_flow_rate_details_table, "Graphs/normal flow rate details.xlsx")
