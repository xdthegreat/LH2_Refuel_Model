%% TODO list:
% figure out tank heat transfer properties

Required_energy = 908;  % MJ
H2_energy_density = 120;    %MJ/kg
Equivalent_battery_mass = Required_energy*10^6/(400*3600);
Generator_efficiency = 0.45;
m_LH2 = Required_energy/H2_energy_density/Generator_efficiency;

% tank_size
LH2_density = 70;
AC_tank_vol_limit = 0.8;
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

GS_vent_cracking_delta_P = 4.4;
GS_vent_open_delta_P = 5;
GS_vent_discharge_coeff = 0.8;
GS_vent_orifice_diameter = 0.12;
GS_vent_orifice_area = GS_vent_orifice_diameter^2*pi/4;
GS_vent_inner_diameter = 0.14;
GS_vent_inner_area = GS_vent_inner_diameter^2*pi/4;


supply_pipe_inner_diameter = 0.1;
supply_pipe_inner_area = supply_pipe_inner_diameter^2*pi/4;
supply_pipe_outer_diameter = 0.13;
supply_pipe_outer_area = supply_pipe_outer_diameter^2*pi/4;
supply_valve_orifice_diameter = 0.09;
supply_valve_orifice_area = supply_valve_orifice_diameter^2*pi/4;

return_pipe_inner_diameter = 0.1;
return_pipe_inner_area = return_pipe_inner_diameter^2*pi/4;
return_pipe_outer_diameter = 0.13;
return_pipe_outer_area = return_pipe_outer_diameter^2*pi/4;
return_valve_orifice_diameter = 0.09;
return_valve_orifice_area = return_valve_orifice_diameter^2*pi/4;

wall_thickness = 2/1000;

mass_per_length_supply = steel_density*wall_thickness*(supply_pipe_inner_area + supply_pipe_outer_area);
mass_per_length_return = steel_density*wall_thickness*(return_pipe_inner_area + return_pipe_outer_area);

hose_length = 20;  %m

hose_thermal_conductivity = 0.0002;  %W/m*K
pipe_thermal_conductivity = 0.0001;  %W/m*K
liquid_supply_SOV_leak_frac = 1e-9;

%Controller info
timestep = 0.1;
PID_timestep = 0.01;
tf_delay = 1e-6;
vent_tf_delay = 1e-4;
AC_LH2_TARGET_DELTA_P = 0.04;
AC_GH2_TARGET_DELTA_P = 0.045;
LH2_FEED_PRES = 0.3; %bar
GH2_FEED_PRES = 0.2; %bar
IDLE_FEED_PRES = 0.11; %bar


%case info:
LH2_Feed_Temp = 20;
Ambient_temp = 300;
Initial_temp = 300;
Initial_AC_LH2_frac = 0;
Initial_AC_tank_pressure = 1.1;
Initial_AC_Tank_Liquid_Temp = 20;
Initial_AC_Tank_Gas_Temp = 300;
initial_hose_p = 1.1;
stopTime = 4000;

valve_laminar_p_ratio = 0.999;