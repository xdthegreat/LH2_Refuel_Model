
function LH2_usage_simIn = LH2_usage_setup(rapid_flag, accel_flag, mdl)

LH2_usage_simIn = Simulink.SimulationInput(mdl); 
if rapid_flag
    LH2_usage_simIn = LH2_usage_simIn.setModelParameter(SimulationMode="rapid-accelerator");
elseif accel_flag
    LH2_usage_simIn = LH2_usage_simIn.setModelParameter('SimulationMode','accelerator');
else
    LH2_usage_simIn = LH2_usage_simIn.setModelParameter('SimulationMode','normal');
end

end