

function [normal_flow_rates_simIn] = normal_flow_rate_setup(rapid_flag, accel_flag, mdl)
        
    normal_flow_rates_simIn = Simulink.SimulationInput(mdl); 
    if rapid_flag
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter('SimulationMode','accelerator');
    else
        normal_flow_rates_simIn = normal_flow_rates_simIn.setModelParameter('SimulationMode','normal');
    end
end