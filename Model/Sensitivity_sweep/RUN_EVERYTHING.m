

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
max_allowed_stop_time = 2000;
parsim_flag = false;
save_simout_flag = true;
simplify_output_func_flag = true;
Log_to_file_flag = false;

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
valve_discharge_coeff_sweep_count = 10;
tank_wall_vapour_heat_transfer_coeff_count = 10;
tank_wall_liquid_heat_transfer_coeff_count = 10;
hose_length_sweep_count = 10;
AC_tank_equivalent_conductivity_count = 10;
tank_size_count = 10;
LH2_FEED_PRES_COUNT = 10;
LH2_FEED_TEMP_COUNT = 10;
hose_thermal_conductivity_count = 10;
UAM_TANK_PRES_COUNT = 10;


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
UAM_TANK_PRES_POS = hose_thermal_conductivity_pos + UAM_TANK_PRES_COUNT;



% setup simIn
clear simIn simOut
normal_flow_rate_simIn = normal_flow_rate_setup(rapid_flag, accel_flag, mdl, Log_to_file_flag);

[valve_diameter_sweep_simIn, valve_diameter_vector] = valve_diameter_sweep_setup(rapid_flag, accel_flag, ...
    mdl, valve_diameter_sweep_count, max_allowed_stop_time, Log_to_file_flag);

[valve_discharge_coeff_sweep_simIn, valve_discharge_coeff_vector] = ...
    valve_discharge_coeff_sweep_setup(rapid_flag, accel_flag, mdl, valve_discharge_coeff_sweep_count, ...
    max_allowed_stop_time, Log_to_file_flag); 

[tank_wall_vapour_heat_transfer_coeff_simIn, vapour_heat_transfer_coeff_vector] = ...
    tank_wall_vapour_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_vapour_heat_transfer_coeff_count, max_allowed_stop_time);

[tank_wall_liquid_heat_transfer_coeff_simIn, liquid_heat_transfer_coeff_vector] = ...
    tank_wall_liquid_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_liquid_heat_transfer_coeff_count, max_allowed_stop_time, Log_to_file_flag);

[hose_length_sweep_simIn, hose_length_vector] = hose_length_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_length_sweep_count, max_allowed_stop_time, Log_to_file_flag);

[tank_conductivity_sweep_simIn, AC_tank_equivalent_conductivity_vector] = ...
    tank_conductivity_sweep_setup(rapid_flag, accel_flag, mdl, AC_tank_equivalent_conductivity_count,...
    max_allowed_stop_time, Ambient_temp, AC_wall_thickness, Log_to_file_flag);

[Tank_size_sweep_simIn, m_LH2_vector] = ...
    Tank_size_sweep_setup(rapid_flag, accel_flag, mdl, tank_size_count, max_allowed_stop_time, ...
    AC_tank_vol_limit, AC_tank_cross_sectional_area, AC_tank_radius, Log_to_file_flag);

[Feed_pres_sweep_simIn, FEED_PRES_VEC] = Feed_pres_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time, Log_to_file_flag);

[Feed_temp_sweep_simIn, LH2_Feed_Temp_vec] = Feed_temp_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_TEMP_COUNT, max_allowed_stop_time, Log_to_file_flag);

[hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_thermal_conductivity_count, max_allowed_stop_time, Log_to_file_flag);

[UAM_tank_pressure_sweep_simIn, UAM_TANK_PRES_VEC] = UAM_tank_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, UAM_TANK_PRES_COUNT, max_allowed_stop_time, Log_to_file_flag);


% shove everything in one simIn

simIn = [normal_flow_rate_simIn, valve_diameter_sweep_simIn, valve_discharge_coeff_sweep_simIn, ...
    tank_wall_vapour_heat_transfer_coeff_simIn, tank_wall_liquid_heat_transfer_coeff_simIn, ...
    hose_length_sweep_simIn, tank_conductivity_sweep_simIn, Tank_size_sweep_simIn, ...
    Feed_pres_sweep_simIn, Feed_temp_sweep_simIn, hose_insulation_sweep_simIn, UAM_tank_pressure_sweep_simIn];


if simplify_output_func_flag
    simIn = setPostSimFcn(simIn, @simplify_data);
end

%% actual simulation
tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

%% graphing

if ~Log_to_file_flag
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
    FEED_PRES_VEC)
close all
Feed_temp_sweep_graphing(simOut(1, LH2_FEED_PRES_POS+1:LH2_FEED_TEMP_POS), LH2_Feed_Temp_vec)
close all
hose_insulation_sweep_graphing(simOut(1, LH2_FEED_TEMP_POS+1:hose_thermal_conductivity_pos), hose_thermal_conductivity_vec)
close all
UAM_tank_pressure_sweep_graphing(simOut(1, hose_thermal_conductivity_pos+1:UAM_TANK_PRES_POS), ...
    UAM_TANK_PRES_VEC)

end


diary off
%% run nice graphing function
run("Nice_graph")


%% save results
if save_simout_flag
save("Graphs/simOut.mat", "simOut", '-v7.3')
zip('Graphs/simOut.zip', 'Graphs/simOut.mat')
end