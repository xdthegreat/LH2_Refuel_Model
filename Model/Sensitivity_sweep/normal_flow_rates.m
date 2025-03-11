

close all

%% This simulates model in normal conditions to find flow rates

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
[simIn] = normal_flow_rate_setup(rapid_flag, accel_flag, mdl);

if rapid_flag == false && accel_flag == false
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    simOut = sim(simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end

toc;

%% graphing part
normal_flow_rate_graphing(simOut, AC_supply_line_port_inner_area)