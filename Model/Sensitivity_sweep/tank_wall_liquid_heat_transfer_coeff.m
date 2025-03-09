


clc
%% tank_wall_liquid_heat_transfer_coeff.m

liquid_heat_transfer_coeff_vector = logspace(log10(1), log10(10000), 20); % to be changed
rapid_flag = false;
accel_flag = false;
tic;


%parsim version
mdl = "simscape_automatic";

clear simIn

simIn(1:length(liquid_heat_transfer_coeff_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(liquid_heat_transfer_coeff_vector) 
    if rapid_flag
        simIn(i) = simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        simIn = simIn.setModelParameter('SimulationMode','accelerator');
    else
        simIn = simIn.setModelParameter('SimulationMode','normal');
    end


    simIn(i) = simIn(i).setVariable('AC_tank_liquid_heat_transfer_coeff', liquid_heat_transfer_coeff_vector(i)); 

    simIn(i) = simIn(i).setVariable('stopTime', 100000); 

end

if rapid_flag == false && accel_flag == false
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

toc;


%% plot

time_warm_refuel = zeros([1, length(liquid_heat_transfer_coeff_vector)]);
time_cold_refuel = zeros([1, length(liquid_heat_transfer_coeff_vector)]);
LH2_consumption_vec = zeros([1, length(liquid_heat_transfer_coeff_vector)]);

for i = 1:length(simOut)
    if isempty(simOut(1, i).ErrorMessage)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = simOut(1, i).yout{5}.Values.Time;

        figure(i)
        plot(AC_mode_time, AC_mode_data)
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end

        try
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

        LH2_consumption_vec(i) = Ground_LH2_total(idle_1_index);

        catch
        end


    end
end


figure(100)
plot(liquid_heat_transfer_coeff_vector, LH2_consumption_vec)
xlabel("Liquid heat transfer coefficient (W/K m^2)")
ylabel('LH2 consumed (kg)')
title("Total LH2 consumed for warm tank refuel with different UAM tank wall liquid heat transfer coefficient")
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs UAM tank wall liquid heat transfer coefficient.png')