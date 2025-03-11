

close all
%% hose_length_sweep.m
% This changes hose length over a variety of values

hose_length_sweep_count = 3;
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

[hose_length_sweep_simIn, hose_length_vector] = hose_length_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_length_sweep_count, max_allowed_stop_time);

clear simIn simOut

simIn = hose_length_sweep_simIn;

if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end


%% plot

hose_length_graphing(simOut, hose_length_vector)