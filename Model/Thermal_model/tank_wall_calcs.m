

tank_thermal_model = "Tank_thermal_model";

simOut = sim(tank_thermal_model);

thermal_watt_rates = mean(simOut.yout{1}.Values.Data) + mean(simOut.yout{3}.Values.Data);
tank_conductive_equivalent = thermal_watt_rates/AC_tank_surface_area/(Ambient_temp - 20)*AC_wall_thickness;