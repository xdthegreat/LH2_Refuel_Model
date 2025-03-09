
% TODO: change model to fluids_&_control.slx if needed



clc
%% valve_discharge_coeff_sweep.m
% This changes aircraft valve discharge coefficient over a variety of values

valve_discharge_coeff_vector = 0.4:0.02:0.8;
rapid_flag = false;
accel_flag = false;
tic;


%parsim version
mdl = "simscape_automatic";

clear simIn

simIn(1:length(valve_discharge_coeff_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(valve_discharge_coeff_vector) 
    if rapid_flag
        simIn(i) = simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        simIn = simIn.setModelParameter('SimulationMode','accelerator');
    else
        simIn = simIn.setModelParameter('SimulationMode','normal');
    end


    AC_engine_valve_discharge_coeff_temp = valve_discharge_coeff_vector(i);
    simIn(i) = simIn(i).setVariable('AC_engine_valve_discharge_coeff', AC_engine_valve_discharge_coeff_temp); 

    AC_return_valve_discharge_coeff_temp = valve_discharge_coeff_vector(i);
    simIn(i) = simIn(i).setVariable('AC_return_valve_discharge_coeff', AC_return_valve_discharge_coeff_temp); 

    AC_supply_valve_discharge_coeff_temp = valve_discharge_coeff_vector(i);
    simIn(i) = simIn(i).setVariable('AC_supply_valve_discharge_coeff', AC_supply_valve_discharge_coeff_temp); 

    simIn(i) = simIn(i).setVariable('stopTime', 100000); 

end


if rapid_flag == false && accel_flag == false
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

toc;


%% ans processing

for i = 1:length(valve_discharge_coeff_vector)
    if isempty(simOut(1, i).ErrorMessage)
        figure(i)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        time_array = simOut(1, i).yout{5}.Values.Time;
        plot(time_array, AC_mode_data)
    end
end

time_warm_refuel = [];
time_cold_refuel = [];

for i = 1:length(simOut)
    if isempty(simOut(1, i).ErrorMessage)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = simOut(1, i).yout{5}.Values.Time;

        figure(i)
        plot(AC_mode_time, AC_mode_data)
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j)];
            end
        end

        
        start_warm_chilldown_index = find(simOut(1, i).tout == mode_breakpoint_array(1));
        start_warm_tank_fill_index = find(simOut(1, i).tout == mode_breakpoint_array(2));
        start_warm_warmup_index = find(simOut(1, i).tout == mode_breakpoint_array(3));
        start_warm_disconnect_index = find(simOut(1, i).tout == mode_breakpoint_array(4));
        idle_1_index = find(simOut(1, i).tout == mode_breakpoint_array(5));
        start_engine_feed_index = find(simOut(1, i).tout == mode_breakpoint_array(6));
        idle_2_index = find(simOut(1, i).tout == mode_breakpoint_array(7));
        start_cold_chilldown_index = find(simOut(1, i).tout == mode_breakpoint_array(8));
        start_cold_tank_fill_index = find(simOut(1, i).tout == mode_breakpoint_array(9));
        start_cold_warmup_index = find(simOut(1, i).tout == mode_breakpoint_array(10));
        start_cold_disconnect_index = find(simOut(1, i).tout == mode_breakpoint_array(11));
        idle_3_index = find(simOut(1, i).tout == mode_breakpoint_array(12));
        start_defuel_chilldown_index = find(simOut(1, i).tout == mode_breakpoint_array(13));
        start_defuel_drain_index = find(simOut(1, i).tout == mode_breakpoint_array(14));
        start_defuel_disconnect = find(simOut(1, i).tout == mode_breakpoint_array(15));
    
        Ground_LH2_total = simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);


    end
end


figure(100)
plot(valve_discharge_coeff_vector, time_warm_refuel)
xlabel("Valve discahrge coefficient")
ylabel('Time taken per warm tank refuel (s)')
title("Time taken for for warm tank refuel with different valve discharge coefficient")
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs valve diameter.png')