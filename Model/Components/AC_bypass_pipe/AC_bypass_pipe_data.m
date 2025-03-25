

%default settings
AC_bypass_pipe_length = 0.6;
AC_bypass_line_port_outer_diameter = 0.25;
mass_per_length_bypass = steel_density*wall_thickness*(AC_bypass_line_port_inner_diameter ...
    + AC_bypass_line_port_outer_diameter);
thermal_mass_per_length_bypass = steel_density*wall_thickness*AC_bypass_line_port_inner_diameter*pi;