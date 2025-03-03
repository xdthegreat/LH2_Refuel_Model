

clc

%% print everything

disp("UAM bypass pipe inner diameter is " + AC_bypass_line_port_inner_diameter + "m.")
disp("UAM bypass pipe length is " + AC_bypass_pipe_length + "m.")
disp("UAM bypass pipe inner wall thickness is " + wall_thickness*1000 + "mm.")


disp("UAM engine feed pipe inner diameter is " + AC_engine_feed_port_inner_diameter + "m.")
disp("UAM engine feed pipe length is " + AC_engine_feed_pipe_length + "m.")
disp("UAM engine feed pipe inner wall thickness is " + wall_thickness*1000 + "mm.")

disp("UAM engine feed shut-off valve discharge coefficient is " + AC_engine_valve_discharge_coeff)
disp("UAM engine feed shut-off valve orifice diameter is " + AC_engine_valve_inner_diameter)



disp("UAM return line pipe inner diameter is " + AC_return_line_port_inner_diameter + "m.")
disp("UAM return line pipe length is " + AC_return_pipe_length + "m.")
disp("UAM return line pipe inner wall thickness is " + wall_thickness*1000 + "mm.")

disp("UAM return line shut-off valve discharge coefficient is " + AC_return_valve_discharge_coeff)
disp("UAM return line shut-off valve orifice diameter is " + AC_return_valve_inner_diameter)



disp("UAM supply line pipe inner diameter is " + AC_supply_line_port_inner_diameter + "m.")
disp("UAM supply line pipe length is " + AC_supply_pipe_length + "m.")
disp("UAM supply line pipe inner wall thickness is " + wall_thickness*1000 + "mm.")

disp("UAM supply line shut-off valve discharge coefficient is " + AC_supply_valve_discharge_coeff)
disp("UAM supply line shut-off valve orifice diameter is " + AC_supply_valve_inner_diameter)



disp("UAM tank wall thermal isolation heat transfer coefficient is " + AC_tank_equivalent_conductivity)
disp("UAM tank wall liquid heat transfer coefficient is " + AC_tank_liquid_heat_transfer_coeff + "W/m^2.")
disp("UAM tank wall vapour heat transfer coefficient is " + AC_tank_vapour_heat_transfer_coeff + "W/m^2.")
disp("UAM tank volume is " + AC_tank_volume + "m^3.")
disp("UAM tank wall thickness is " + wall_thickness*1000 + "mm.")


disp("UAM vent line inner diameter is " + AC_vent_line_port_inner_diameter)
disp("UAM vent line check valve discharge coefficient is " + AC_vent_valve_discharge_coeff)
disp("UAM vent line check valve orifice diameter is " + AC_vent_valve_orifice_inner_diameter + "m.")
