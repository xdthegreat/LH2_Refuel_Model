


function Feed_pressure_sweep_graphing(Feed_pressure_sweep_simOut, LH2_FEED_PRES_VEC)


LH2_consumed_warm_fill = zeros([1, length(Feed_pressure_sweep_simOut)]);
LH2_in_AC_tank_warm_fill = zeros([1, length(Feed_pressure_sweep_simOut)]);
frac_useful_LH2_warm_fill = zeros([1, length(Feed_pressure_sweep_simOut)]);

LH2_consumed_cold_fill = zeros([1, length(Feed_pressure_sweep_simOut)]);
LH2_in_AC_tank_cold_fill = zeros([1, length(Feed_pressure_sweep_simOut)]);
frac_useful_LH2_cold_fill = zeros([1, length(Feed_pressure_sweep_simOut)]);

time_warm_refuel = zeros([1, length(Feed_pressure_sweep_simOut)]);

    for i = 1:length(Feed_pressure_sweep_simOut)
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(Feed_pressure_sweep_simOut(1, i), i);
    
        Ground_LH2_total = Feed_pressure_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = Feed_pressure_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = Feed_pressure_sweep_simOut(1, i).yout{4}.Values.Time;
    
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
plot(LH2_FEED_PRES_VEC*10, time_warm_refuel)
xlabel("LH2 feed pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", "with different LH2 feed pressure"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs LH2 feed pres.png')



figure(102)
plot(LH2_FEED_PRES_VEC*10, LH2_consumed_warm_fill)
xlabel("LH2 feed pressure (bar)")
ylabel('LH2 consumed (kg)')
title("Total LH2 consumed for for cold tank refuel \n with different LH2 feed pressure")
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs LH2 feed pressure.png')


end