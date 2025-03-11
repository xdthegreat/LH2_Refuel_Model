

function [valve_discharge_coeff_sweep_simIn, valve_discharge_coeff_vector] = ...
    valve_discharge_coeff_sweep_setup(rapid_flag, accel_flag, mdl, valve_discharge_coeff_sweep_count, max_allowed_stop_time) 

    valve_discharge_coeff_vector = linspace(0.4, 0.8, valve_discharge_coeff_sweep_count);
    
    valve_discharge_coeff_sweep_simIn(1:length(valve_discharge_coeff_vector)) = Simulink.SimulationInput(mdl); 
    for i = 1:length(valve_discharge_coeff_vector) 
        if rapid_flag
            valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
        elseif accel_flag
            valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
        else
            valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setModelParameter('SimulationMode','normal');
        end
    
        valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setVariable('AC_engine_valve_discharge_coeff', valve_discharge_coeff_vector(i)); 
    
        valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setVariable('AC_return_valve_discharge_coeff', valve_discharge_coeff_vector(i)); 
    
        valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setVariable('AC_supply_valve_discharge_coeff', valve_discharge_coeff_vector(i)); 
    
        valve_discharge_coeff_sweep_simIn(i) = valve_discharge_coeff_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 
    
    end
end