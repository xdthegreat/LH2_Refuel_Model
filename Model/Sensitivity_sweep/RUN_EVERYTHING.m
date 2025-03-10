

%% RUN_EVERYTHING.m
% This script runs all of the parameter sweeps. Good luck

% run noraml flow rate calcs
run("normal_flow_rates.m")
% run LH2 usage calcs
run('LH2_usage.m')

% Sens 001
run("valve_diameter_sweep.m")
% Sens 002
run("valve_discharge_coeff_sweep.m")

% Sens 003
run("tank_wall_vapour_heat_transfer_coeff.m")

% Sens 004
run("tank_wall_liquid_heat_transfer_coeff.m")

% Sens 005
run("hose_length_sweep.m")

% Sens 006
run("tank_conductivity_sweep.m")

% Sens 007
run("Tank_size_sweep.m")

% Sens 008
run("Feed_pressure_sweep.m")

% Sens 009
run("Feed_temp_sweep.m")

% Sens 010
run("hose_insulation_sweep.m")