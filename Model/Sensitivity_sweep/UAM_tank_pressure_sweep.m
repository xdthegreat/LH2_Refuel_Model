

close all
%% Feed_pressure_sweep.m

TANK_PRES_COUNT = 3;
max_allowed_stop_time = 4000;
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

[Tank_pressure_sweep_simIn, TANK_FEED_PRES_VEC] = UAM_tank_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, TANK_PRES_COUNT, max_allowed_stop_time);

clear simIn simOut
simIn = Tank_pressure_sweep_simIn;

if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end


%% plot

UAM_tank_pressure_sweep_graphing(simOut, TANK_FEED_PRES_VEC)