

function simOut = simplify_data(simOut)
% reduces freqnecy of data to avoid crashing computers
    
    max_time = max(simOut.tout);
    dt = 0.1;
    time_array = 0:dt:max_time;
    
    new_simOut.tout = interp1(simOut.tout, simOut.tout, time_array);
    
    for i = 1:numElements(simOut.yout)
       if class(simOut.yout{i}.Values) == "timeseries"
            % non-bus data
            if isscalar(simOut.yout{i}.Values.Data)
                % check if timetable only has 1 value
                new_simOut.yout{i}.Values = simOut.yout{i}.Values;
            else
                new_simOut.yout{i}.Values = resample(simOut.yout{i}.Values, time_array);
            end
           
        else
            %bus data
            signal_name = fieldnames(simOut.yout{i}.Values);
            for j = 1:length(signal_name)
                eval("new_simOut.yout{" + i + "}.Values." + signal_name(j) + ...
                    " = resample(simOut.yout{" + i + "}.Values." + signal_name(j) + ", time_array);")
            end
        end
    end
    disp(new_simOut)
    simOut.tout = [];
    simOut.tout = new_simOut.tout;
    simOut.yout = [];
    simOut.yout = new_simOut.yout;
end