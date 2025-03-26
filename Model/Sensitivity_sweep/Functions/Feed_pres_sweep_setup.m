

function [Feed_pres_sweep_simIn, AC_LH2_TARGET_DELTA_P] = Feed_pres_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time, Log_to_file_flag)

AC_LH2_TARGET_DELTA_P = linspace(0.01, 0.1, LH2_FEED_PRES_COUNT);


Feed_pres_sweep_simIn(1:length(AC_LH2_TARGET_DELTA_P)) = Simulink.SimulationInput(mdl); 
for i = 1:length(AC_LH2_TARGET_DELTA_P) 
    if Log_to_file_flag
            Feed_pres_sweep_simIn(i) = Feed_pres_sweep_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName','Graphs/Feed_pres_sweep_simOut'+i+'.mat');
    end

    if rapid_flag
        Feed_pres_sweep_simIn(i) = Feed_pres_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        Feed_pres_sweep_simIn(i) = Feed_pres_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        Feed_pres_sweep_simIn(i) = Feed_pres_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    Feed_pres_sweep_simIn(i) = Feed_pres_sweep_simIn(i).setVariable('AC_LH2_TARGET_DELTA_P', AC_LH2_TARGET_DELTA_P(i));
    Feed_pres_sweep_simIn(i) = Feed_pres_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end
        

end