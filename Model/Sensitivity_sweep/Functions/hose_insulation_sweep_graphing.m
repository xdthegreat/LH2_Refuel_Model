


function hose_insulation_sweep_graphing(hose_insulation_sweep_simOut, hose_thermal_conductivity_vec)


%plot tank size against LH2 used
LH2_consumed_warm_fill = zeros([1, length(hose_insulation_sweep_simOut)]);
LH2_in_AC_tank_warm_fill = zeros([1, length(hose_insulation_sweep_simOut)]);
frac_useful_LH2_warm_fill = zeros([1, length(hose_insulation_sweep_simOut)]);

LH2_consumed_cold_fill = zeros([1, length(hose_insulation_sweep_simOut)]);
LH2_in_AC_tank_cold_fill = zeros([1, length(hose_insulation_sweep_simOut)]);
frac_useful_LH2_cold_fill = zeros([1, length(hose_insulation_sweep_simOut)]);

time_warm_refuel = zeros([1, length(hose_insulation_sweep_simOut)]);

    for i = 1:length(hose_insulation_sweep_simOut)
        if isempty(hose_insulation_sweep_simOut(1, i).ErrorMessage)
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(hose_insulation_sweep_simOut(1, i), i);

    
        Ground_LH2_total = hose_insulation_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = hose_insulation_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = hose_insulation_sweep_simOut(1, i).yout{4}.Values.Time;
    
        % disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
        % disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

        LH2_consumed_warm_fill(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank_warm_fill(i) = AC_LH2_total(idle_1_index);
        frac_useful_LH2_warm_fill(i) = LH2_in_AC_tank_warm_fill(i)/LH2_consumed_warm_fill(i);

        LH2_consumed_cold_fill(i) = Ground_LH2_total(idle_3_index) - Ground_LH2_total(idle_2_index);
        LH2_in_AC_tank_cold_fill(i) = AC_LH2_total(idle_3_index) - AC_LH2_total(idle_2_index);
        frac_useful_LH2_cold_fill(i) = LH2_in_AC_tank_cold_fill(i)/LH2_consumed_cold_fill(i);

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);
        else
            disp("Error spotted, handling in graphing")
            hose_thermal_conductivity_vec(i) = [0];
        end

    end

    hose_thermal_conductivity_vec_copy = [];
    LH2_consumed_warm_fill_copy = [];
    LH2_in_AC_tank_warm_fill_copy = [];
    frac_useful_LH2_warm_fill_copy = [];
    LH2_consumed_cold_fill_copy = [];
    LH2_in_AC_tank_cold_fill_copy = [];
    frac_useful_LH2_cold_fill_copy = [];
    time_warm_refuel_copy = [];

    for i = 1:length(hose_insulation_sweep_simOut)
        if hose_thermal_conductivity_vec(i) ~= [0]
            hose_thermal_conductivity_vec_copy = [hose_thermal_conductivity_vec_copy, 
                hose_thermal_conductivity_vec(i)];
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

    hose_thermal_conductivity_vec = hose_thermal_conductivity_vec_copy;
    LH2_consumed_warm_fill = LH2_consumed_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    frac_useful_LH2_warm_fill = frac_useful_LH2_warm_fill_copy;
    LH2_consumed_cold_fill = LH2_consumed_cold_fill_copy;
    LH2_in_AC_tank_cold_fill = LH2_in_AC_tank_cold_fill_copy;
    frac_useful_LH2_cold_fill = frac_useful_LH2_cold_fill_copy;
    time_warm_refuel = time_warm_refuel_copy;


figure(101)
plot(hose_thermal_conductivity_vec, time_warm_refuel)
xlabel("Hose thermal conductivity (W/m K)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", "with different hose thermal conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs Hose conductivity.png')


figure(102)
plot(hose_thermal_conductivity_vec, LH2_consumed_warm_fill)
xlabel("Hose thermal conductivity (W/m K)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", "with different hose thermal conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs Hose conductivity.png')

figure(103)
plot(hose_thermal_conductivity_vec, LH2_consumed_warm_fill)
xlabel("Hose thermal conductivity (W/m K)")
ylabel('LH2 consumed percentage (%)')
title({"Total LH2 consumed for for cold tank refuel", "with different hose thermal conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed percentage warm tank filling vs Hose conductivity.png')


end