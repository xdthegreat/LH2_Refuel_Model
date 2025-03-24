


function UAM_tank_pressure_sweep_graphing(Feed_pressure_sweep_simOut, TARGET_TANK_PRES)


[TARGET_TANK_PRES_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(Feed_pressure_sweep_simOut, TARGET_TANK_PRES);

figure(101)
plot(TARGET_TANK_PRES_output*10, time_warm_refuel_output)
xlabel("UAM target tank pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refueling", ...
    "with different target tank pressure"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs UAM target tank pres.png')


figure(102)
plot(TARGET_TANK_PRES_output*10, LH2_consumed_warm_fill_output)
xlabel("UAM target tank pressure (bar)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for warm tank refuel", ...
    "with different target tank pressure"})
saveas(gcf, 'Graphs/LH2 consumed for warm tank refueling vs UAM target tank pressure.png')


feed_pressure_sweep_results = [TARGET_TANK_PRES_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output];
    

feed_pressure_sweep_results_table = array2table(feed_pressure_sweep_results, ...
    'VariableNames', {'UAM target tank pressure (MPa)' 'LH2 consumed warm tank refuel (kg)' ...
    'LH2 received warm tank refuel (kg)' 'Fraction of useful LH2 for warm tank refuel' ...
    'LH2 consumed cold tank refuel (kg)' 'LH2 received cold tank refuel (kg)' ...
    'Fraction of useful LH2 for cold tank refuel' 'Time taken for warm tank refuel (s)'...
    'Time taken for cold tank refuel (s)'});


    writetable(feed_pressure_sweep_results_table, "Graphs/target_tank_pressure_sweep_results.xlsx")
    delete('Graphs\target_tank_pressure_sweep_results.xlsx')
    writetable(feed_pressure_sweep_results_table, "Graphs/target_tank_pressure_sweep_results.xlsx")


end