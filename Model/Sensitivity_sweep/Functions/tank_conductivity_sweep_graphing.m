


function tank_conductivity_sweep_graphing(tank_conductivity_sweep_simOut, ...
    AC_tank_equivalent_conductivity_vector)


time_warm_refuel = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);
time_cold_refuel = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);
time_warm_fill = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);

LH2_consumption_vec = zeros([1, length(AC_tank_equivalent_conductivity_vector)]);


    for i = 1:length(tank_conductivity_sweep_simOut)
        if isempty(tank_conductivity_sweep_simOut(1, i).ErrorMessage)
        
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(tank_conductivity_sweep_simOut(1, i), i);
        
    
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
         else
            disp("Error spotted, handling in graphing")
            AC_tank_equivalent_conductivity_vector(i) = [0];
        end
        
    end

    AC_tank_equivalent_conductivity_vector_copy = [];
    LH2_consumed_warm_fill_copy = [];
    LH2_in_AC_tank_warm_fill_copy = [];
    frac_useful_LH2_warm_fill_copy = [];
    LH2_consumed_cold_fill_copy = [];
    LH2_in_AC_tank_cold_fill_copy = [];
    frac_useful_LH2_cold_fill_copy = [];
    time_warm_refuel_copy = [];
    time_cold_refuel_copy = [];

    for i = 1:length(hose_insulation_sweep_simOut)
        if AC_tank_equivalent_conductivity_vector(i) ~= [0]
            AC_tank_equivalent_conductivity_vector_copy = [AC_tank_equivalent_conductivity_vector_copy, 
                AC_tank_equivalent_conductivity_vector(i)];
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
            time_cold_refuel_copy = [time_cold_refuel_copy, time_cold_refuel(i)];

        end
    end

    AC_tank_equivalent_conductivity_vector = AC_tank_equivalent_conductivity_vector_copy;
    LH2_consumed_warm_fill = LH2_consumed_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    frac_useful_LH2_warm_fill = frac_useful_LH2_warm_fill_copy;
    LH2_consumed_cold_fill = LH2_consumed_cold_fill_copy;
    LH2_in_AC_tank_cold_fill = LH2_in_AC_tank_cold_fill_copy;
    frac_useful_LH2_cold_fill = frac_useful_LH2_cold_fill_copy;
    time_warm_refuel = time_warm_refuel_copy;
    time_cold_refuel = time_cold_refuel_copy;




figure(100)
plot(AC_tank_equivalent_conductivity_vector, time_warm_refuel)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", ...
    "with different insulation equivalent conductivity"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs UAM tank insulation conductivity.png')



figure(101)
plot(AC_tank_equivalent_conductivity_vector, time_cold_refuel)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per cold tank refuel (s)')
title({"Time taken for for cold tank refuel", ...
    "with different insulation equivalent conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for cold tank refuel vs UAM tank insulation conductivity.png')


figure(102)
plot(AC_tank_equivalent_conductivity_vector, time_warm_fill)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per cold tank refuel (s)')
title({"Time taken for for cold tank refuel", ...
    "with different insulation equivalent conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for warm tank filling vs UAM tank insulation conductivity.png')


figure(102)
plot(AC_tank_equivalent_conductivity_vector, LH2_consumption_vec)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", ...
    "with different insulation equivalent conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Lh2 consumed for warm tank filling vs UAM tank insulation conductivity.png')


end