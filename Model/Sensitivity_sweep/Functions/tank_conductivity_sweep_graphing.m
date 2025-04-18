


function tank_conductivity_sweep_graphing(tank_conductivity_sweep_simOut, ...
    AC_tank_equivalent_conductivity_vector)



[AC_tank_equivalent_conductivity_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(tank_conductivity_sweep_simOut, AC_tank_equivalent_conductivity_vector);




figure(100)
plot(AC_tank_equivalent_conductivity_vector_output, time_warm_refuel_output)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", ...
    "with different insulation equivalent conductivity"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs UAM tank insulation conductivity.png')



figure(101)
plot(AC_tank_equivalent_conductivity_vector_output, time_cold_refuel_output)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per cold tank refuel (s)')
title({"Time taken for for cold tank refuel", ...
    "with different insulation equivalent conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for cold tank refuel vs UAM tank insulation conductivity.png')


figure(102)
plot(AC_tank_equivalent_conductivity_vector_output, time_warm_refuel_output)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('Time taken per cold tank refuel (s)')
title({"Time taken for for cold tank refuel", ...
    "with different insulation equivalent conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for warm tank filling vs UAM tank insulation conductivity.png')


figure(102)
plot(AC_tank_equivalent_conductivity_vector_output, LH2_consumed_cold_fill_output)
xlabel("Insulation equivalent conductivity (W/mK)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", ...
    "with different insulation equivalent conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Lh2 consumed for warm tank filling vs UAM tank insulation conductivity.png')


AC_tank_conductivity_sweep_results = [AC_tank_equivalent_conductivity_vector_output,...
    LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output];


AC_tank_conductivity_results_table = array2table(AC_tank_conductivity_sweep_results, ...
        'VariableNames', {'Insulation equivalent conductivity (W/mK)' 'LH2 consumed warm tank refuel (kg)' ...
    'LH2 received warm tank refuel (kg)' 'Fraction of useful LH2 for warm tank refuel' ...
    'LH2 consumed cold tank refuel (kg)' 'LH2 received cold tank refuel (kg)' ...
    'Fraction of useful LH2 for cold tank refuel' 'Time taken for warm tank refuel (s)'...
    'Time taken for cold tank refuel (s)'});
    
    writetable(AC_tank_conductivity_results_table, "Graphs/AC_tank_conductivity_sweep_results.xlsx")
    delete('Graphs\AC_tank_conductivity_sweep_results.xlsx')
writetable(AC_tank_conductivity_results_table, "Graphs/AC_tank_conductivity_sweep_results.xlsx")

end