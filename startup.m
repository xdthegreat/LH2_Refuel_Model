

clc
clear all

disp('Starting up LH2 Refuel Model, please read README.md and run startup.m')

addpath(genpath("Components\"))
addpath("Sensitivity_sweep\")
addpath("enum_const\")
addpath("full model\")
addpath("Control model\")
addpath("Component validation\")

load("model_data_full.mat")