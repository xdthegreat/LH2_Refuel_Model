


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
fast_restart_flag = false;
max_allowed_stop_time = 3000;
save_simOut_flag = false;
parsim_flag = true;
simplify_output_func_flag = false;
Log_to_file_flag = true;

% number of sweep points
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

mdl = "simscape_automatic_R2024a";

%% normal flow rate and LH2 usage graphing
normal_flow_rate_simIn = normal_flow_rate_setup(rapid_flag, accel_flag, mdl, Log_to_file_flag);

if simplify_output_func_flag
    normal_flow_rate_simIn = setPostSimFcn(normal_flow_rate_simIn, @(x) simplify_data(x));
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    normal_flow_rate_simOut = sim(normal_flow_rate_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    normal_flow_rate_simOut = sim(normal_flow_rate_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    normal_flow_rate_simOut = logging_file_repackage("normal_flow_rate_simOut", 1);
end

close all
normal_flow_rate_graphing(normal_flow_rate_simOut, AC_supply_line_port_inner_area)
close all
LH2_usage_graphing(normal_flow_rate_simOut)




if save_simOut_flag && ~Log_to_file_flag
    % save results
    save("Graphs/normal_flow_rate_simOut.mat", "normal_flow_rate_simOut", '-v7.3')
    clear normal_flow_rate_simOute
end

%% valve diameter sweep

[valve_diameter_sweep_simIn, valve_diameter_vector] = valve_diameter_sweep_setup(rapid_flag, accel_flag, ...
    mdl, valve_diameter_sweep_count, max_allowed_stop_time, Log_to_file_flag);

if simplify_output_func_flag
    valve_diameter_sweep_simIn = setPostSimFcn(valve_diameter_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
    valve_diameter_simOut = parsim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
    valve_diameter_simOut = parsim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
    valve_diameter_simOut = sim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    valve_diameter_simOut = sim(valve_diameter_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    valve_diameter_simOut = logging_file_repackage("valve_diameter_simOut", ...
        valve_diameter_sweep_count);
end

close all
valve_diameter_sweep_graphing(valve_diameter_simOut, valve_diameter_vector)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/valve_diameter_simOut.mat", "valve_diameter_simOut", '-v7.3')
clear valve_diameter_simOut
end
%% valve discahrge coeff

[valve_discharge_coeff_sweep_simIn, valve_discharge_coeff_vector] = ...
    valve_discharge_coeff_sweep_setup(rapid_flag, accel_flag, mdl, valve_discharge_coeff_sweep_count, ...
    max_allowed_stop_time, Log_to_file_flag); 

if simplify_output_func_flag
    valve_discharge_coeff_sweep_simIn = setPostSimFcn(valve_discharge_coeff_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     valve_discharge_coeff_sweep_simOut = parsim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     valve_discharge_coeff_sweep_simOut = parsim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     valve_discharge_coeff_sweep_simOut = sim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     valve_discharge_coeff_sweep_simOut = sim(valve_discharge_coeff_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    valve_discharge_coeff_sweep_simOut = logging_file_repackage("valve_discharge_coeff_sweep_simOut", ...
        valve_discharge_coeff_sweep_count);
end

close all
valve_discharge_coeff_sweep_graphing(valve_discharge_coeff_sweep_simOut, valve_discharge_coeff_vector);

% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/valve_discharge_coeff_sweep_simOut.mat", "valve_discharge_coeff_sweep_simOut", '-v7.3')
clear valve_discharge_coeff_sweep_simOut
end


%% Tank wall vapour heat transfer coefficient
[tank_wall_vapour_heat_transfer_coeff_simIn, vapour_heat_transfer_coeff_vector] = ...
    tank_wall_vapour_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_vapour_heat_transfer_coeff_count, max_allowed_stop_time, Log_to_file_flag);

if simplify_output_func_flag
    tank_wall_vapour_heat_transfer_coeff_simIn = setPostSimFcn(tank_wall_vapour_heat_transfer_coeff_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     tank_wall_vapour_heat_transfer_coeff_simOut = parsim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     tank_wall_vapour_heat_transfer_coeff_simOut = parsim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     tank_wall_vapour_heat_transfer_coeff_simOut = sim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     tank_wall_vapour_heat_transfer_coeff_simOut = sim(tank_wall_vapour_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    tank_wall_vapour_heat_transfer_coeff_simOut = logging_file_repackage("tank_wall_vapour_heat_transfer_coeff_simOut", ...
        tank_wall_vapour_heat_transfer_coeff_count);
end

close all
tank_wall_vapour_heat_transfer_coeff_graphing(tank_wall_vapour_heat_transfer_coeff_simOut, ...
    vapour_heat_transfer_coeff_vector);


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/tank_wall_vapour_heat_transfer_coeff_simOut.mat", "tank_wall_vapour_heat_transfer_coeff_simOut", '-v7.3')
clear tank_wall_vapour_heat_transfer_coeff_simOut
end

%% tank wall liquid heat transfer coefficient sweep
[tank_wall_liquid_heat_transfer_coeff_simIn, liquid_heat_transfer_coeff_vector] = ...
    tank_wall_liquid_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_liquid_heat_transfer_coeff_count, max_allowed_stop_time, Log_to_file_flag);

if simplify_output_func_flag
    tank_wall_liquid_heat_transfer_coeff_simIn = setPostSimFcn(tank_wall_liquid_heat_transfer_coeff_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     tank_wall_liquid_heat_transfer_coeff_simOut = parsim(tank_wall_liquid_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     tank_wall_liquid_heat_transfer_coeff_simOut = parsim(tank_wall_liquid_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     tank_wall_liquid_heat_transfer_coeff_simOut = sim(tank_wall_liquid_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     tank_wall_liquid_heat_transfer_coeff_simOut = sim(tank_wall_liquid_heat_transfer_coeff_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    tank_wall_liquid_heat_transfer_coeff_simOut = logging_file_repackage("tank_wall_liquid_heat_transfer_coeff_simOut", ...
        tank_wall_liquid_heat_transfer_coeff_count);
end

close all
tank_wall_liquid_heat_transfer_coeff_graphing(tank_wall_liquid_heat_transfer_coeff_simOut, ...
    liquid_heat_transfer_coeff_vector);


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/tank_wall_liquid_heat_transfer_coeff_simOut.mat", "tank_wall_liquid_heat_transfer_coeff_simOut", '-v7.3')
clear tank_wall_liquid_heat_transfer_coeff_simOut
end
%% hose length sweep

[hose_length_sweep_simIn, hose_length_vector] = hose_length_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_length_sweep_count, max_allowed_stop_time, Log_to_file_flag);


if simplify_output_func_flag
    hose_length_sweep_simIn = setPostSimFcn(hose_length_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     hose_length_sweep_simOut = parsim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     hose_length_sweep_simOut = parsim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     hose_length_sweep_simOut = sim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     hose_length_sweep_simOut = sim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    hose_length_sweep_simOut = logging_file_repackage("hose_length_sweep_simOut", ...
        hose_length_sweep_count);
end


close all
hose_length_graphing(hose_length_sweep_simOut, hose_length_vector)

% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/hose_length_sweep_simOut.mat", "hose_length_sweep_simOut", '-v7.3')
clear hose_length_sweep_simOut
end

%% tank conductivity
[tank_conductivity_sweep_simIn, AC_tank_equivalent_conductivity_vector] = ...
    tank_conductivity_sweep_setup(rapid_flag, accel_flag, mdl, AC_tank_equivalent_conductivity_count,...
    max_allowed_stop_time, Ambient_temp, AC_wall_thickness, Log_to_file_flag);

if simplify_output_func_flag
    tank_conductivity_sweep_simIn = setPostSimFcn(tank_conductivity_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     tank_conductivity_sweep_simOut = parsim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     tank_conductivity_sweep_simOut = parsim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     tank_conductivity_sweep_simOut = sim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     tank_conductivity_sweep_simOut = sim(tank_conductivity_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    tank_conductivity_sweep_simOut = logging_file_repackage("tank_conductivity_sweep_simOut", ...
        AC_tank_equivalent_conductivity_count);
end

close all
tank_conductivity_sweep_graphing(tank_conductivity_sweep_simOut, ...
    AC_tank_equivalent_conductivity_vector)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/tank_conductivity_sweep_simOut.mat", "tank_conductivity_sweep_simOut", '-v7.3')
clear tank_conductivity_sweep_simOut
end

%% tank size sweep
[Tank_size_sweep_simIn, m_LH2_vector] = ...
    Tank_size_sweep_setup(rapid_flag, accel_flag, mdl, tank_size_count, max_allowed_stop_time, ...
    AC_tank_vol_limit, AC_tank_cross_sectional_area, AC_tank_radius, Log_to_file_flag);

if simplify_output_func_flag
    Tank_size_sweep_simIn = setPostSimFcn(Tank_size_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     Tank_size_sweep_simOut = parsim(Tank_size_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     Tank_size_sweep_simOut = parsim(Tank_size_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     Tank_size_sweep_simOut = sim(Tank_size_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     Tank_size_sweep_simOut = sim(Tank_size_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end

toc;

if Log_to_file_flag
    Tank_size_sweep_simOut = logging_file_repackage("Tank_size_sweep_simOut", ...
        tank_size_count);
end


close all
Tank_size_sweep_graphing(Tank_size_sweep_simOut, m_LH2_vector)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/Tank_size_sweep_simOut.mat", "Tank_size_sweep_simOut", '-v7.3')
clear Tank_size_sweep_simOut
end
%% feed pressure

[Feed_pres_sweep_simIn, FEED_PRES_VEC] = Feed_pres_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time, Log_to_file_flag);

if simplify_output_func_flag
    Feed_pres_sweep_simIn = setPostSimFcn(Feed_pres_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
     Feed_pres_sweep_simOut = parsim(Feed_pres_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     Feed_pres_sweep_simOut = parsim(Feed_pres_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     Feed_pres_sweep_simOut = sim(Feed_pres_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     Feed_pres_sweep_simOut = sim(Feed_pres_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    Feed_pres_sweep_simOut = logging_file_repackage("Feed_pres_sweep_simOut", ...
        LH2_FEED_PRES_COUNT);
end

close all
Feed_pressure_sweep_graphing(Feed_pres_sweep_simOut, FEED_PRES_VEC)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/Feed_pres_sweep_simOut.mat", "Feed_pres_sweep_simOut", '-v7.3')
clear Feed_pres_sweep_simOut
end

%% feed temperature

[Feed_temp_sweep_simIn, LH2_Feed_Temp_vec] = Feed_temp_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_TEMP_COUNT, max_allowed_stop_time, Log_to_file_flag);


if simplify_output_func_flag
    Feed_temp_sweep_simIn = setPostSimFcn(Feed_temp_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
    Feed_temp_sweep_simOut = parsim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     Feed_temp_sweep_simOut = parsim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     Feed_temp_sweep_simOut = sim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     Feed_temp_sweep_simOut = sim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end

toc;

if Log_to_file_flag
    Feed_temp_sweep_simOut = logging_file_repackage("Feed_temp_sweep_simOut", ...
        LH2_FEED_TEMP_COUNT);
end

close all
Feed_temp_sweep_graphing(Feed_temp_sweep_simOut, LH2_Feed_Temp_vec)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/Feed_temp_sweep_simOut.mat", "Feed_temp_sweep_simOut", '-v7.3')
clear Feed_temp_sweep_simOut
end

%% hose insulation sweep

[hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_thermal_conductivity_count, max_allowed_stop_time, Log_to_file_flag);

if simplify_output_func_flag
    hose_insulation_sweep_simIn = setPostSimFcn(hose_insulation_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
    hose_insulation_sweep_simOut = parsim(hose_insulation_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     hose_insulation_sweep_simOut = parsim(hose_insulation_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     hose_insulation_sweep_simOut = sim(hose_insulation_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     hose_insulation_sweep_simOut = sim(hose_insulation_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    hose_insulation_sweep_simOut = logging_file_repackage("hose_insulation_sweep_simOut", ...
        hose_thermal_conductivity_count);
end

close all
hose_insulation_sweep_graphing(hose_insulation_sweep_simOut, hose_thermal_conductivity_vec)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/hose_insulation_sweep_simOut.mat", "hose_insulation_sweep_simOut", '-v7.3')
clear hose_insulation_sweep_simOut
end
%% target tank pressure
[UAM_tank_pressure_sweep_simIn, UAM_TANK_PRES_VEC] = UAM_tank_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, UAM_TANK_PRES_COUNT, max_allowed_stop_time, Log_to_file_flag);

if simplify_output_func_flag
    UAM_tank_pressure_sweep_simIn = setPostSimFcn(UAM_tank_pressure_sweep_simIn, @simplify_data);
end

tic;
if rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag
    UAM_tank_pressure_sweep_simOut = parsim(UAM_tank_pressure_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
elseif parsim_flag
     UAM_tank_pressure_sweep_simOut = parsim(UAM_tank_pressure_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
elseif rapid_flag == false && accel_flag == false && fast_restart_flag && parsim_flag == false
     UAM_tank_pressure_sweep_simOut = sim(UAM_tank_pressure_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
     UAM_tank_pressure_sweep_simOut = sim(UAM_tank_pressure_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end
toc;

if Log_to_file_flag
    UAM_tank_pressure_sweep_simOut = logging_file_repackage("UAM_tank_pressure_sweep_simOut", UAM_TANK_PRES_COUNT);
end

close all
UAM_tank_pressure_sweep_graphing(UAM_tank_pressure_sweep_simOut, ...
    UAM_TANK_PRES_VEC)


% save results
if save_simOut_flag && ~Log_to_file_flag
save("Graphs/UAM_tank_pressure_sweep_simOut.mat", "UAM_tank_pressure_sweep_simOut", '-v7.3')
clear UAM_tank_pressure_sweep_simOut
end

diary off
%% run nice graphing function
run("Nice_graph")


