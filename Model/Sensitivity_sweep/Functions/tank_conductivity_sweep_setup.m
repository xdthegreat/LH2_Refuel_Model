

function [tank_conductivity_sweep_simIn, AC_tank_equivalent_conductivity_vector] = ...
    tank_conductivity_sweep_setup(rapid_flag, accel_flag, mdl, AC_tank_equivalent_conductivity_count,...
    max_allowed_stop_time, Ambient_temp, AC_wall_thickness, Log_to_file_flag)
    
    AC_tank_equivalent_conductivity_vector = logspace(log10(1), log10(1200), ...
        AC_tank_equivalent_conductivity_count)/(Ambient_temp-20)*AC_wall_thickness; % to be changed
    
    
    tank_conductivity_sweep_simIn(1:length(AC_tank_equivalent_conductivity_vector)) = Simulink.SimulationInput(mdl); 
    for i = 1:length(AC_tank_equivalent_conductivity_vector) 
        if Log_to_file_flag
            tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName',strcat('Graphs/tank_conductivity_sweep_simOut', num2str(i), '.mat'));
        end
        if rapid_flag
            tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
        elseif accel_flag
            tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
        else
            tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setModelParameter('SimulationMode','normal');
        end
    
    
        tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setVariable('AC_tank_equivalent_conductivity', AC_tank_equivalent_conductivity_vector(i)); 
    
        tank_conductivity_sweep_simIn(i) = tank_conductivity_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 
    
    end

end