function [valve_diameter_sweep_simIn, valve_diameter_vector] = valve_diameter_sweep_setup(rapid_flag, accel_flag, ...
    mdl, valve_diameter_sweep_count, max_allowed_stop_time, Log_to_file_flag)


    valve_diameter_vector = linspace(0.007, 0.01, valve_diameter_sweep_count);

    valve_diameter_sweep_simIn(1:length(valve_diameter_vector)) = Simulink.SimulationInput(mdl); 




    for i = 1:length(valve_diameter_vector) 
        if Log_to_file_flag
            valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName', strcat('Graphs/valve_diameter_simOut', num2str(i), '.mat'));
        end
        
        if rapid_flag
            valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
        elseif accel_flag
            valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
        else
            valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setModelParameter('SimulationMode','normal');
        end
    
    
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('AC_return_valve_orifice_area', (valve_diameter_vector(i)*13)^2*pi/4); 
    
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('AC_supply_valve_orifice_area', (valve_diameter_vector(i)*4.8)^2*pi/4); 
       
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('AC_engine_valve_orifice_area', valve_diameter_vector(i)^2*pi/4); 
    
        valve_diameter_sweep_simIn(i) = valve_diameter_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 
    
    end

end