

function [hose_length_sweep_simIn, hose_length_vector] = hose_length_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_length_sweep_count, max_allowed_stop_time)

    hose_length_vector = linspace(5, 20, hose_length_sweep_count);

    hose_length_sweep_simIn(1:length(hose_length_vector)) = Simulink.SimulationInput(mdl); 
    for i = 1:length(hose_length_vector) 
        if rapid_flag
            hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
        elseif accel_flag
            hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
        else
            hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setModelParameter('SimulationMode','normal');
        end
    
        hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setVariable('hose_length', hose_length_vector(i));
    
        hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 
    
    end

end