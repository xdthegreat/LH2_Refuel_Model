

clc
close all
%% valve_diameter_sweep.m
% This changes aircraft valve orifice area over a variety of values

hose_length_vector = 5:1:20;
rapid_flag = true;
accel_flag = false;
tic;

%parsim version
mdl = "simscape_automatic";

simIn(1:length(hose_length_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(hose_length_vector) 
    if rapid_flag
        simIn(i) = simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        simIn = simIn.setModelParameter('SimulationMode','accelerator');
    else
        simIn = simIn.setModelParameter('SimulationMode','normal');
    end

    simIn(i) = simIn(i).setVariable('hose_length', hose_length_vector(i));

end

simOut = parsim(simIn, 'ShowSimulationManager', 'on');

toc;

%% Plotting stuff

%plot length of hose against LH2 used

LH2_consumed = [];
LH2_in_AC_tank = [];

for i = 1:length(simOut)
    if isempty(simOut(1, i).ErrorMessage)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = simOut(1, i).yout{5}.Values.Time;
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
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
    
        % disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
        % disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

        LH2_consumed(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank(i) = AC_LH2_total(idle_1_index);

    end
end


figure(1)
plot(hose_length_vector, LH2_consumed)