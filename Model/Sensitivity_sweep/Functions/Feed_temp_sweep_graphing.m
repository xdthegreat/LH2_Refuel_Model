


function Feed_temp_sweep_graphing(Feed_temp_sweep_simOut, LH2_FEED_TEMP_VEC)



[LH2_FEED_TEMP_VEC_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(Feed_temp_sweep_simOut, LH2_FEED_TEMP_VEC);


figure(101)
plot(LH2_FEED_TEMP_VEC_output, time_warm_refuel_output)
xlabel("LH2 feed temperature (K)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel with", "different LH2 feed temperature"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs LH2 feed temp.png')


figure(102)
plot(LH2_FEED_TEMP_VEC_output, LH2_consumed_warm_fill_output)
xlabel("LH2 feed temperature (K)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", "with different LH2 feed temperature"})
saveas(gcf, 'Graphs/LH2 consumed for cold tank filling vs LH2 feed temp.png')



feed_temp_sweep_results = [LH2_FEED_TEMP_VEC_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output];
    
    
feed_temp_sweep_results_table = array2table(feed_temp_sweep_results, ...
'VariableNames', {'LH2 Feed temperature (K)' 'LH2 consumed warm tank refuel (kg)' ...
    'LH2 received warm tank refuel (kg)' 'Fraction of useful LH2 for warm tank refuel' ...
    'LH2 consumed cold tank refuel (kg)' 'LH2 received cold tank refuel (kg)' ...
    'Fraction of useful LH2 for cold tank refuel' 'Time taken for warm tank refuel (s)'...
    'Time taken for cold tank refuel (s)'});

    writetable(feed_temp_sweep_results_table, "Graphs/feed_temp_sweep_results.xlsx")
    delete('Graphs\feed_temp_sweep_results.xlsx')
    writetable(feed_temp_sweep_results_table, "Graphs/feed_temp_sweep_results.xlsx")

end