

pipe_thermal = "pipe_thermal_model";

simOut = sim(pipe_thermal);

pipe_thermal_watt_rates = mean(simOut.yout{1}.Values.Data) + mean(simOut.yout{3}.Values.Data);
pipe_conductive_equivalent = pipe_thermal_watt_rates/2/pi*log((wall_thickness*2 + AC_supply_line_port_inner_diameter)...
    /AC_supply_line_port_inner_diameter);