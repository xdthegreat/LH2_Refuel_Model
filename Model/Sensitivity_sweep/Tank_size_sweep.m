

clc
close all
%% valve_diameter_sweep.m
% This changes aircraft valve orifice area over a variety of values

m_LH2_vector = 16:4:70;
tank_volume_vector = m_LH2_vector./(70*AC_tank_vol_limit);
rapid_flag = false;
accel_flag = false;
tic;

%parsim version
mdl = "simscape_automatic";

simIn(1:length(tank_volume_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(tank_volume_vector) 
    if rapid_flag
        simIn(i) = simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        simIn = simIn.setModelParameter('SimulationMode','accelerator');
    else
        simIn = simIn.setModelParameter('SimulationMode','normal');
    end

    simIn(i) = simIn(i).setVariable('AC_tank_volume', tank_volume_vector(i));
    simIn(i) = simIn(i).setVariable('m_LH2', m_LH2_vector(i));

end

simOut = parsim(simIn, 'ShowSimulationManager', 'on');

toc;


%% Plotting stuff

%plot length of hose against LH2 used

LH2_consumed_warm_fill = [];
LH2_in_AC_tank_warm_fill = [];

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

        LH2_consumed_warm_fill(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank_warm_fill(i) = AC_LH2_total(idle_1_index);
        frac_useful_LH2_warm_fill(i) = LH2_in_AC_tank_warm_fill(i)/LH2_consumed_warm_fill(i);

        LH2_consumed_cold_fill(i) = Ground_LH2_total(idle_3_index) - Ground_LH2_total(idle_2_index);
        LH2_in_AC_tank_cold_fill(i) = AC_LH2_total(idle_3_index) - AC_LH2_total(idle_2_index);
        frac_useful_LH2_cold_fill(i) = LH2_in_AC_tank_cold_fill(i)/LH2_consumed_cold_fill(i);

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);

    end
end


figure(1)
plot(m_LH2_vector, frac_useful_LH2_warm_fill)
xlabel("Tank maximum (kg)")
ylabel('Fraction of LH2 in the tank/ fraction of LH2 in consumed')
title("Fraction of useful LH2 for warm tank refuel with different tank sizes")
saveas(gcf, 'Graphs/Fraction of useful LH2 vs tank size warm tank refuel.png')

figure(2)
plot(m_LH2_vector, frac_useful_LH2_cold_fill)
xlabel("Tank maximum (kg)")
ylabel('Fraction of LH2 in the tank/ fraction of LH2 in consumed')
title("Fraction of useful LH2 for cold tank refuel with different tank sizes")
saveas(gcf, 'Graphs/Fraction of useful LH2 vs tank size cold tank refuel.png')


figure(3)
plot(m_LH2_vector, time_warm_refuel)
xlabel("Tank maximum (kg)")
ylabel('Time taken per warm tank refuel (s)')
title("Time taken for for warm tank refuel with different tank sizes")
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs tank size warm tank refuel.png')