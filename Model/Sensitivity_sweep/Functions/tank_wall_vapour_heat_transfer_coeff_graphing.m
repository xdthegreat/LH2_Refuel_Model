

function tank_wall_vapour_heat_transfer_coeff_graphing(tank_wall_vapour_heat_transfer_coeff_simOut, vapour_heat_transfer_coeff_vector)


    time_warm_refuel = zeros([1, length(vapour_heat_transfer_coeff_vector)]);
    time_cold_refuel = zeros([1, length(vapour_heat_transfer_coeff_vector)]);
    LH2_consumed_warm_fill = zeros([1, length(vapour_heat_transfer_coeff_vector)]);
    
    for i = 1:length(tank_wall_vapour_heat_transfer_coeff_simOut)
        if isempty(tank_wall_vapour_heat_transfer_coeff_simOut(1, i).ErrorMessage)
       
    
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(tank_wall_vapour_heat_transfer_coeff_simOut(1, i), i);
        
        Ground_LH2_total = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = tank_wall_vapour_heat_transfer_coeff_simOut(1, i).yout{4}.Values.Time;
    
        disp("Total LH2 supplied by ground station = " + Ground_LH2_total(idle_1_index) + "kg.")
        disp("Total LH2 in the UAM tank = " + AC_LH2_total(idle_1_index) + "kg.")
    
        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        time_cold_refuel(i) = Ground_LH2_total_time(idle_3_index) - Ground_LH2_total_time(idle_2_index);
    
        LH2_consumed_warm_fill(i) = Ground_LH2_total(idle_1_index);   
        else
            disp("Error spotted, handling in graphing")
            vapour_heat_transfer_coeff_vector(i) = [0];
        end

    end

    vapour_heat_transfer_coeff_vector_copy = [];
    LH2_consumed_warm_fill_copy = [];
    LH2_in_AC_tank_warm_fill_copy = [];
    frac_useful_LH2_warm_fill_copy = [];
    LH2_consumed_cold_fill_copy = [];
    LH2_in_AC_tank_cold_fill_copy = [];
    frac_useful_LH2_cold_fill_copy = [];
    time_warm_refuel_copy = [];

    for i = 1:length(hose_insulation_sweep_simOut)
        if vapour_heat_transfer_coeff_vector(i) ~= [0]
            vapour_heat_transfer_coeff_vector_copy = [vapour_heat_transfer_coeff_vector_copy, 
                vapour_heat_transfer_coeff_vector(i)];
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
        end
    end

    vapour_heat_transfer_coeff_vector = vapour_heat_transfer_coeff_vector_copy;
    LH2_consumed_warm_fill = LH2_consumed_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    frac_useful_LH2_warm_fill = frac_useful_LH2_warm_fill_copy;
    LH2_consumed_cold_fill = LH2_consumed_cold_fill_copy;
    LH2_in_AC_tank_cold_fill = LH2_in_AC_tank_cold_fill_copy;
    frac_useful_LH2_cold_fill = frac_useful_LH2_cold_fill_copy;
    time_warm_refuel = time_warm_refuel_copy;
    LH2_consumed_warm_fill = LH2_consumed_warm_fill_copy;
    
    figure(101)
    plot(vapour_heat_transfer_coeff_vector, LH2_consumed_warm_fill)
    xlabel("Vapour heat transfer coefficient (W/K m^2)")
    ylabel('LH2 consumed (kg)')
    title({"Total LH2 consumed for warm tank refuel with", ...
        "different UAM tank wall vapour heat transfer coefficient"})
    set(gca, 'XScale', 'log')
    saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs UAM tank wall vapour heat transfer coefficient.png')
   
end