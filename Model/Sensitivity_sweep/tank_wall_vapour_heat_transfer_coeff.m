


close all
%% tank_wall_vapour_heat_transfer_coeff.m

vapour_heat_transfer_coeff_vector = logspace(log10(0.1), log10(1000), 10); % to be changed
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

clear tank_wall_vapour_heat_transfer_coeff_simIn

tank_wall_vapour_heat_transfer_coeff_simIn(1:length(vapour_heat_transfer_coeff_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(vapour_heat_transfer_coeff_vector) 
    if rapid_flag
        tank_wall_vapour_heat_transfer_coeff_simIn(i) = tank_wall_vapour_heat_transfer_coeff_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        tank_wall_vapour_heat_transfer_coeff_simIn(i) = tank_wall_vapour_heat_transfer_coeff_simIn.setModelParameter('SimulationMode','accelerator');
    else
        tank_wall_vapour_heat_transfer_coeff_simIn(i) = tank_wall_vapour_heat_transfer_coeff_simIn.setModelParameter('SimulationMode','normal');
    end


    tank_wall_vapour_heat_transfer_coeff_simIn(i) = tank_wall_vapour_heat_transfer_coeff_simIn(i).setVariable('AC_tank_vapour_heat_transfer_coeff', vapour_heat_transfer_coeff_vector(i)); 

    tank_wall_vapour_heat_transfer_coeff_simIn(i) = tank_wall_vapour_heat_transfer_coeff_simIn(i).setVariable('stopTime', 100000); 

end

if rapid_flag == false && accel_flag == false && fast_restart_flag
    tank_wall_vapour_heat_transfer_coeff_simOut = parsim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    tank_wall_vapour_heat_transfer_coeff_simOut = parsim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

toc;

%save run data
save('Graphs/tank_wall_vapour_heat_transfer_coeff.mat', 'tank_wall_vapour_heat_transfer_coeff_simOut')
zip('Graphs/tank_wall_vapour_heat_transfer_coeff.zip', 'Graphs/tank_wall_vapour_heat_transfer_coeff.mat')


%% plot

try
    load('Graphs/tank_wall_vapour_heat_transfer_coeff.mat')
catch
    disp('tank_wall_vapour_heat_transfer_coeff.mat not found')
end

time_warm_refuel = zeros([1, length(vapour_heat_transfer_coeff_vector)]);
time_cold_refuel = zeros([1, length(vapour_heat_transfer_coeff_vector)]);
LH2_consumption_vec = zeros([1, length(vapour_heat_transfer_coeff_vector)]);

for i = 1:length(tank_wall_vapour_heat_transfer_coeff_simOut)
    if isempty(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).ErrorMessage)
        AC_mode_data = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{5}.Values.Time;

        figure(i)
        plot(AC_mode_time, AC_mode_data)
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end

        try
        start_warm_chilldown_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(1));
        start_warm_tank_fill_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(2));
        start_warm_warmup_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(3));
        start_warm_disconnect_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(4));
        idle_1_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(5));
        start_engine_feed_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(6));
        idle_2_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(7));
        start_cold_chilldown_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(8));
        start_cold_tank_fill_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(9));
        start_cold_warmup_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(10));
        start_cold_disconnect_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(11));
        idle_3_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(12));
        start_defuel_chilldown_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(13));
        start_defuel_drain_index = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(14));
        start_defuel_disconnect = find(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).tout == mode_breakpoint_array(15));
    
        Ground_LH2_total = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);

        LH2_consumption_vec(i) = Ground_LH2_total(idle_1_index);

        catch
        end


    end
end


figure(100)
plot(vapour_heat_transfer_coeff_vector, LH2_consumption_vec)
xlabel("Vapour heat transfer coefficient (W/K m^2)")
ylabel('LH2 consumed (kg)')
title("Total LH2 consumed for warm tank refuel with different UAM tank wall vapour heat transfer coefficient")
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs UAM tank wall vapour heat transfer coefficient.png')