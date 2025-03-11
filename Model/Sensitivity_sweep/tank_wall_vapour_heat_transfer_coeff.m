


close all
%% tank_wall_vapour_heat_transfer_coeff.m

tank_wall_vapour_heat_transfer_coeff_count = 3;
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
[tank_wall_vapour_heat_transfer_coeff_simIn, vapour_heat_transfer_coeff_vector] = ...
    tank_wall_vapour_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_vapour_heat_transfer_coeff_count, max_allowed_stop_time);

simIn = tank_wall_vapour_heat_transfer_coeff_simIn;

if rapid_flag == false && accel_flag == false && fast_restart_flag
   simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    simOut = parsim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

%% plot

tank_wall_vapour_heat_transfer_coeff_graphing(simOut, vapour_heat_transfer_coeff_vector);
