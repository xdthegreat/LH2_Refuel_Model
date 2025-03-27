
function LH2_usage_graphing(LH2_usage_simOut)

    % find time index of data
    figure(1)
    AC_mode_data = LH2_usage_simOut.yout{5}.Values.Data;
    AC_mode_time = LH2_usage_simOut.yout{5}.Values.Time;
    plot(AC_mode_time, AC_mode_data)
    title("AC modes")
    
    mode_breakpoint_array = [];
    for i = 2:length(AC_mode_data)
        if AC_mode_data(i-1) ~= AC_mode_data(i)
            mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(i+1)];
        end
    end

    disp(mode_breakpoint_array)
    
    start_warm_chilldown_index = find_nearest(mode_breakpoint_array(1), LH2_usage_simOut.tout);
    start_warm_tank_fill_index = find_nearest(mode_breakpoint_array(2), LH2_usage_simOut.tout);
    start_warm_warmup_index = find_nearest(mode_breakpoint_array(3), LH2_usage_simOut.tout);
    start_warm_disconnect_index = find_nearest(mode_breakpoint_array(4), LH2_usage_simOut.tout);
    idle_1_index = find_nearest(mode_breakpoint_array(5), LH2_usage_simOut.tout);
    start_engine_feed_index = find_nearest(mode_breakpoint_array(6), LH2_usage_simOut.tout);
    idle_2_index = find_nearest(mode_breakpoint_array(7), LH2_usage_simOut.tout);
    start_cold_chilldown_index = find_nearest(mode_breakpoint_array(8), LH2_usage_simOut.tout);
    start_cold_tank_fill_index = find_nearest(mode_breakpoint_array(9), LH2_usage_simOut.tout);
    start_cold_warmup_index = find_nearest(mode_breakpoint_array(10), LH2_usage_simOut.tout);
    start_cold_disconnect_index = find_nearest(mode_breakpoint_array(11), LH2_usage_simOut.tout);
    idle_3_index = find_nearest(mode_breakpoint_array(12), LH2_usage_simOut.tout);
    start_defuel_chilldown_index = find_nearest(mode_breakpoint_array(13), LH2_usage_simOut.tout);
    start_defuel_drain_index = find_nearest(mode_breakpoint_array(14), LH2_usage_simOut.tout);
    start_defuel_disconnect = find_nearest(mode_breakpoint_array(15), LH2_usage_simOut.tout);

    % LH2 usage for 
    Ground_LH2_total = LH2_usage_simOut.yout{4}.Values.Data;
    AC_LH2_total = LH2_usage_simOut.yout{3}.Values.Data;
    Ground_LH2_total_time = LH2_usage_simOut.yout{4}.Values.Time;
    
    figure(100)
    hold on
    plot(Ground_LH2_total_time, Ground_LH2_total)
    plot(Ground_LH2_total_time, AC_LH2_total)
    legend(["Supplied by Ground Station", "Tank level"])
    title("Total usage of LH2 over time")
    xlabel("Time (s)")
    ylabel("LH2 used (kg)")
    hold off
    
    figure(101)
    hold on
    title("Total usage of LH2 for warm tank refuel")
    plot(Ground_LH2_total_time(start_warm_chilldown_index:idle_1_index), ...
        Ground_LH2_total(start_warm_chilldown_index:idle_1_index), 'LineWidth', 2)
    plot(Ground_LH2_total_time(start_warm_chilldown_index:idle_1_index), ...
        AC_LH2_total(start_warm_chilldown_index:idle_1_index), 'LineWidth', 2)
    legend(["Supplied by ground station", "UAM tank gauge"])
    xlabel("Time (s)")
    ylabel("LH2 used (kg)")
    ylim([0, 45])
    hold off
    disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
    disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")
    saveas(gcf, 'Graphs/LH2 consumption for warm tank refuel with unmodified calculations.png')
    
    % wall temp
    figure(102)
    hold on
    title("UAM tank wall temperature against time")
    AC_tank_wall_temp_data = LH2_usage_simOut.yout{17}.Values.Data;
    AC_tank_wall_temp_time = LH2_usage_simOut.yout{17}.Values.Time;
    plot(AC_tank_wall_temp_time, AC_tank_wall_temp_data)
    xlabel("Time (s)")
    ylabel("Temperature (K)")
    hold off
    
    
    
    figure(103)
    hold on
    title("Total usage of LH2 for cold tank refuel")
    plot(Ground_LH2_total_time(start_cold_chilldown_index:idle_3_index) - Ground_LH2_total_time(start_cold_chilldown_index), ...
        Ground_LH2_total(start_cold_chilldown_index:idle_3_index) - Ground_LH2_total(start_cold_chilldown_index), 'LineWidth', 2)
    plot(Ground_LH2_total_time(start_cold_chilldown_index:idle_3_index) - Ground_LH2_total_time(start_cold_chilldown_index), ...
        AC_LH2_total(start_cold_chilldown_index:idle_3_index),'LineWidth', 2)
    legend(["Supplied by ground station", "Stored in UAM tank"])
    xlabel("Time (s)")
    ylabel("LH2 used (kg)")
    ylim([0, 45])
    hold off
    disp("Total LH2 supplied by ground station = " + ...
        (Ground_LH2_total(idle_3_index)-Ground_LH2_total(start_cold_chilldown_index)) + "kg.")
    disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")
    saveas(gcf, 'Graphs/LH2 consumption for cold tank refuel with unmodified calculations.png')



tank_filling_time_info = {Ground_LH2_total_time(idle_1_index), ...
    Ground_LH2_total_time(idle_3_index) - ...
    Ground_LH2_total_time(start_cold_chilldown_index), ...
    AC_LH2_total(idle_1_index) - AC_LH2_total(start_warm_chilldown_index), ...
    Ground_LH2_total(idle_1_index) - Ground_LH2_total(start_warm_chilldown_index), ...
    AC_LH2_total(idle_3_index) - AC_LH2_total(start_cold_chilldown_index), ...
    Ground_LH2_total(idle_3_index) - Ground_LH2_total(start_cold_chilldown_index)};


tank_filling_time_info_table = cell2table(tank_filling_time_info, ...
    'VariableNames', {'Warm tank fill time (s)', 'Cold tank fill time (s)', ...
    'Warm tank UAM total', 'Warm tank GS consumed', ...
    'Cold tank UAM total', 'Cold tank GS consumed'});
    
    writetable(tank_filling_time_info_table, "Graphs/normal_tank_filling_time_total_consumption_results.xlsx")
    delete('Graphs\normal_tank_filling_time_total_consumption_results.xlsx')
    writetable(tank_filling_time_info_table, "Graphs/normal_tank_filling_time_total_consumption_results.xlsx")



end