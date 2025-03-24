


function Feed_pressure_sweep_graphing(Feed_temp_sweep_simOut, FEED_PRES_VEC)



[LH2_FEED_PRES_VEC_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(Feed_temp_sweep_simOut, FEED_PRES_VEC);


figure(101)
plot(LH2_FEED_PRES_VEC_output, time_warm_refuel_output)
xlabel("LH2 feed pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel with", "different LH2 feed pressure"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs LH2 feed pres.png')


figure(102)
plot(LH2_FEED_PRES_VEC_output, LH2_consumed_warm_fill_output)
xlabel("LH2 feed pressure (bar)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", "with different LH2 feed pressure"})
saveas(gcf, 'Graphs/LH2 consumed for cold tank filling vs LH2 feed pres.png')



feed_temp_sweep_results = [LH2_FEED_PRES_VEC_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output];
    
    
    feed_temp_sweep_results_table = array2table(feed_temp_sweep_results, ...
    'VariableNames', {'LH2 Feed pressure (MPa)' 'LH2 consumed warm tank refuel (kg)' ...
    'LH2 received warm tank refuel (kg)' 'Fraction of useful LH2 for warm tank refuel' ...
    'LH2 consumed cold tank refuel (kg)' 'LH2 received cold tank refuel (kg)' ...
    'Fraction of useful LH2 for cold tank refuel' 'Time taken for warm tank refuel (s)'...
    'Time taken for cold tank refuel (s)'});

    writetable(feed_temp_sweep_results_table, "Graphs/feed_pressure_sweep_results.xlsx")
    delete('Graphs\feed_pressure_sweep_results.xlsx')
    writetable(feed_temp_sweep_results_table, "Graphs/feed_pressure_sweep_results.xlsx")

end