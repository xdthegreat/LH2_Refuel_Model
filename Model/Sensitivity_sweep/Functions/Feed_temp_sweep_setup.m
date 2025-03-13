

function [Feed_temp_sweep_simIn, LH2_Feed_Temp_vec] = Feed_temp_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_TEMP_COUNT, max_allowed_stop_time)

LH2_Feed_Temp_vec = linspace(19, 26, LH2_FEED_TEMP_COUNT);

Feed_temp_sweep_simIn(1:length(LH2_Feed_Temp_vec)) = Simulink.SimulationInput(mdl); 
for i = 1:length(LH2_Feed_Temp_vec) 
    if rapid_flag
        Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setVariable('LH2_Feed_Temp', LH2_Feed_Temp_vec(i));
    Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end
        

end