

function [input_vector_output, LH2_consumed_warm_fill_output, ...
    LH2_in_AC_tank_warm_fill_output, frac_useful_LH2_warm_fill_output, ...
    LH2_consumed_cold_fill_output, LH2_in_AC_tank_cold_fill_output, ...
    frac_useful_LH2_cold_fill_output, time_warm_refuel_output, time_cold_refuel_output] = ...
        removing_errors_from_outputs(simOut, input_vector, LH2_consumed_warm_fill, ...
        LH2_in_AC_tank_warm_fill, frac_useful_LH2_warm_fill, LH2_consumed_cold_fill, ...
        LH2_in_AC_tank_cold_fill, frac_useful_LH2_cold_fill, time_warm_refuel, time_cold_refuel)
disp(time_warm_refuel)

    input_vector_output = [];
    LH2_consumed_warm_fill_output = [];
    LH2_in_AC_tank_warm_fill_output = [];
    frac_useful_LH2_warm_fill_output = [];
    LH2_consumed_cold_fill_output = [];
    LH2_in_AC_tank_cold_fill_output = [];
    frac_useful_LH2_cold_fill_output = [];
    time_warm_refuel_output = [];
    time_cold_refuel_output = [];

    for i = 1:length(simOut)
        if input_vector(i) ~= [0]
            input_vector_output = [input_vector_output, 
                input_vector(i)];
            LH2_consumed_warm_fill_output = [LH2_consumed_warm_fill_output, 
                LH2_consumed_warm_fill(i)];
            LH2_in_AC_tank_warm_fill_output = [LH2_in_AC_tank_warm_fill_output, ...
                LH2_in_AC_tank_warm_fill(i)];
            frac_useful_LH2_warm_fill_output = [frac_useful_LH2_warm_fill_output, ...
                frac_useful_LH2_warm_fill(i)];

            LH2_consumed_cold_fill_output = [LH2_consumed_cold_fill_output, ...
                LH2_consumed_cold_fill(i)];
            LH2_in_AC_tank_cold_fill_output = [LH2_in_AC_tank_cold_fill_output, ...
                LH2_in_AC_tank_cold_fill(i)];
            frac_useful_LH2_cold_fill_output = [frac_useful_LH2_cold_fill_output, ...
                frac_useful_LH2_cold_fill(i)];


            time_warm_refuel_output = [time_warm_refuel_output, time_warm_refuel(i)];
            time_cold_refuel_output = [time_cold_refuel_output, time_cold_refuel(i)];

        end
    end

end