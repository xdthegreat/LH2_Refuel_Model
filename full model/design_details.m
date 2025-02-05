%% TODO list:
% figure out tank heat transfer properties

Required_energy = 1000;  % MJ
H2_energy_density = 120;    %MJ/kg
Equivalent_battery_mass = Required_energy*10^6/(400*3600);
Generator_efficiency = 0.3;
m_LH2 = Required_energy/H2_energy_density/Generator_efficiency;

% tank_size
LH2_density = 70;
AC_tank_vol_limit = 0.7;
AC_tank_volume = m_LH2/LH2_density/AC_tank_vol_limit;
AC_tank_radius = 0.5;
AC_tank_cross_sectional_area = AC_tank_radius^2*pi;
AC_tank_surface_area = AC_tank_cross_sectional_area*2 + AC_tank_radius*2*pi*AC_tank_volume/AC_tank_cross_sectional_area;
AC_wall_thickness = 2/1000;
AC_tank_weight = AC_wall_thickness*AC_tank_surface_area*steel_density*2;

% refuel volumetric flow rates
refuel_time = 3; %mins
mass_flow_rate = m_LH2/refuel_time/60;

% design limits
max_pressure = 6;  %bar
max_stress = 300;  %MPa
Ambient_temp = 300;

supply_pipe_inner_diameter = 0.0254; %m
supply_pipe_outer_diameter = 0.05;
supply_pipe_inner_area = supply_pipe_inner_diameter^2*pi;
supply_pipe_outer_area = supply_pipe_outer_diameter^2*pi;
supply_valve_orifice_radius = 0.024;
supply_valve_orifice_area = supply_valve_orifice_radius^2*pi;
supply_valve_discharge_ratio = 0.64;

return_pipe_inner_diameter = 0.05;
return_pipe_outer_diameter = 0.08;
return_pipe_inner_area = return_pipe_inner_diameter^2*pi;
return_pipe_outer_area = return_pipe_outer_diameter^2*pi;
return_valve_orifice_radius = 0.045;
return_valve_orifice_area = return_valve_orifice_radius^2*pi;
return_valve_discharge_ratio = 0.64;

engine_feed_pipe_inner_diameter = 0.0254;
engine_feed_pipe_outer_diameter = 0.05;
engine_feed_pipe_inner_area = engine_feed_pipe_inner_diameter^2*pi;
engine_feed_pipe_outer_area = engine_feed_pipe_outer_diameter^2*pi;
engine_feed_valve_orifice_radius = 0.02;
engine_feed_valve_orifice_area = engine_feed_valve_orifice_radius^2*pi;
engine_feed_valve_discharge_ratio = 0.64;

wall_thickness = 2/1000;

mass_per_length_supply = steel_density*wall_thickness*(supply_pipe_inner_area + supply_pipe_outer_area);
mass_per_length_return = steel_density*wall_thickness*(return_pipe_inner_area + return_pipe_outer_area);
mass_per_length_engine_feed = steel_density*wall_thickness*(engine_feed_pipe_inner_area + engine_feed_pipe_outer_area);


hose_length = 20;  %m

% supplier info

hose_thermal_conductivity = 0.01;  %W/(m*K)
pipe_thermal_conductivity = 0.005;  %W/(m*K)
liquid_supply_SOV_leak_frac = 1e-9;

%Controller info
timestep = 0.5;

%case info:
Initial_temp = 300;
Initial_AC_LH2_frac = 0;
Initial_AC_tank_pressure = 1.1;
Initial_AC_Tank_Liquid_Temp = 20;
Initial_AC_Tank_Gas_Temp = 300;
initial_hose_p = 1.1;
stopTime = 900;