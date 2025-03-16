


function hose_length_graphing(hose_length_sweep_simOut, hose_length_vector)

%plot length of hose against LH2 used
[hose_length_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(hose_length_sweep_simOut, hose_length_vector);

    figure(101)
    plot(hose_length_vector_output, LH2_consumed_warm_fill_output)
    xlabel("Length of flexible hoses (m)")
    ylabel('LH2 consumed (kg)')
    title({"Total amount of LH2 consumed for warm tank", ...
        "refuel with different lengths of hoses"})
    saveas(gcf, 'Graphs/LH2 consumption for warm tank refuel sweep with 5-20m hoses.png')


end