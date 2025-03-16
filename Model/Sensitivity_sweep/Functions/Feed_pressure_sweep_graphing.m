


function Feed_pressure_sweep_graphing(Feed_pressure_sweep_simOut, LH2_FEED_PRES_VEC)


[LH2_FEED_PRES_VEC_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(Feed_pressure_sweep_simOut, LH2_FEED_PRES_VEC);

figure(101)
plot(LH2_FEED_PRES_VEC_output*10, time_warm_refuel_output)
xlabel("LH2 feed pressure (bar)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", "with different LH2 feed pressure"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs LH2 feed pres.png')



figure(102)
plot(LH2_FEED_PRES_VEC_output*10, LH2_consumed_warm_fill_output)
xlabel("LH2 feed pressure (bar)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for for cold tank refuel", ...
    "with different LH2 feed pressure"})
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs LH2 feed pressure.png')


end