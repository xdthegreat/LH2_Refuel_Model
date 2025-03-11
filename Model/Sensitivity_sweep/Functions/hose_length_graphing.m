


function hose_length_graphing(hose_length_sweep_simOut, hose_length_vector)

%plot length of hose against LH2 used

LH2_consumed = zeros([1, length(hose_length_vector)]);
LH2_in_AC_tank = zeros([1, length(hose_length_vector)]);

    for i = 1:length(hose_length_sweep_simOut)
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

    end


    figure(10)
    plot(hose_length_vector, LH2_consumed)
    xlabel("Length of flexible hoses (m)")
    ylabel('LH2 consumed (kg)')
    title("Total amount of LH2 consumed for warm tank \n refuel with different lengths of hoses")
    saveas(gcf, 'Graphs/LH2 consumption for warm tank refuel sweep with 5-20m hoses.png')


end