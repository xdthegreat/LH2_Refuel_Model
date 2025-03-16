
function valve_discharge_coeff_sweep_graphing(valve_discharge_coeff_sweep_simOut, valve_discharge_coeff_vector)


[valve_discharge_coeff_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(valve_discharge_coeff_sweep_simOut, valve_discharge_coeff_vector);

    
    figure(101)
    plot(valve_discharge_coeff_vector_output, time_warm_refuel_output)
    xlabel("Valve discahrge coefficient")
    ylabel('Time taken per warm tank refuel (s)')
    title({"Time taken for for warm tank refuel", ...
        "with different valve discharge coefficient"})
    saveas(gcf, 'Graphs/Time taken for warm tank refuel vs valve coeff.png')

end