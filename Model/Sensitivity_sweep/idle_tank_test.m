

clc
close all

%% config
stopTime = 3600*10;
couplings_connected_in = timeseries([true, false, true], [0, 1000, 35000]);
Datalink_connected_in = timeseries([true, false, true], [0, 1000, 35000]);
Refuel_target_mass = timeseries([16], [0]);
MODE_SELECT_in = timeseries([REFUEL_MODE], [0]);
engine_on_in = timeseries([false], [0]);

% setup simIn 
mdl = "fluids_and_control";
rapid_flag = false;
accel_flag = false;

simIn = Simulink.SimulationInput(mdl); 

if rapid_flag
    simIn = simIn.setModelParameter(SimulationMode="rapid-accelerator");
elseif accel_flag
    simIn = simIn.setModelParameter('SimulationMode','accelerator');
else
    simIn = simIn.setModelParameter('SimulationMode','normal');
end

ds = Simulink.SimulationData.Dataset;
ds = setElement(ds,1,couplings_connected_in);
ds = setElement(ds,2,Datalink_connected_in);
ds = setElement(ds,3,Refuel_target_mass);
ds = setElement(ds,4,MODE_SELECT_in);
ds = setElement(ds,5,engine_on_in);
simIn = setExternalInput(simIn,ds);

tic;
simOut = sim(simIn, ShowProgress="on");
toc;




