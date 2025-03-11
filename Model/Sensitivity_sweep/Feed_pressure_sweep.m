

close all
%% Feed_pressure_sweep.m

LH2_FEED_PRES_COUNT = 3;
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

[Feed_pressure_sweep_simIn, LH2_FEED_PRES_VEC] = Feed_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time);

clear simIn simOut
simIn = Feed_pressure_sweep_simIn;

if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end


%% plot

Feed_pressure_sweep_graphing(simOut, LH2_FEED_PRES_VEC)