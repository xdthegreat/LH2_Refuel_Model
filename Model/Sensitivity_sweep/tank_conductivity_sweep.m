




close all
%% tank_conductivity_sweep.m
% This changes tank wall conductivity over a variety of values

AC_tank_equivalent_conductivity_count = 3;
max_allowed_stop_time = 10000;
rapid_flag = false;
accel_flag = false; 
fast_restart_flag = false;
tic;


%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end


[tank_conductivity_sweep_simIn, AC_tank_equivalent_conductivity_vector] = ...
    tank_conductivity_sweep_setup(rapid_flag, accel_flag, mdl, AC_tank_equivalent_conductivity_count,...
    max_allowed_stop_time, Ambient_temp, AC_wall_thickness);

clear simIn simOut
simIn = tank_conductivity_sweep_simIn;


if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end


%% plot
tank_conductivity_sweep_graphing(simOut, ...
    AC_tank_equivalent_conductivity_vector)
