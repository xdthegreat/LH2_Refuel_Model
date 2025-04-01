

function [refuel_time_percentage_list, warm_refuel_GS_percentage_list] = ...
    find_percentage_difference(result_arrangement, target_dataset, time_warm_refuel_output, ...
    LH2_consumed_warm_fill_output, warm_tank_time_baseline, warm_tank_GS_consumption_baseline, ...
    refuel_time_percentage_list, warm_refuel_GS_percentage_list)

disp(result_arrangement{target_dataset} + " max time is " + max(time_warm_refuel_output{target_dataset}))
disp(result_arrangement{target_dataset} + " min time is " + min(time_warm_refuel_output{target_dataset}))
time_difference = max(time_warm_refuel_output{target_dataset}) ...
    - min(time_warm_refuel_output{target_dataset});
disp(result_arrangement{target_dataset} + " time difference is " + time_difference)
time_diff_percent = time_difference/warm_tank_time_baseline*100;
disp(result_arrangement{target_dataset} + " time difference % is " + time_diff_percent + "%")

disp(result_arrangement{target_dataset} + " max LH2 warm refuel consumption is " + max(LH2_consumed_warm_fill_output{target_dataset}))
disp(result_arrangement{target_dataset} + " min LH2 warm refuel consumption  is " + min(LH2_consumed_warm_fill_output{target_dataset}))
consumption_difference = max(LH2_consumed_warm_fill_output{target_dataset}) ...
    - min(LH2_consumed_warm_fill_output{target_dataset});
disp(result_arrangement{target_dataset} + " LH2 warm refuel consumption difference is " + ...
    consumption_difference)
consumption_diff_percent = consumption_difference/warm_tank_GS_consumption_baseline*100;
disp(result_arrangement{target_dataset} + " LH2 warm refuel consumption % difference is " + ...
    consumption_diff_percent + "%")


refuel_time_percentage_list = [refuel_time_percentage_list, time_diff_percent];
warm_refuel_GS_percentage_list = [warm_refuel_GS_percentage_list, consumption_diff_percent];



end