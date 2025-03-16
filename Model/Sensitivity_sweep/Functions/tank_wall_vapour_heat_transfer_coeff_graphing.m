

function tank_wall_vapour_heat_transfer_coeff_graphing(tank_wall_vapour_heat_transfer_coeff_simOut,...
    vapour_heat_transfer_coeff_vector)

[vapour_heat_transfer_coeff_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(tank_wall_vapour_heat_transfer_coeff_simOut, vapour_heat_transfer_coeff_vector);
    
    figure(101)
    plot(vapour_heat_transfer_coeff_vector_output, LH2_consumed_warm_fill_output)
    xlabel("Vapour heat transfer coefficient (W/K m^2)")
    ylabel('LH2 consumed (kg)')
    title({"Total LH2 consumed for warm tank refuel with", ...
        "different UAM tank wall vapour heat transfer coefficient"})
    set(gca, 'XScale', 'log')
    saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs UAM tank wall vapour heat transfer coefficient.png')
   

    vapour_heat_sweep_results = {vapour_heat_transfer_coeff_vector_output, time_warm_refuel_output, LH2_consumed_warm_fill_output};
    
vapour_heat_results_table = cell2table(vapour_heat_sweep_results, ...
    'VariableNames', {'Lh2 Feed pressure (bar)' 'Time taken for warm tank refuel (s)' 'LH2 consumed(kg)'});
    writetable(vapour_heat_results_table, "Graphs/vapour_heat_sweep_results.xlsx")


end