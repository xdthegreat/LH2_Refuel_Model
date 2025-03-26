


function [hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_thermal_conductivity_count, max_allowed_stop_time, Log_to_file_flag)


hose_thermal_conductivity_vec = logspace(log10(0.1), log10(1000), hose_thermal_conductivity_count);

hose_insulation_sweep_simIn(1:length(hose_thermal_conductivity_vec)) = Simulink.SimulationInput(mdl); 
for i = 1:length(hose_thermal_conductivity_vec) 
    if Log_to_file_flag
            hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName', strcat('Graphs/hose_insulation_sweep_simOut', num2str(i), '.mat'));
    end
    if rapid_flag
        hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    actual_coeff = hose_thermal_conductivity_vec(i)/2/pi*log(0.104/0.1)/(300-20);
    hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setVariable('hose_thermal_conductivity', actual_coeff);
    hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end


end