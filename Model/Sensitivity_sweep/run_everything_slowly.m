


%% run_everything_slowly.m
% This script runs all of the parameter sweeps one by one. Built because
% Uni decided to shut off their Matlab server in the middle of coursework
% season for a weekend. 

clc
delete('Graphs\Simple_Sweep_log.txt')
diary('Graphs\Simple_Sweep_log.txt')
datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z')

%% setup
rapid_flag = false;
accel_flag = false;
fast_restart_flag = true;
max_allowed_stop_time = 3000;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end

%% normal flow rate and LH2 usage graphing
normal_flow_rate_simIn = normal_flow_rate_setup(rapid_flag, accel_flag, mdl);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    normal_flow_rate_simOut = sim(normal_flow_rate_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    normal_flow_rate_simOut = sim(normal_flow_rate_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
normal_flow_rate_graphing(normal_flow_rate_simOut, AC_supply_line_port_inner_area)
close all
LH2_usage_graphing(normal_flow_rate_simOut)

% save results
save("Graphs/normal_flow_rate_simOut.mat", "normal_flow_rate_simOut", '-v7.3')
clear normal_flow_rate_simOut

%% valve diameter sweep

[valve_diameter_sweep_simIn, valve_diameter_vector] = valve_diameter_sweep_setup(rapid_flag, accel_flag, ...
    mdl, 10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    valve_diameter_simOut = sim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    valve_diameter_simOut = sim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
valve_diameter_sweep_graphing(valve_diameter_simOut, valve_diameter_vector)

% save results
save("Graphs/valve_diameter_simOut.mat", "valve_diameter_simOut", '-v7.3')
clear valve_diameter_simOut
%% valve discahrge coeff

[valve_discharge_coeff_sweep_simIn, valve_discharge_coeff_vector] = ...
    valve_discharge_coeff_sweep_setup(rapid_flag, accel_flag, mdl, 10, max_allowed_stop_time); 

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    valve_discharge_coeff_sweep_simOut = sim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    valve_discharge_coeff_sweep_simOut = sim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
valve_discharge_coeff_sweep_graphing(valve_discharge_coeff_sweep_simOut, valve_discharge_coeff_vector);

% save results
save("Graphs/valve_discharge_coeff_sweep_simOut.mat", "valve_discharge_coeff_sweep_simOut", '-v7.3')
clear valve_discharge_coeff_sweep_simOut


%% Tank wall vapour heat transfer coefficient
[tank_wall_vapour_heat_transfer_coeff_simIn, vapour_heat_transfer_coeff_vector] = ...
    tank_wall_vapour_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    tank_wall_vapour_heat_transfer_coeff_simOut = sim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    tank_wall_vapour_heat_transfer_coeff_simOut = sim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
tank_wall_vapour_heat_transfer_coeff_graphing(tank_wall_vapour_heat_transfer_coeff_simOut, ...
    vapour_heat_transfer_coeff_vector);

% save results
save("Graphs/tank_wall_vapour_heat_transfer_coeff_simOut.mat", "tank_wall_vapour_heat_transfer_coeff_simOut", '-v7.3')
clear tank_wall_vapour_heat_transfer_coeff_simOut

%% tank wall liquid heat transfer coefficient sweep
[tank_wall_liquid_heat_transfer_coeff_simIn, liquid_heat_transfer_coeff_vector] = ...
    tank_wall_liquid_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    tank_wall_liquid_heat_transfer_coeff_simOut = sim(tank_wall_liquid_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    tank_wall_liquid_heat_transfer_coeff_simOut = sim(tank_wall_liquid_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
tank_wall_liquid_heat_transfer_coeff_graphing(tank_wall_liquid_heat_transfer_coeff_simOut, ...
    liquid_heat_transfer_coeff_vector);

% save results
save("Graphs/tank_wall_liquid_heat_transfer_coeff_simOut.mat", "tank_wall_liquid_heat_transfer_coeff_simOut", '-v7.3')
clear tank_wall_liquid_heat_transfer_coeff_simOut

%% hose length sweep

[hose_length_sweep_simIn, hose_length_vector] = hose_length_sweep_setup(rapid_flag, accel_flag, ...
    mdl, 10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    hose_length_sweep_simOut = sim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    hose_length_sweep_simOut = sim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
hose_length_graphing(hose_length_sweep_simOut, hose_length_vector)

% save results
save("Graphs/hose_length_sweep_simOut.mat", "hose_length_sweep_simOut", '-v7.3')
clear hose_length_sweep_simOut

%% tank conductivity
[tank_conductivity_sweep_simIn, AC_tank_equivalent_conductivity_vector] = ...
    tank_conductivity_sweep_setup(rapid_flag, accel_flag, mdl, 10,...
    max_allowed_stop_time, Ambient_temp, AC_wall_thickness);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    tank_conductivity_sweep_simOut = sim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    tank_conductivity_sweep_simOut = sim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
tank_conductivity_sweep_graphing(tank_conductivity_sweep_simOut, ...
    AC_tank_equivalent_conductivity_vector)

% save results
save("Graphs/tank_conductivity_sweep_simOut.mat", "tank_conductivity_sweep_simOut", '-v7.3')
clear tank_conductivity_sweep_simOut


%% tank size sweep
[Tank_size_sweep_simIn, m_LH2_vector] = ...
    Tank_size_sweep_setup(rapid_flag, accel_flag, mdl, 10, max_allowed_stop_time, ...
    AC_tank_vol_limit, AC_tank_cross_sectional_area, AC_tank_radius);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    Tank_size_sweep_simOut = sim(Tank_size_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    Tank_size_sweep_simOut = sim(Tank_size_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
Tank_size_sweep_graphing(Tank_size_sweep_simOut, m_LH2_vector)

% save results
save("Graphs/Tank_size_sweep_simOut.mat", "Tank_size_sweep_simOut", '-v7.3')
clear Tank_size_sweep_simOut

%% feed pressure

[Feed_pres_sweep_simIn, FEED_PRES_VEC] = Feed_pres_sweep_setup(rapid_flag, accel_flag, ...
    mdl, 10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    Feed_pres_sweep_simOut = sim(Feed_pres_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    Feed_pres_sweep_simOut = sim(Feed_pres_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
Feed_pressure_sweep_graphing(Feed_pres_sweep_simOut, FEED_PRES_VEC)

% save results
save("Graphs/Feed_pres_sweep_simOut.mat", "Feed_pres_sweep_simOut", '-v7.3')
clear Feed_pres_sweep_simOut

%% feed temperature

[Feed_temp_sweep_simIn, LH2_Feed_Temp_vec] = Feed_temp_sweep_setup(rapid_flag, accel_flag, ...
    mdl, 10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    Feed_temp_sweep_simOut = sim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    Feed_temp_sweep_simOut = sim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
Feed_temp_sweep_graphing(Feed_temp_sweep_simOut, LH2_Feed_Temp_vec)

% save results
save("Graphs/Feed_temp_sweep_simOut.mat", "Feed_temp_sweep_simOut", '-v7.3')
clear Feed_temp_sweep_simOut

%% hose insulation sweep

[hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, 10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    hose_insulation_sweep_simOut = sim(hose_insulation_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    hose_insulation_sweep_simOut = sim(hose_insulation_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
hose_insulation_sweep_graphing(hose_insulation_sweep_simOut, hose_thermal_conductivity_vec)

% save results
save("Graphs/hose_insulation_sweep_simOut.mat", "hose_insulation_sweep_simOut", '-v7.3')
clear hose_insulation_sweep_simOut

%% target tank pressure
[UAM_tank_pressure_sweep_simIn, UAM_TANK_PRES_VEC] = UAM_tank_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, 10, max_allowed_stop_time);

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    UAM_tank_pressure_sweep_simOut = sim(UAM_tank_pressure_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    UAM_tank_pressure_sweep_simOut = sim(UAM_tank_pressure_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

close all
UAM_tank_pressure_sweep_graphing(UAM_tank_pressure_sweep_simOut, ...
    UAM_TANK_PRES_VEC)

% save results
save("Graphs/UAM_tank_pressure_sweep_simOut.mat", "UAM_tank_pressure_sweep_simOut", '-v7.3')
clear UAM_tank_pressure_sweep_simOut


diary off
%% run nice graphing function
run("Nice_graph")


