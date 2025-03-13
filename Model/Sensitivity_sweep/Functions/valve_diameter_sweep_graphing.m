

function valve_diameter_sweep_graphing(valve_diameter_sweep_simOut, valve_diameter_vector)


    time_warm_refuel = zeros([1, length(valve_diameter_vector)]);
    time_cold_refuel = zeros([1, length(valve_diameter_vector)]);
    
    
    for i = 1:length(valve_diameter_sweep_simOut)
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(valve_diameter_sweep_simOut(1, i), i);
        
        Ground_LH2_total = valve_diameter_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = valve_diameter_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = valve_diameter_sweep_simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);
    
    end
    
    
    figure(101)
    plot(valve_diameter_vector, time_warm_refuel)
    xlabel("Reference valve orifice diameter (m)")
    ylabel('Time taken per warm tank refuel (s)')
    title({"Time taken for for warm tank refuel", ...
        "with different valve orifice diameter"})
    saveas(gcf, 'Graphs/Time taken for warm tank refuel vs valve diameter.png')


end