


function Tank_size_sweep_graphing(Tank_size_sweep_simOut, m_LH2_vector)


[m_LH2_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(Tank_size_sweep_simOut, m_LH2_vector);


figure(101)
plot(m_LH2_vector_output, frac_useful_LH2_warm_fill_output)
xlabel("Tank maximum (kg)")
ylabel('Fraction of LH2 in the tank/fraction of LH2 consumed')
title({"Fraction of useful LH2 for warm tank", "refuel with different tank sizes"})
saveas(gcf, 'Graphs/Fraction of useful LH2 vs tank size warm tank refuel.png')

figure(102)
plot(m_LH2_vector_output, frac_useful_LH2_cold_fill_output)
xlabel("Tank maximum (kg)")
ylabel('Fraction of LH2 in the tank/ fraction of LH2 in consumed')
title({"Fraction of useful LH2 for cold tank", "refuel with different tank sizes"})
saveas(gcf, 'Graphs/Fraction of useful LH2 vs tank size cold tank refuel.png')


figure(103)
plot(m_LH2_vector_output, time_warm_refuel_output)
xlabel("Tank maximum (kg)")
ylabel('Time taken per warm tank refuel (s)')
title({"Time taken for for warm tank refuel", ...
    "with different tank sizes"})
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs tank size warm tank refuel.png')


end