 

% TODO: change model to fluids_&_control.slx if needed
% Fix this and find out what is going on


close all
%% valve_diameter_sweep.m
% This changes aircraft valve orifice area over a variety of values

valve_diameter_vector = 0.008:0.001:0.01;
rapid_flag = false;
accel_flag = false;
fast_restart_flag = false;
tic;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end

clear valve_diameter_sweep_simIn

valve_diameter_sweep_simIn(1:length(valve_diameter_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(valve_diameter_vector) 
    if rapid_flag
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn.setModelParameter('SimulationMode','accelerator');
    else
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn.setModelParameter('SimulationMode','normal');
    end


    valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('AC_return_valve_orifice_area', (valve_diameter_vector(i)*8)^2*pi/4); 

    valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('AC_supply_valve_orifice_area', (valve_diameter_vector(i)*4.8)^2*pi/4); 
   
    valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('AC_engine_valve_orifice_area', valve_diameter_vector(i)^2*pi/4); 

    valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('stopTime', 10000); 

end

if rapid_flag == false && accel_flag == false && fast_restart_flag
    valve_diameter_sweep_simOut = parsim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    valve_diameter_sweep_simOut = parsim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

toc;
%save run data
save('Graphs/valve_diameter_sweep.mat', 'valve_diameter_sweep_simOut')
zip('Graphs/valve_diameter_sweep.zip', 'Graphs/valve_diameter_sweep.mat')


%% ans processing

try
    load('Graphs/valve_diameter_sweep.mat')
catch
    disp('valve_diameter_sweep.mat not found')
end


time_warm_refuel = zeros([1, length(valve_diameter_vector)]);


for i = 1:length(valve_diameter_sweep_simOut)
    if isempty(valve_diameter_sweep_simOut(1, i).ErrorMessage)
        AC_mode_data = valve_diameter_sweep_simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = valve_diameter_sweep_simOut(1, i).yout{5}.Values.Time;

        figure(i)
        plot(AC_mode_time, AC_mode_data)
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end

        try
        start_warm_chilldown_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(1));
        start_warm_tank_fill_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(2));
        start_warm_warmup_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(3));
        start_warm_disconnect_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(4));
        idle_1_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(5));
        start_engine_feed_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(6));
        idle_2_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(7));
        start_cold_chilldown_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(8));
        start_cold_tank_fill_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(9));
        start_cold_warmup_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(10));
        start_cold_disconnect_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(11));
        idle_3_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(12));
        start_defuel_chilldown_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(13));
        start_defuel_drain_index = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(14));
        start_defuel_disconnect = find(valve_diameter_sweep_simOut(1, i).tout == mode_breakpoint_array(15));
    
        Ground_LH2_total = valve_diameter_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = valve_diameter_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = valve_diameter_sweep_simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);
        catch
        end


    end
end


figure(10)
plot(valve_diameter_vector, time_warm_refuel)
xlabel("Reference valve orifice diameter (m)")
ylabel('Time taken per warm tank refuel (s)')
title("Time taken for for warm tank refuel with different valve orifice diameter")
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs valve diameter.png')