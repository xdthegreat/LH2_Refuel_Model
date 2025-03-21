

function [input_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(simOut, input_vector)


    for i = 1:length(simOut)
        if isempty(simOut(1, i).ErrorMessage)

        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(simOut(1, i), i);
        
        Ground_LH2_total = simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = simOut(1, i).yout{4}.Values.Time;
   

        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")

        LH2_consumed_warm_fill(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank_warm_fill(i) = AC_LH2_total(idle_1_index);
        frac_useful_LH2_warm_fill(i) = LH2_in_AC_tank_warm_fill(i)/LH2_consumed_warm_fill(i);

        LH2_consumed_cold_fill(i) = Ground_LH2_total(idle_3_index) - Ground_LH2_total(idle_2_index);
        LH2_in_AC_tank_cold_fill(i) = AC_LH2_total(idle_3_index) - AC_LH2_total(idle_2_index);
        frac_useful_LH2_cold_fill(i) = LH2_in_AC_tank_cold_fill(i)/LH2_consumed_cold_fill(i);

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);
       
     else
            disp("Error spotted, handling in graphing")
            input_vector(i) = [0];
        end

    end

    [input_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
        removing_errors_from_outputs(simOut, ...
        input_vector, LH2_consumed_warm_fill, ...
        LH2_in_AC_tank_warm_fill, frac_useful_LH2_warm_fill, LH2_consumed_cold_fill, ...
        LH2_in_AC_tank_cold_fill, frac_useful_LH2_cold_fill, time_warm_refuel, time_cold_refuel);
end
