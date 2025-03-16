

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

% TODO: calc all pipe heat transfer coefficients
%   pipe_W_per_m = conductivity_to_w_per_m(conductivity, ...
%     inner_dia, outer_dia, delta_T);
% disp()



% GS

disp("GS safety vent one-way check valve discharge coefficient is " + GS_vent_discharge_coeff)
disp("GS safety vent one-way check valve orifice diameter is " + GS_vent_inner_diameter + "m.")
disp("GS safety vent one-way check valve cracking pressure is " + GS_vent_cracking_delta_P + "bar.")
disp("GS safety vent one-way check valve fully open pressure is " + GS_vent_open_delta_P + "bar.")


disp("GS GH2 supply line proportional valve discharge coefficient is " + Gas_prop_valve_discharge_coeff)
disp("GS GH2 supply line proportional valve orifice diameter is " + Gas_prop_valve_inner_diameter + "m.")
disp("GS GH2 supply line proportional valve stroke length is " + Gas_prop_valve_stroke + "m.")
disp("GS GH2 supply line proportional valve actuation speed is " + Gas_prop_valve_gain*Gas_prop_valve_rate_speed + "m/s.")

disp("GS GH2 supply line pipe inner diameter is " + return_pipe_inner_diameter + "m.")


disp("GS LH2 supply line proportional valve discharge coefficient is " + LH2_prop_valve_discharge_coeff)
disp("GS LH2 supply line proportional valve orifice diameter is " + LH2_prop_valve_inner_diameter + "m.")
disp("GS LH2 supply line proportional valve stroke length is " + LH2_prop_valve_stroke + "m.")
disp("GS LH2 supply line proportional valve actuation speed is " + LH2_prop_valve_gain*LH2_prop_valve_rate_speed + "m/s.")

disp("GS LH2 supply line shut-off valve discharge coefficient is " + GS_supply_valve_discharge_coeff)
disp("GS LH2 supply line shut-off valve orifice diameter is " + GS_supply_valve_inner_diameter + "m.")

disp("GS LH2 supply line pipe inner diameter is " + supply_pipe_inner_diameter + "m.")




disp("GS vent line shut-off valve discharge coefficient is " + GS_return_valve_discharge_coeff)
disp("GS vent line shut-off valve orifice diameter is " + GS_return_valve_inner_diameter + "m.")

disp("GS vent line proportional valve discharge coefficient is " + Return_gas_prop_valve_discharge_coeff)
disp("GS vent line proportional valve orifice diameter is " + Return_gas_prop_valve_inner_diameter + "m.")
disp("GS vent line proportional valve stroke length is " + Return_gas_prop_valve_stroke + "m.")
disp("GS vent line proportional valve actuation speed is " + Return_gas_prop_valve_gain*Return_gas_prop_valve_rate_speed + "m/s.")

disp("GS vent line pipe inner diameter is " + return_pipe_inner_diameter + "m.")




disp("GS supply coupling discharge coefficient is " + supply_coupling_discharge_coeff)
disp("GS supply coupling orifice diameter is " + supply_coupling_valve_inner_diameter + "m.")

disp("GS return coupling discharge coefficient is " + return_coupling_discharge_coeff)
disp("GS return coupling orifice diameter is " + return_coupling_valve_inner_diameter + "m.")