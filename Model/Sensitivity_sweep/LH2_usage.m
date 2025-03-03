

clc
close all

%% This simulates model in normal conditions to find GH2 supplied LH2 rates vs that in the tank

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



%% plotting


% find time index of data
figure(1)
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

% LH2 usage for 
Ground_LH2_total = simOut.yout{4}.Values.Data;
AC_LH2_total = simOut.yout{3}.Values.Data;
Ground_LH2_total_time = simOut.yout{4}.Values.Time;

figure(2)
hold on
plot(Ground_LH2_total_time, Ground_LH2_total)
plot(Ground_LH2_total_time, AC_LH2_total)
legend(["Supplied by Ground Station", "Tank level"])
title("Total usage of LH2 over time")
xlabel("Time (s)")
ylabel("LH2 used (kg)")
hold off

figure(3)
hold on
title("Total usage of LH2 for warm tank refuel")
plot(Ground_LH2_total_time(start_warm_chilldown_index:idle_1_index), ...
    Ground_LH2_total(start_warm_chilldown_index:idle_1_index))
plot(Ground_LH2_total_time(start_warm_chilldown_index:idle_1_index), ...
    AC_LH2_total(start_warm_chilldown_index:idle_1_index))
legend(["Supplied by ground station", "UAM tank gauge"])
xlabel("Time (s)")
ylabel("LH2 used (kg)")
ylim([0, 70])
hold off
disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

% wall temp
figure(4)
hold on
title("UAM tank wall temperature against time")
AC_tank_wall_temp_data = simOut.yout{17}.Values.Data;
AC_tank_wall_temp_time = simOut.yout{17}.Values.Time;
plot(AC_tank_wall_temp_time, AC_tank_wall_temp_data)
xlabel("Time (s)")
ylabel("Temperature (K)")
hold off



figure(5)
hold on
title("Total usage of LH2 for cold tank refuel")
plot(Ground_LH2_total_time(start_cold_chilldown_index:idle_3_index) - Ground_LH2_total_time(start_cold_chilldown_index), ...
    Ground_LH2_total(start_cold_chilldown_index:idle_3_index) - Ground_LH2_total(start_cold_chilldown_index))
plot(Ground_LH2_total_time(start_cold_chilldown_index:idle_3_index) - Ground_LH2_total_time(start_cold_chilldown_index), ...
    AC_LH2_total(start_cold_chilldown_index:idle_3_index))
legend(["Supplied by ground station", "UAM tank gauge"])
xlabel("Time (s)")
ylabel("LH2 used (kg)")
ylim([0, 60])
hold off
disp("Total LH2 supplied by ground station = " + ...
    (Ground_LH2_total(idle_3_index)-Ground_LH2_total(start_cold_chilldown_index)) + "kg.")
disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

