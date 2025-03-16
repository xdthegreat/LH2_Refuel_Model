

%% RUN_EVERYTHING.m
% This script runs all of the parameter sweeps. Good luck

clc
delete('Graphs\Sweep_log.txt')
diary('Graphs\Sweep_log.txt')
datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z')

%% start setting up

rapid_flag = false;
accel_flag = false;
fast_restart_flag = true;
max_allowed_stop_time = 4000;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end


% select number of cases
normal_flow_rate_sweep_count = 1;
LH2_usage_sweep_count = 1;
valve_diameter_sweep_count = 10;
valve_discharge_coeff_sweep_count = 20;
tank_wall_vapour_heat_transfer_coeff_count = 20;
tank_wall_liquid_heat_transfer_coeff_count = 20;
hose_length_sweep_count = 20;
AC_tank_equivalent_conductivity_count = 20;
tank_size_count = 20;
LH2_FEED_PRES_COUNT = 20;
LH2_FEED_TEMP_COUNT = 20;
hose_thermal_conductivity_count = 20;


%sweep pos calc
normal_flow_rate_sweep_pos = normal_flow_rate_sweep_count;
LH2_usage_sweep_pos = normal_flow_rate_sweep_pos;
valve_diameter_sweep_pos = LH2_usage_sweep_pos + valve_diameter_sweep_count;
valve_discharge_coeff_sweep_pos = valve_diameter_sweep_pos+ valve_discharge_coeff_sweep_count;
tank_wall_vapour_heat_transfer_coeff_pos = valve_discharge_coeff_sweep_pos+ tank_wall_vapour_heat_transfer_coeff_count;
tank_wall_liquid_heat_transfer_coeff_pos = tank_wall_vapour_heat_transfer_coeff_pos + tank_wall_liquid_heat_transfer_coeff_count;
hose_length_sweep_pos = tank_wall_liquid_heat_transfer_coeff_pos + hose_length_sweep_count;
AC_tank_equivalent_conductivity_pos = hose_length_sweep_pos + AC_tank_equivalent_conductivity_count;
tank_size_pos =  AC_tank_equivalent_conductivity_pos + tank_size_count;
LH2_FEED_PRES_POS = tank_size_pos + LH2_FEED_PRES_COUNT;
LH2_FEED_TEMP_POS = LH2_FEED_PRES_POS + LH2_FEED_TEMP_COUNT;
hose_thermal_conductivity_pos = LH2_FEED_TEMP_POS + hose_thermal_conductivity_count;



% setup simIn
clear simIn simOut
normal_flow_rate_simIn = normal_flow_rate_setup(rapid_flag, accel_flag, mdl);

[valve_diameter_sweep_simIn, valve_diameter_vector] = valve_diameter_sweep_setup(rapid_flag, accel_flag, ...
    mdl, valve_diameter_sweep_count, max_allowed_stop_time);

[valve_discharge_coeff_sweep_simIn, valve_discharge_coeff_vector] = ...
    valve_discharge_coeff_sweep_setup(rapid_flag, accel_flag, mdl, valve_discharge_coeff_sweep_count, max_allowed_stop_time); 

[tank_wall_vapour_heat_transfer_coeff_simIn, vapour_heat_transfer_coeff_vector] = ...
    tank_wall_vapour_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_vapour_heat_transfer_coeff_count, max_allowed_stop_time);

[tank_wall_liquid_heat_transfer_coeff_simIn, liquid_heat_transfer_coeff_vector] = ...
    tank_wall_liquid_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_liquid_heat_transfer_coeff_count, max_allowed_stop_time);

[hose_length_sweep_simIn, hose_length_vector] = hose_length_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_length_sweep_count, max_allowed_stop_time);

[tank_conductivity_sweep_simIn, AC_tank_equivalent_conductivity_vector] = ...
    tank_conductivity_sweep_setup(rapid_flag, accel_flag, mdl, AC_tank_equivalent_conductivity_count,...
    max_allowed_stop_time, Ambient_temp, AC_wall_thickness);

[Tank_size_sweep_simIn, m_LH2_vector] = ...
    Tank_size_sweep_setup(rapid_flag, accel_flag, mdl, tank_size_count, max_allowed_stop_time, ...
    AC_tank_vol_limit, AC_tank_cross_sectional_area, AC_tank_radius);

[Feed_pressure_sweep_simIn, LH2_FEED_PRES_VEC] = Feed_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time);

[Feed_temp_sweep_simIn, LH2_Feed_Temp_vec] = Feed_temp_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_TEMP_COUNT, max_allowed_stop_time);

[hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_thermal_conductivity_count, max_allowed_stop_time);


% shove everything in one simIn

simIn = [normal_flow_rate_simIn, valve_diameter_sweep_simIn, valve_discharge_coeff_sweep_simIn, ...
    tank_wall_vapour_heat_transfer_coeff_simIn, tank_wall_liquid_heat_transfer_coeff_simIn, ...
    hose_length_sweep_simIn, tank_conductivity_sweep_simIn, Tank_size_sweep_simIn, ...
    Feed_pressure_sweep_simIn, Feed_temp_sweep_simIn, hose_insulation_sweep_simIn];


%% actual simulation
tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

%% save results

% save("Graphs/simOut.mat", "simOut", '-v7.3')
% zip('Graphs/simOut.zip', 'Graphs/simOut.mat')

%% graphing

close all
normal_flow_rate_graphing(simOut(1, normal_flow_rate_sweep_pos), AC_supply_line_port_inner_area)
close all
LH2_usage_graphing(simOut(1, LH2_usage_sweep_pos))
close all
valve_diameter_sweep_graphing(simOut(1, LH2_usage_sweep_pos+1:valve_diameter_sweep_pos), valve_diameter_vector)
close all
valve_discharge_coeff_sweep_graphing(simOut(1, valve_diameter_sweep_pos+1:valve_discharge_coeff_sweep_pos),...
    valve_discharge_coeff_vector);
close all
tank_wall_vapour_heat_transfer_coeff_graphing(simOut(1, valve_discharge_coeff_sweep_pos+1:tank_wall_vapour_heat_transfer_coeff_pos),...
    vapour_heat_transfer_coeff_vector);
close all
tank_wall_liquid_heat_transfer_coeff_graphing(simOut(1, tank_wall_vapour_heat_transfer_coeff_pos+1:tank_wall_liquid_heat_transfer_coeff_pos),...
    liquid_heat_transfer_coeff_vector);
close all
hose_length_graphing(simOut(1, tank_wall_liquid_heat_transfer_coeff_pos+1:hose_length_sweep_pos), ...
    hose_length_vector)
close all
tank_conductivity_sweep_graphing(simOut(1, hose_length_sweep_pos+1:AC_tank_equivalent_conductivity_pos), ...
    AC_tank_equivalent_conductivity_vector)
close all
Tank_size_sweep_graphing(simOut(1, AC_tank_equivalent_conductivity_pos+1:tank_size_pos), ...
    m_LH2_vector)
close all
Feed_pressure_sweep_graphing(simOut(1, tank_size_pos+1:LH2_FEED_PRES_POS), ...
    LH2_FEED_PRES_VEC)
close all
Feed_temp_sweep_graphing(simOut(1, LH2_FEED_PRES_POS+1:LH2_FEED_TEMP_POS), LH2_Feed_Temp_vec)
close all
hose_insulation_sweep_graphing(simOut(1, LH2_FEED_TEMP_POS+1:hose_thermal_conductivity_pos), hose_thermal_conductivity_vec)

diary off