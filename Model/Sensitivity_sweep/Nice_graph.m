

%% This is used to generate tje nicfe graphs used for the actual report. 
% Reads processed data from spreadsheets instead of simOut

AC_tank_conductivity_results = readmatrix('Graphs\AC_tank_conductivity_sweep_results.xlsx');
feed_pressure_sweep_results = readmatrix('Graphs\feed_pressure_sweep_results.xlsx');
feed_temp_sweep_results = readmatrix('Graphs\feed_temp_sweep_results.xlsx');
hose_insulation_sweep_results = readmatrix('Graphs\hose_insulation_sweep_results.xlsx');
hose_length_sweep_results = readmatrix('Graphs\hose_length_sweep_results.xlsx');
liquid_heat_sweep_results = readmatrix('Graphs\liqudi_heat_sweep_results.xlsx');
m_LH2_sweep_results = readmatrix('Graphs\M_LH2_sweep_results.xlsx');
valve_diameter_sweep_results = readmatrix('Graphs\vaalve_diameter_sweep_results.xlsx');
valve_discharge_coeff_sweep_results = readmatrix('Graphs\vaalve_discharge_coeff_sweep_results.xlsx');
vapour_heat_sweep_results = readmatrix('Graphs\vapour_heat_sweep_results.xlsx');


normal_flow_rate_results = readmatrix('Graphs\normal flow rate details.xlsx');
normal_mass_flow_rate_results = readmatrix('Graphs\normal mass flow rate details.xlsx');

