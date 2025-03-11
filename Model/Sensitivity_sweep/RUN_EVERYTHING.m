

%% RUN_EVERYTHING.m
% This script runs all of the parameter sweeps. Good luck

diary('Graphs\Sweep_log.txt')
datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z')

% run noraml flow rate calcs
disp("Running normal flow rate calcs")
run("normal_flow_rates.m")
% run LH2 usage calcs
disp("Running LH2 usage calcs")
run('LH2_usage.m')

%% Sens 001
disp("Running valve diameter sweep")
run("valve_diameter_sweep.m")

%% Sens 002
disp("Running valve discharge coefficient sweep")
run("valve_discharge_coeff_sweep.m")

%% Sens 003
disp("Running tank wall vapour heat transfer coefficient sweep")
run("tank_wall_vapour_heat_transfer_coeff.m")

%% Sens 004
disp("Running tank wall liquid heat transfer coefficient sweep")
run("tank_wall_liquid_heat_transfer_coeff.m")

%% Sens 005
disp("Running hose length sweep")
run("hose_length_sweep.m")

%% Sens 006
disp("Running tank wall conductivity sweep")
run("tank_conductivity_sweep.m")

%% Sens 007
disp("Running tank size sweep")
run("Tank_size_sweep.m")

%% Sens 008
disp("Running feed pressure sweep")
run("Feed_pressure_sweep.m")

%% Sens 009
disp("Running feed temperature sweep")
run("Feed_temp_sweep.m")

%% Sens 010
disp("Running hose insulation conductivity sweep")
run("hose_insulation_sweep.m")


diary off