

close all
%% hose_length_sweep.m
% This changes hose length over a variety of values

hose_length_vector = 5:1:20;
rapid_flag = false;
accel_flag = false;
fast_restart_flag = false;
tic;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end

clear hose_length_sweep_simIn

hose_length_sweep_simIn(1:length(hose_length_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(hose_length_vector) 
    if rapid_flag
        hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setModelParameter('SimulationMode','accelerator');
    else
        hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setModelParameter('SimulationMode','normal');
    end

    hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setVariable('hose_length', hose_length_vector(i));

    hose_length_sweep_simIn(i) = hose_length_sweep_simIn(i).setVariable('stopTime', 100000); 

end

if rapid_flag == false && accel_flag == false && fast_restart_flag
    hose_length_sweep_simOut = parsim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','on');
else
    hose_length_sweep_simOut = parsim(hose_length_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart','off');
end

toc;

%save run data
save('Graphs/hose_length_sweep.mat', 'hose_length_sweep_simOut')


zip('Graphs/hose_length_sweep.zip', 'Graphs/hose_length_sweep.mat')


%% plot

try
    load('Graphs/hose_length_sweep.mat')
catch
    disp('hose_length_sweep.mat not found')
end

%plot length of hose against LH2 used

LH2_consumed = [];
LH2_in_AC_tank = [];

for i = 1:length(hose_length_sweep_simOut)
    if isempty(hose_length_sweep_simOut(1, i).ErrorMessage)
        AC_mode_data = hose_length_sweep_simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = hose_length_sweep_simOut(1, i).yout{5}.Values.Time;
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end
        
        start_warm_chilldown_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(1));
        start_warm_tank_fill_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(2));
        start_warm_warmup_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(3));
        start_warm_disconnect_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(4));
        idle_1_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(5));
        start_engine_feed_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(6));
        idle_2_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(7));
        start_cold_chilldown_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(8));
        start_cold_tank_fill_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(9));
        start_cold_warmup_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(10));
        start_cold_disconnect_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(11));
        idle_3_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(12));
        start_defuel_chilldown_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(13));
        start_defuel_drain_index = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(14));
        start_defuel_disconnect = find(hose_length_sweep_simOut(1, i).tout == mode_breakpoint_array(15));
    
        Ground_LH2_total = hose_length_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = hose_length_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = hose_length_sweep_simOut(1, i).yout{4}.Values.Time;
    
        % disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
        % disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

        LH2_consumed(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank(i) = AC_LH2_total(idle_1_index);

    end
end


figure(1)
plot(hose_length_vector, LH2_consumed)
xlabel("Length of flexible hoses (m)")
ylabel('LH2 consumed (kg)')
titel("Total amount of LH2 consumed for warm tank refuel with different lengths of hoses")
saveas(gcf, 'Graphs/LH2 consumption for warm tank refuel sweep with 5-20m hoses.png')