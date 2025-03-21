
% H2 properties
load("H2Tables.mat")

% load density lookup
load("LH2_density_table.mat")
short_temp_vector = 15:0.1:30;
short_pressure_vector = 30000:1000:700000;

% load conductivity
load('LH2_conductivity.mat')
load('GH2_conductivity.mat')

% Reynalds number
Re_laminar_max = 2000;
Re_turbulent_min = 4000;

% Nusselt number


% steel data
steel_density = 8500;  %kg/m^3
steel_emmissitivity = 0.6;
radiation_constant = 5.67*10^-8;
steel_conductivity = 45;
steel_heat_capacity = 467;  %J/kg/K
