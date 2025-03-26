

function [UAM_tank_pressure_sweep_simIn, LH2_FEED_PRES_VEC] = UAM_tank_pressure_sweep_setup(rapid_flag, accel_flag, ...
    mdl, LH2_FEED_PRES_COUNT, max_allowed_stop_time, Log_to_file_flag)

LH2_FEED_PRES_VEC = linspace(0.2, 0.4, LH2_FEED_PRES_COUNT);

UAM_tank_pressure_sweep_simIn(1:length(LH2_FEED_PRES_VEC)) = Simulink.SimulationInput(mdl); 
for i = 1:length(LH2_FEED_PRES_VEC) 
    if Log_to_file_flag
            UAM_tank_pressure_sweep_simIn(i) = UAM_tank_pressure_sweep_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName',strcat('Graphs/UAM_tank_pressure_sweep_simOut', num2str(i), '.mat'));
    end

    if rapid_flag
        UAM_tank_pressure_sweep_simIn(i) = UAM_tank_pressure_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        UAM_tank_pressure_sweep_simIn(i) = UAM_tank_pressure_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        UAM_tank_pressure_sweep_simIn(i) = UAM_tank_pressure_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    UAM_tank_pressure_sweep_simIn(i) = UAM_tank_pressure_sweep_simIn(i).setVariable('LH2_FEED_PRES', LH2_FEED_PRES_VEC(i));
    UAM_tank_pressure_sweep_simIn(i) = UAM_tank_pressure_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end



end