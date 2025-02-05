
clc
%% run warm tank refuel then cold tank refuel

model = "simscape_automatic";

simin = Simulink.SimulationInput(model);
simin = setModelParameter(simin,SimulationMode="accelerator");

simOut = sim(simin);