

%default settings
AC_supply_pipe_length = 0.5;
AC_supply_line_port_outer_diameter = 0.08;
mass_per_length_supply = steel_density*wall_thickness*(AC_supply_line_port_inner_diameter ...
    + AC_supply_line_port_outer_diameter);
thermal_mass_per_length_supply = steel_density*wall_thickness*AC_supply_line_port_inner_diameter;