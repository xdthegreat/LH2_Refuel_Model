
function valve_discharge_coeff_sweep_graphing(valve_discharge_coeff_sweep_simOut, valve_discharge_coeff_vector)


    for i = 1:length(valve_discharge_coeff_vector)
        if isempty(valve_discharge_coeff_sweep_simOut(1, i).ErrorMessage)
            figure(i)
            AC_mode_data = valve_discharge_coeff_sweep_simOut(1, i).yout{5}.Values.Data;
            time_array = valve_discharge_coeff_sweep_simOut(1, i).yout{5}.Values.Time;
            plot(time_array, AC_mode_data)
        end
    end
    
    time_warm_refuel = zeros([1, length(valve_discharge_coeff_sweep_simOut)]);
    time_cold_refuel = zeros([1, length(valve_discharge_coeff_sweep_simOut)]);
    
    for i = 1:length(valve_discharge_coeff_sweep_simOut)
        if isempty(valve_discharge_coeff_sweep_simOut(1, i).ErrorMessage)
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(valve_discharge_coeff_sweep_simOut(1, i), i);
        
        Ground_LH2_total = valve_discharge_coeff_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = valve_discharge_coeff_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = valve_discharge_coeff_sweep_simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);

     else
            disp("Error spotted, handling in graphing")
            valve_discharge_coeff_vector(i) = [0];
        end

    end

    valve_discharge_coeff_vector_copy = [];
    LH2_consumed_warm_fill_copy = [];
    LH2_in_AC_tank_warm_fill_copy = [];
    frac_useful_LH2_warm_fill_copy = [];
    LH2_consumed_cold_fill_copy = [];
    LH2_in_AC_tank_cold_fill_copy = [];
    frac_useful_LH2_cold_fill_copy = [];
    time_warm_refuel_copy = [];
    LH2_consumption_vec_copy = [];

    for i = 1:length(valve_discharge_coeff_sweep_simOut)
        if valve_discharge_coeff_vector(i) ~= [0]
            valve_discharge_coeff_vector_copy = [valve_discharge_coeff_vector_copy, 
                valve_discharge_coeff_vector(i)];
            LH2_consumed_warm_fill_copy = [LH2_consumed_warm_fill_copy, 
                LH2_consumed_warm_fill(i)];
            LH2_in_AC_tank_warm_fill_copy = [LH2_in_AC_tank_warm_fill, ...
                LH2_in_AC_tank_warm_fill(i)];
            frac_useful_LH2_warm_fill_copy = [frac_useful_LH2_warm_fill(i), ...
                frac_useful_LH2_warm_fill(i)];

            LH2_consumed_cold_fill_copy = [LH2_consumed_cold_fill_copy, ...
                LH2_consumed_cold_fill(i)];
            LH2_in_AC_tank_cold_fill_copy = [LH2_in_AC_tank_cold_fill_copy, ...
                LH2_in_AC_tank_cold_fill(i)];
            frac_useful_LH2_cold_fill_copy = [frac_useful_LH2_cold_fill_copy, ...
                frac_useful_LH2_cold_fill(i)];


            time_warm_refuel_copy = [time_warm_refuel_copy, time_warm_refuel(i)];
            LH2_consumption_vec_copy = [LH2_consumption_vec_copy, LH2_consumption_vec(i)];

        end
    end
  valve_discharge_coeff_vector = valve_discharge_coeff_vector_copy;
    LH2_consumed_warm_fill = LH2_consumed_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    frac_useful_LH2_warm_fill = frac_useful_LH2_warm_fill_copy;
    LH2_consumed_cold_fill = LH2_consumed_cold_fill_copy;
    LH2_in_AC_tank_cold_fill = LH2_in_AC_tank_cold_fill_copy;
    frac_useful_LH2_cold_fill = frac_useful_LH2_cold_fill_copy;
    time_warm_refuel = time_warm_refuel_copy;
    LH2_consumption_vec = LH2_consumption_vec_copy;
    
    
    figure(101)
    plot(valve_discharge_coeff_vector, time_warm_refuel)
    xlabel("Valve discahrge coefficient")
    ylabel('Time taken per warm tank refuel (s)')
    title({"Time taken for for warm tank refuel", ...
        "with different valve discharge coefficient"})
    saveas(gcf, 'Graphs/Time taken for warm tank refuel vs valve coeff.png')

end