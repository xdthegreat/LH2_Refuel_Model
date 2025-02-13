
% TODO: change model to fluids_&_control.slx if needed



clc
%% valve_discharge_coeff_sweep.m
% This changes aircraft valve discharge coefficient over a variety of values

valve_discharge_coeff_vector = 0.6:0.01:0.8;
rapid_flag = true;

tic;


%parsim version
mdl = "simscape_automatic";


simIn(1:length(valve_discharge_coeff_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(valve_discharge_coeff_vector) 
    if rapid_flag
        simIn(i) = simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    else
        simIn(i) = simIn(i).setModelParameter('SimulationMode','accelerator');
    end


    AC_engine_valve_discharge_coeff_temp = valve_discharge_coeff_vector(i);
    simIn(i) = simIn(i).setVariable('AC_engine_valve_discharge_coeff', AC_engine_valve_discharge_coeff_temp); 

    AC_return_valve_discharge_coeff_temp = valve_discharge_coeff_vector(i);
    simIn(i) = simIn(i).setVariable('AC_return_valve_discharge_coeff', AC_return_valve_discharge_coeff_temp); 

    AC_supply_valve_discharge_coeff_temp = valve_discharge_coeff_vector(i);
    simIn(i) = simIn(i).setVariable('AC_supply_valve_discharge_coeff', AC_supply_valve_discharge_coeff_temp); 

end

simOut = parsim(simIn, 'ShowSimulationManager', 'on', "UseFastRestart", "On");

toc;


%% ans processing

for i = 1:length(valve_discharge_coeff_vector)
    if isempty(simOut(1, i).ErrorMessage)
        figure(i)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        time_array = simOut(1, i).yout{5}.Values.Time;
        plot(time_array, AC_mode_data)
    end
end
