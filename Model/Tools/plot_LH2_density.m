

clc
close all


mesh(short_temp_vector, short_pressure_vector/10^5, LH2_density_table)
title("Density of LH2 between 20-25K and 1-5bar")
xlabel("Temperature (K)")
xlim([20, 25])
ylabel("Pressure (bar)")
ylim([1, 5])
saveas(gcf, 'Nicer_graphs/LH2_density.png')

