


function [Tank_size_sweep_simIn, m_LH2_vector] = ...
    Tank_size_sweep_setup(rapid_flag, accel_flag, mdl, tank_size_count, max_allowed_stop_time, ...
    AC_tank_vol_limit, AC_tank_cross_sectional_area, AC_tank_radius, Log_to_file_flag)


m_LH2_vector = linspace(16, 70, tank_size_count);
tank_volume_vector = m_LH2_vector./(70*AC_tank_vol_limit);
AC_tank_surface_area_vector = AC_tank_cross_sectional_area*2 + AC_tank_radius*2*pi.*tank_volume_vector/AC_tank_cross_sectional_area;



Tank_size_sweep_simIn(1:length(tank_volume_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(tank_volume_vector) 
    if Log_to_file_flag
            Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setModelParameter('LoggingToFile','on',...
                                'LoggingFileName',strcat('Graphs/Tank_size_sweep_simOut', num2str(i), '.mat'));
    end
    if rapid_flag
        Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setVariable('AC_tank_volume', tank_volume_vector(i));
    Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setVariable('AC_tank_surface_area', AC_tank_surface_area_vector(i));
    Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setVariable('m_LH2', m_LH2_vector(i));
    Tank_size_sweep_simIn(i) = Tank_size_sweep_simIn(i).setVariable('stopTime', max_allowed_stop_time); 

end


end