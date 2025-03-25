

%default settings
AC_engine_feed_pipe_length = 0.5;
AC_engine_feed_port_outer_diameter = 0.05;
mass_per_length_supply = steel_density*wall_thickness*(AC_engine_feed_port_inner_diameter ...
    + AC_engine_feed_port_outer_diameter);
thermal_mass_per_length_engine_feed = steel_density*wall_thickness*AC_engine_feed_port_inner_diameter*pi;