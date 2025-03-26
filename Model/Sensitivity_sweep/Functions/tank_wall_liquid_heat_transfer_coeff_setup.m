


function [tank_wall_liquid_heat_transfer_coeff_simIn, liquid_heat_transfer_coeff_vector] = ...
    tank_wall_liquid_heat_transfer_coeff_setup(rapid_flag, accel_flag, mdl,...
    tank_wall_liquid_heat_transfer_coeff_count, max_allowed_stop_time, Log_to_file_flag)


    liquid_heat_transfer_coeff_vector = logspace(log10(5), log10(10000), tank_wall_liquid_heat_transfer_coeff_count); % to be changed
    
    tank_wall_liquid_heat_transfer_coeff_simIn(1:length(liquid_heat_transfer_coeff_vector)) = Simulink.SimulationInput(mdl); 
    
    for i = 1:length(liquid_heat_transfer_coeff_vector) 
        if Log_to_file_flag
            tank_wall_liquid_heat_transfer_coeff_simIn(i) = tank_wall_liquid_heat_transfer_coeff_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName','Graphs/tank_wall_liquid_heat_transfer_coeff_simOut'+i+'.mat');
        end
        if rapid_flag
            tank_wall_liquid_heat_transfer_coeff_simIn(i) = tank_wall_liquid_heat_transfer_coeff_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
        elseif accel_flag
            tank_wall_liquid_heat_transfer_coeff_simIn(i) = tank_wall_liquid_heat_transfer_coeff_simIn(i).setModelParameter('SimulationMode','accelerator');
        else
            tank_wall_liquid_heat_transfer_coeff_simIn(i) = tank_wall_liquid_heat_transfer_coeff_simIn(i).setModelParameter('SimulationMode','normal');
        end
    
    
        tank_wall_liquid_heat_transfer_coeff_simIn(i) = tank_wall_liquid_heat_transfer_coeff_simIn(i).setVariable('AC_tank_liquid_heat_transfer_coeff', liquid_heat_transfer_coeff_vector(i)); 
    
        tank_wall_liquid_heat_transfer_coeff_simIn(i) = tank_wall_liquid_heat_transfer_coeff_simIn(i).setVariable('stopTime', max_allowed_stop_time); 
    
    end
end