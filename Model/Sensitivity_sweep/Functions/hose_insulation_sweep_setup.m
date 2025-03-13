


function [hose_insulation_sweep_simIn, hose_thermal_conductivity_vec] = hose_insulation_sweep_setup(rapid_flag, accel_flag, ...
    mdl, hose_thermal_conductivity_count, max_allowed_stop_time)


hose_thermal_conductivity_vec = logspace(log10(0.0001), log10(0.1), hose_thermal_conductivity_count);

hose_insulation_sweep_simIn(1:length(hose_thermal_conductivity_vec)) = Simulink.SimulationInput(mdl); 
for i = 1:length(hose_thermal_conductivity_vec) 
    if rapid_flag
        hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setVariable('hose_thermal_conductivity', hose_thermal_conductivity_vec(i));
    hose_insulation_sweep_simIn(i) = hose_insulation_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end


end