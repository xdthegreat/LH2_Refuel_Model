


function hose_insulation_sweep_graphing(hose_insulation_sweep_simOut, hose_thermal_conductivity_vec)

[hose_thermal_conductivity_vec_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(hose_insulation_sweep_simOut, hose_thermal_conductivity_vec);


figure(101)
plot(hose_thermal_conductivity_vec_output, time_warm_refuel_output)
xlabel("Hose thermal conductivity (W/m K)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", "with different hose thermal conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs Hose conductivity.png')


figure(102)
plot(hose_thermal_conductivity_vec_output, LH2_consumed_warm_fill_output)
xlabel("Hose thermal conductivity (W/m K)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", "with different hose thermal conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs Hose conductivity.png')

figure(103)
plot(hose_thermal_conductivity_vec_output, LH2_consumed_warm_fill_output)
xlabel("Hose thermal conductivity (W/m K)")
ylabel('LH2 consumed percentage (%)')
title({"Total LH2 consumed for for cold tank refuel", "with different hose thermal conductivity"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed percentage warm tank filling vs Hose conductivity.png')

hose_insulation_sweep_results = {hose_thermal_conductivity_vec_output, time_warm_refuel_output, LH2_consumed_warm_fill_output};
    
hose_insulation_results_table = cell2table(hose_insulation_sweep_results, ...
    'VariableNames', {'Lh2 Feed pressure (bar)' 'Time taken for warm tank refuel (s)' 'LH2 consumed(kg)'});
    writetable(hose_insulation_results_table, "Graphs/hose_insulation_sweep_results.xlsx")


end