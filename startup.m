

clc
clear all

disp('Starting up LH2 Refuel Model, please read README.md and run startup.m')

addpath(genpath("Components\"))
addpath("Sensitivity_sweep\")
addpath("enum_const\")
addpath("full model\")
addpath("Control model\")
addpath("Component validation\")
addpath("Backwards_compatibility\")
addpath("FMU\")

load("model_data_full.mat")

%% used to refresh/regenerate model parameters

run("H2_material_properties.m")
run("bus_def.m")
run("design_details.m")
run("stateflow_const.m")
run('load_part_details')