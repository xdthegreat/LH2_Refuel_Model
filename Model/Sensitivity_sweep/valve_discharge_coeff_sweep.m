
% TODO: change model to fluids_&_control.slx if needed



close all
%% valve_discharge_coeff_sweep.m
% This changes aircraft valve discharge coefficient over a variety of values

rapid_flag = false;
accel_flag = false;
fast_restart_flag = false;
max_allowed_stop_time = 10000;
valve_discharge_coeff_sweep_count = 3;
tic;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end

clear simIn simOut
[valve_discharge_coeff_sweep_simIn, valve_discharge_coeff_vector] = ...
    valve_discharge_coeff_sweep_setup(rapid_flag, accel_flag, mdl, valve_discharge_coeff_sweep_count, max_allowed_stop_time); 

simIn = valve_discharge_coeff_sweep_simIn;

if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

%% ans processing

valve_discharge_coeff_sweep_graphing(simOut, valve_discharge_coeff_vector);