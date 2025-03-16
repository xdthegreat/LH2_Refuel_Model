


function hose_length_graphing(hose_length_sweep_simOut, hose_length_vector)

%plot length of hose against LH2 used

LH2_consumed = zeros([1, length(hose_length_vector)]);
LH2_in_AC_tank = zeros([1, length(hose_length_vector)]);
Ground_LH2_total_time = zeros([1, length(hose_length_vector)]);

    for i = 1:length(hose_length_sweep_simOut)
        if isempty(hose_length_sweep_simOut(1, i).ErrorMessage)
        [start_warm_chilldown_index, start_warm_tank_fill_index, ...
        start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
        start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
        start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
        start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
        = multiple_sim_phase_parsing(hose_length_sweep_simOut(1, i), i);



        Ground_LH2_total = hose_length_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = hose_length_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = hose_length_sweep_simOut(1, i).yout{4}.Values.Time;
    
        % disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
        % disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

        LH2_consumed(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank(i) = AC_LH2_total(idle_1_index);

        else
            disp("Error spotted, handling in graphing")
            hose_length_vector(i) = [0];
        end

    hose_length_vector_copy = [];
    LH2_consumed_warm_fill_copy = [];
    LH2_in_AC_tank_warm_fill_copy = [];
    LH2_in_AC_tank_warm_fill_copy = [];
    frac_useful_LH2_warm_fill_copy = [];
    LH2_consumed_cold_fill_copy = [];
    LH2_in_AC_tank_cold_fill_copy = [];
    frac_useful_LH2_cold_fill_copy = [];
    time_warm_refuel_copy = [];

    for i = 1:length(hose_insulation_sweep_simOut)
        if hose_length_vector(i) ~= [0]
            hose_length_vector_copy = [hose_length_vector_copy, 
                hose_length_vector(i)];
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

    hose_length_vector = hose_length_vector_copy;
    LH2_consumed_warm_fill = LH2_consumed_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    LH2_in_AC_tank_warm_fill = LH2_in_AC_tank_warm_fill_copy;
    frac_useful_LH2_warm_fill = frac_useful_LH2_warm_fill_copy;
    LH2_consumed_cold_fill = LH2_consumed_cold_fill_copy;
    LH2_in_AC_tank_cold_fill = LH2_in_AC_tank_cold_fill_copy;
    frac_useful_LH2_cold_fill = frac_useful_LH2_cold_fill_copy;
    time_warm_refuel = time_warm_refuel_copy;
    end
    
    figure(10)
    plot(hose_length_vector, LH2_consumed)
    xlabel("Length of flexible hoses (m)")
    ylabel('LH2 consumed (kg)')
    title({"Total amount of LH2 consumed for warm tank", ...
        "refuel with different lengths of hoses"})
    saveas(gcf, 'Graphs/LH2 consumption for warm tank refuel sweep with 5-20m hoses.png')


end