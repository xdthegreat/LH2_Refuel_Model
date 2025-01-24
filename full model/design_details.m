

Required_energy = 2667;  % MJ
Generator_efficiency = 0.3;
m_LH2 = Required_energy/H2_energy_density/Generator_efficiency;

% tank_size
AC_tank_volume = m_LH2/LH2_density/0.8;
AC_tank_radius = 0.5;
AC_tank_cross_sectional_area = AC_tank_radius^2*pi;
AC_tank_surface_area = AC_tank_cross_sectional_area*2 + AC_tank_radius*2*pi*AC_tank_volume/AC_tank_cross_sectional_area;
AC_wall_thickness = 5/1000;

% refuel volumetric flow rates
refuel_time = 3; %mins
mass_flow_rate = m_LH2/refuel_time/60;

% design limits
max_pressure = 6;  %bar
max_stress = 300;  %MPa
Ambient_temp = 300;

supply_pipe_inner_diameter = 0.02; %m
supply_pipe_outer_diameter = 0.05;
supply_pipe_inner_area = supply_pipe_inner_diameter^2*pi;
supply_pipe_outer_area = supply_pipe_outer_diameter^2*pi;
supply_valve_orifice_radius = 0.015;
supply_valve_orifice_area = supply_valve_orifice_radius^2*pi;

return_pipe_inner_diameter = 0.05;
return_pipe_outer_diameter = 0.08;
return_pipe_inner_area = return_pipe_inner_diameter^2*pi;
return_pipe_outer_area = return_pipe_outer_diameter^2*pi;

wall_thickness = 1/1000;

mass_per_length_supply = steel_density*wall_thickness*(supply_pipe_inner_area + supply_pipe_outer_area);
mass_per_length_return = steel_density*wall_thickness*(return_pipe_inner_area + return_pipe_outer_area);


hose_length = 20;  %m

% supplier info

hose_thermal_conductivity = 0.01;  %W/(m*K)
pipe_thermal_conductivity = 0.005;  %W/(m*K)
