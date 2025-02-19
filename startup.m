

clc
clear all

disp('Starting up LH2 Refuel Model, please read README.md and run startup.m')

addpath(genpath("Model\"))

% load("model_data_full.mat")

run("H2_material_properties.m")
run("bus_def.m")
run("design_details.m")
run("stateflow_const.m")
run('load_part_details')