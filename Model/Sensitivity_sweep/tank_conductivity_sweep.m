




close all
%% tank_conductivity_sweep.m
% This changes tank wall conductivity over a variety of values

AC_tank_equivalent_conductivity_vector = logspace(log10(1), log10(1200), 10)/(Ambient_temp-20)*AC_wall_thickness; % to be changed
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

clear tank_conductivity_sweep_simIn

tank_conductivity_sweep_simIn(1:length(AC_tank_equivalent_conductivity_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(AC_tank_equivalent_conductivity_vector) 
    if rapid_flag
        tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end


    tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setVariable('AC_tank_equivalent_conductivity', AC_tank_equivalent_conductivity_vector(i)); 

    tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setVariable('stopTime', 100000); 

end

if rapid_flag == false && accel_flag == false && fast_restart_flag
    tank_conductivity_sweep_simOut = parsim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    tank_conductivity_sweep_simOut = parsim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

toc;

%save run data
save('Graphs/tank_conductivity_sweep.mat', 'tank_conductivity_sweep_simOut')



zip('Graphs/tank_conductivity_sweep.zip', 'Graphs/tank_conductivity_sweep.mat')


%% plot

try
    load('Graphs/tank_conductivity_sweep.mat')
catch
    disp('tank_conductivity_sweep.mat not found')
end


time_warm_refuel = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);
time_cold_refuel = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);
time_warm_fill = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);

LH2_consumption_vec = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);


for i = 1:length(tank_conductivity_sweep_simOut)
    if isempty(tank_conductivity_sweep_simOut(1, i).ErrorMessage)
        AC_mode_data = tank_conductivity_sweep_simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = tank_conductivity_sweep_simOut(1, i).yout{5}.Values.Time;

        figure(i)
        plot(AC_mode_time, AC_mode_data)
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end

        try
        start_warm_chilldown_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(1));
        start_warm_tank_fill_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(2));
        start_warm_warmup_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(3));
        start_warm_disconnect_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(4));
        idle_1_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(5));
        start_engine_feed_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(6));
        idle_2_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(7));
        start_cold_chilldown_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(8));
        start_cold_tank_fill_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(9));
        start_cold_warmup_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(10));
        start_cold_disconnect_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(11));
        idle_3_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(12));
        start_defuel_chilldown_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(13));
        start_defuel_drain_index = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(14));
        start_defuel_disconnect = find(tank_conductivity_sweep_simOut(1, i).tout == mode_breakpoint_array(15));
    
        Ground_LH2_total = tank_conductivity_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = tank_conductivity_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = tank_conductivity_sweep_simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        LH2_consumption_vec(i) = Ground_LH2_total(idle_1_index);

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);

        time_warm_fill(i) =  Ground_LH2_total_time(start_warm_warmup_index) - ...
            Ground_LH2_total_time(start_warm_tank_fill_index);
        catch
        end


    end
end



figure(100)
plot(AC_tank_equivalent_conductivity_vector, time_warm_refuel)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per warm tank refuel (s)')
title("Time taken for for warm tank refuel with different insulation equivalent conductivity")
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs UAM tank insulation conductivity.png')



figure(101)
plot(AC_tank_equivalent_conductivity_vector, time_cold_refuel)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per cold tank refuel (s)')
title("Time taken for for cold tank refuel with different insulation equivalent conductivity")
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for cold tank refuel vs UAM tank insulation conductivity.png')


figure(102)
plot(AC_tank_equivalent_conductivity_vector, time_warm_fill)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per cold tank refuel (s)')
title("Time taken for for cold tank refuel with different insulation equivalent conductivity")
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for warm tank filling vs UAM tank insulation conductivity.png')


figure(102)
plot(AC_tank_equivalent_conductivity_vector, LH2_consumption_vec)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('LH2 consumed (kg)')
title("Total LH2 consumed for for cold tank refuel with different insulation equivalent conductivity")
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Lh2 consumed for warm tank filling vs UAM tank insulation conductivity.png')