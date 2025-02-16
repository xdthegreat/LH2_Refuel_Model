

clc
close all


mesh(short_temp_vector, short_pressure_vector/10^5, LH2_density_table)
xlabel("Temperature (K)")
ylabel("Pressure (bar)")