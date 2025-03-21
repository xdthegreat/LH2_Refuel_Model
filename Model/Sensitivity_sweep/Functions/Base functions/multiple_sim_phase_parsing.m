
function [start_warm_chilldown_index, start_warm_tank_fill_index, ...
    start_warm_warmup_index, start_warm_disconnect_index, idle_1_index, ...
    start_engine_feed_index, idle_2_index, start_cold_chilldown_index, start_cold_tank_fill_index, ...
    start_cold_warmup_index, start_cold_disconnect_index, idle_3_index, ...
    start_defuel_chilldown_index, start_defuel_drain_index, start_defuel_disconnect]...
    = multiple_sim_phase_parsing(single_simOut, i)

% this parse parsim results for each sim, to generate the start and stop
% indexes. Must be run per each 1x1 simulationOutput

    if isempty(single_simOut.ErrorMessage)
        AC_mode_data = single_simOut.yout{5}.Values.Data;
        AC_mode_time = single_simOut.yout{5}.Values.Time;

        figure(i)
        plot(AC_mode_time, AC_mode_data)
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end

        try
            
    start_warm_chilldown_index = find_nearest(mode_breakpoint_array(1), single_simOut.tout);
    start_warm_tank_fill_index = find_nearest(mode_breakpoint_array(2), single_simOut.tout);
    start_warm_warmup_index = find_nearest(mode_breakpoint_array(3), single_simOut.tout);
    start_warm_disconnect_index = find_nearest(mode_breakpoint_array(4), single_simOut.tout);
    idle_1_index = find_nearest(mode_breakpoint_array(5), single_simOut.tout);
    start_engine_feed_index = find_nearest(mode_breakpoint_array(6), single_simOut.tout);
    idle_2_index = find_nearest(mode_breakpoint_array(7), single_simOut.tout);
    start_cold_chilldown_index = find_nearest(mode_breakpoint_array(8), single_simOut.tout);
    start_cold_tank_fill_index = find_nearest(mode_breakpoint_array(9), single_simOut.tout);
    start_cold_warmup_index = find_nearest(mode_breakpoint_array(10), single_simOut.tout);
    start_cold_disconnect_index = find_nearest(mode_breakpoint_array(11), single_simOut.tout);
    idle_3_index = find_nearest(mode_breakpoint_array(12), single_simOut.tout);
    start_defuel_chilldown_index = find_nearest(mode_breakpoint_array(13), single_simOut.tout);
    start_defuel_drain_index = find_nearest(mode_breakpoint_array(14), single_simOut.tout);
    start_defuel_disconnect = find_nearest(mode_breakpoint_array(15), single_simOut.tout);
    
    
    
        catch
            disp("Full run failed, check error messages and aborts")
            start_warm_chilldown_index = 0;
            start_warm_tank_fill_index = 0;
            start_warm_warmup_index = 0;
            start_warm_disconnect_index = 0;
            idle_1_index = 0;
            start_engine_feed_index = 0;
            idle_2_index = 0;
            start_cold_chilldown_index = 0;
            start_cold_tank_fill_index = 0;
            start_cold_warmup_index = 0;
            start_cold_disconnect_index = 0;
            idle_3_index = 0;
            start_defuel_chilldown_index = 0;
            start_defuel_drain_index = 0;
            start_defuel_disconnect = 0;
        end
    else
        disp("An error occured. Please check error messages.")
    end



end