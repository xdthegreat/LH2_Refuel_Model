 

% TODO: change model to fluids_&_control.slx if needed



clc
%% valve_diameter_sweep.m
% This changes aircraft valve orifice area over a variety of values

valve_diameter_vector = 0.01:0.002:0.024;
rapid_flag = true;
tic;

%parsim version
mdl = "simscape_automatic_R2024a";
Simulink.BlockDiagram.buildRapidAcceleratorTarget(mdl);
simIn(1:length(valve_diameter_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(valve_diameter_vector) 

    if rapid_flag
        simIn(i) = simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
        simIn(i) = simIn(i).setModelParameter(RapidAcceleratorUpToDateCheck="off");
    else
        simIn(i) = simIn(i).setModelParameter('SimulationMode','accelerator');
    end

    AC_return_valve_inner_diameter = valve_diameter_vector(i)*2;
    AC_return_valve_orifice_area = AC_return_valve_inner_diameter^2*pi;
    simIn(i) = simIn(i).setVariable('AC_return_valve_orifice_area', AC_return_valve_orifice_area); 

    AC_supply_valve_inner_diameter = valve_diameter_vector(i);
    AC_supply_valve_orifice_area = AC_supply_valve_inner_diameter^2*pi;
    simIn(i) = simIn(i).setVariable('AC_supply_valve_orifice_area', AC_supply_valve_orifice_area); 
    
    AC_engine_valve_inner_diameter = valve_diameter_vector(i);
    AC_engine_valve_orifice_area = AC_engine_valve_inner_diameter^2*pi;
    simIn(i) = simIn(i).setVariable('AC_engine_valve_orifice_area', AC_engine_valve_orifice_area); 

end

simOut = parsim(simIn);

toc;


%% ans processing

for i = 1:length(valve_diameter_vector)
    if isempty(simOut(1, i).ErrorMessage)
        figure(i)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        time_array = simOut(1, i).yout{5}.Values.Time;
        plot(time_array, AC_mode_data)
    end
end
