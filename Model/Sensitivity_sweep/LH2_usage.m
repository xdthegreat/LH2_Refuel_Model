

close all

%% LH2_usage.m 
% This simulates model in normal conditions to find GH2 supplied LH2 rates vs that in the tank

rapid_flag = false;
accel_flag = false;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end

clear simIn simOut
simIn = LH2_usage_setup(rapid_flag, accel_flag, mdl);


if rapid_flag == false && accel_flag == false
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end


%% plotting

LH2_usage_graphing(simOut)