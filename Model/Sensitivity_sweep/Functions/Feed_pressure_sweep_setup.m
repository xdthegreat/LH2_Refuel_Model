

function [Feed_pressure_sweep_simIn, LH2_FEED_PRES_VEC] = Feed_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time)

LH2_FEED_PRES_VEC = linspace(0.2, 0.4, LH2_FEED_PRES_COUNT);

Feed_pressure_sweep_simIn(1:length(LH2_FEED_PRES_VEC)) = Simulink.SimulationInput(mdl); 
for i = 1:length(LH2_FEED_PRES_VEC) 
    if rapid_flag
        Feed_pressure_sweep_simIn(i) = Feed_pressure_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        Feed_pressure_sweep_simIn(i) = Feed_pressure_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        Feed_pressure_sweep_simIn(i) = Feed_pressure_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    Feed_pressure_sweep_simIn(i) = Feed_pressure_sweep_simIn(i).setVariable('LH2_FEED_PRES', LH2_FEED_PRES_VEC(i));
    Feed_pressure_sweep_simIn(i) = Feed_pressure_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end



end