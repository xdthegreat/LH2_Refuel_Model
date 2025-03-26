

function [normal_flow_rates_simIn] = normal_flow_rate_setup(rapid_flag, accel_flag, mdl, Log_to_file_flag)
        
    normal_flow_rates_simIn = Simulink.SimulationInput(mdl); 

    if Log_to_file_flag
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter('LoggingToFile','on',...
                                'LoggingFileName','Graphs/normal_flow_rate_simOut1_1.mat');
    end

    if rapid_flag
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter('SimulationMode','accelerator');
    else
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter('SimulationMode','normal');
    end
end