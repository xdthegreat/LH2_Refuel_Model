

function valve_diameter_sweep_graphing(valve_diameter_sweep_simOut, valve_diameter_vector)
    
    
    [valve_diameter_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(valve_diameter_sweep_simOut, valve_diameter_vector);
    
    figure(101)
    plot(valve_diameter_vector_output, time_warm_refuel_output)
    xlabel("Reference valve orifice diameter (m)")
    ylabel('Time taken per warm tank refuel (s)')
    title({"Time taken for for warm tank refuel", ...
        "with different valve orifice diameter"})
    saveas(gcf, 'Graphs/Time taken for warm tank refuel vs valve diameter.png')


        valve_diameter_sweep_results = {valve_diameter_vector_output, time_warm_refuel_output, LH2_consumed_warm_fill_output};
    
valve_diameter_results_table = cell2table(valve_diameter_sweep_results, ...
    'VariableNames', {'Lh2 Feed pressure (bar)' 'Time taken for warm tank refuel (s)' 'LH2 consumed(kg)'});
    writetable(valve_diameter_results_table, "Graphs/vaalve_diameter_sweep_results.xlsx")

end