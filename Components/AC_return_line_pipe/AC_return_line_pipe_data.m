

%default settings
AC_return_pipe_length = 0.5;
AC_return_line_port_outer_diameter = 0.1;
mass_per_length_return = steel_density*wall_thickness*(AC_return_line_port_inner_diameter ...
    + AC_return_line_port_outer_diameter);
thermal_mass_per_length_return = steel_density*wall_thickness*AC_return_line_port_inner_diameter;