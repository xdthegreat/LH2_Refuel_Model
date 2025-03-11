

close all
%% Tank_size_sweep.m
% This changes ac tank size over a variety of values

tank_size_count = 3;
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


[Tank_size_sweep_simIn, m_LH2_vector] = ...
    Tank_size_sweep_setup(rapid_flag, accel_flag, mdl, tank_size_count, max_allowed_stop_time, ...
    AC_tank_vol_limit, AC_tank_cross_sectional_area, AC_tank_radius);


clear simIn simOut
simIn = Tank_size_sweep_simIn;

if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end


%% plot



Tank_size_sweep_graphing(simOut, m_LH2_vector)