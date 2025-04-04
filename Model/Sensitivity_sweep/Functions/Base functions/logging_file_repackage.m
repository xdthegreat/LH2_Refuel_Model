

function simOut = logging_file_repackage(file_series_name, file_count)
% repackages all relevant logging files back into useful simOut format

simOut = Simulink.SimulationOutput;

for i = 1:file_count
    file_name = file_series_name + num2str(i) + "_"+ num2str(i);
    yout = load("Graphs/"+file_name);
    simOut(1, i) = yout;
    simOut(1, i).tout = yout.yout{2}.Values.Time; % use other data for tout
end

end