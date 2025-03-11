
close all
%% Feed_temp_sweep.m


LH2_FEED_TEMP_COUNT = 3; 
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


clear simIn simOut

[Feed_temp_sweep_simIn, LH2_Feed_Temp_vec] = Feed_temp_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_TEMP_COUNT, max_allowed_stop_time);
simIn = Feed_temp_sweep_simIn;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end


%% plot

Feed_temp_sweep_graphing(simOut, LH2_Feed_Temp_vec)