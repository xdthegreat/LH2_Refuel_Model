

close all
%% hose_insulation_sweep.m


hose_thermal_conductivity_vec = logspace(log10(0.001), log10(1000), 20); % W/mK
 
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


[hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_thermal_conductivity_count, max_allowed_stop_time);

clear simIn simOut

simIn = hose_insulation_sweep_simIn;
if rapid_flag == false && accel_flag == false && fast_restart_flag
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end


%% plot

hose_insulation_sweep_graphing(simOut, hose_thermal_conductivity_vec)