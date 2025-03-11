


function Tank_size_sweep_graphing(Tank_size_sweep_simOut, m_LH2_vector)


%plot tank size against LH2 used

LH2_consumed_warm_fill = zeros([1, length(Tank_size_sweep_simOut)]);
LH2_in_AC_tank_warm_fill = zeros([1, length(Tank_size_sweep_simOut)]);
frac_useful_LH2_warm_fill = zeros([1, length(Tank_size_sweep_simOut)]);

LH2_consumed_cold_fill = zeros([1, length(Tank_size_sweep_simOut)]);
LH2_in_AC_tank_cold_fill = zeros([1, length(Tank_size_sweep_simOut)]);
frac_useful_LH2_cold_fill = zeros([1, length(Tank_size_sweep_simOut)]);

time_warm_refuel = zeros([1, length(Tank_size_sweep_simOut)]);

    for i = 1:length(Tank_size_sweep_simOut)
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(Tank_size_sweep_simOut(1, i), i);
        
    
        Ground_LH2_total = Tank_size_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = Tank_size_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = Tank_size_sweep_simOut(1, i).yout{4}.Values.Time;
    
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


figure(101)
plot(m_LH2_vector, frac_useful_LH2_warm_fill)
xlabel("Tank maximum (kg)")
ylabel('Fraction of LH2 in the tank/ fraction of LH2 in consumed')
title("Fraction of useful LH2 for warm tank refuel with different tank sizes")
saveas(gcf, 'Graphs/Fraction of useful LH2 vs tank size warm tank refuel.png')

figure(102)
plot(m_LH2_vector, frac_useful_LH2_cold_fill)
xlabel("Tank maximum (kg)")
ylabel('Fraction of LH2 in the tank/ fraction of LH2 in consumed')
title("Fraction of useful LH2 for cold tank \n refuel with different tank sizes")
saveas(gcf, 'Graphs/Fraction of useful LH2 vs tank size cold tank refuel.png')


figure(103)
plot(m_LH2_vector, time_warm_refuel)
xlabel("Tank maximum (kg)")
ylabel('Time taken per warm tank refuel (s)')
title("Time taken for for warm tank refuel \n with different tank sizes")
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs tank size warm tank refuel.png')


end