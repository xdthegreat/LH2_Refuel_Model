


function tank_wall_liquid_heat_transfer_coeff_graphing(tank_wall_liquid_heat_transfer_coeff_simOut, ...
    liquid_heat_transfer_coeff_vector)


[liquid_heat_transfer_coeff_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
    turn_simOut_into_graphing_data(tank_wall_liquid_heat_transfer_coeff_simOut, liquid_heat_transfer_coeff_vector);

figure(101)
plot(liquid_heat_transfer_coeff_vector_output, LH2_consumed_warm_fill_output)
xlabel("Liquid heat transfer coefficient (W/K m^2)")
ylabel('LH2 consumed (kg)')
title({"Total LH2 consumed for warm tank refuel with", ...
    "different UAM tank wall liquid heat transfer coefficient"})
set(gca, 'XScale', 'log')
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs UAM tank wall liquid heat transfer coefficient.png')


end