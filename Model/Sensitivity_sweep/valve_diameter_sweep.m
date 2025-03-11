 

% TODO: change model to fluids_&_control.slx if needed
% Fix this and find out what is going on


close all
%% valve_diameter_sweep.m
% This changes aircraft valve orifice area over a variety of values

rapid_flag = false;
accel_flag = false;
fast_restart_flag = false;
max_allowed_stop_time = 10000;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end


% select number of cases
valve_diameter_sweep_count = 3;


% setup simIn
clear simIn simOut
[valve_diameter_sweep_simIn, valve_diameter_vector] = valve_diameter_sweep_setup(rapid_flag, accel_flag, ...
    mdl, valve_diameter_sweep_count, max_allowed_stop_time);

simIn = [valve_diameter_sweep_simIn];


if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end


% save results
% save('Graphs/run_everything_simOut.mat', 'simOut')
% zip('Graphs/run_everything_simOut.zip', 'Graphs/run_everything_simOut.mat')

% plotting

close all
valve_diameter_sweep_graphing(simOut(1, 1:valve_diameter_sweep_count), valve_diameter_vector)