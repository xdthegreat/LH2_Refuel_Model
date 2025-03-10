
close all
%% Feed_temp_sweep.m


LH2_Feed_Temp_vec = 18:0.25:21; % K
 
rapid_flag = false;
accel_flag = false;
tic;

%check matlab version
v = matlabRelease;
if strcmp(v.Release, 'R2024a')
    mdl = "simscape_automatic_R2024a";
else
    mdl = "simscape_automatic";
end


clear Feed_temp_sweep_simIn

Feed_temp_sweep_simIn(1:length(LH2_Feed_Temp_vec)) = Simulink.SimulationInput(mdl); 
for i = 1:length(LH2_Feed_Temp_vec) 
    if rapid_flag
        Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setModelParameter(SimulationMode="rapid-accelerator");
    elseif accel_flag
        Feed_temp_sweep_simIn = Feed_temp_sweep_simIn.setModelParameter('SimulationMode','accelerator');
    else
        Feed_temp_sweep_simIn = Feed_temp_sweep_simIn.setModelParameter('SimulationMode','normal');
    end

    Feed_temp_sweep_simIn(i) = Feed_temp_sweep_simIn(i).setVariable('LH2_Feed_Temp', LH2_Feed_Temp_vec(i));

end

if rapid_flag == false && accel_flag == false
    Feed_temp_sweep_simOut = parsim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'on');
else
    Feed_temp_sweep_simOut = parsim(Feed_temp_sweep_simIn, 'ShowSimulationManager', 'on', 'UseFastRestart', 'off');
end

toc;

%save run data
save('Graphs/Feed_temp_sweep.mat', 'Feed_temp_sweep_simOut')



%% plot
load('Graphs/Feed_temp_sweep.mat')

%plot tank size against LH2 used

LH2_consumed_warm_fill = [];
LH2_in_AC_tank_warm_fill = [];

for i = 1:length(Feed_temp_sweep_simOut)
    if isempty(Feed_temp_sweep_simOut(1, i).ErrorMessage)
        AC_mode_data = Feed_temp_sweep_simOut(1, i).yout{5}.Values.Data;
        AC_mode_time = Feed_temp_sweep_simOut(1, i).yout{5}.Values.Time;
        
        mode_breakpoint_array = [];
        for j = 2:length(AC_mode_data)
            if AC_mode_data(j-1) ~= AC_mode_data(j)
                mode_breakpoint_array = [mode_breakpoint_array, AC_mode_time(j+1)];
            end
        end
        
        start_warm_chilldown_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(1));
        start_warm_tank_fill_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(2));
        start_warm_warmup_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(3));
        start_warm_disconnect_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(4));
        idle_1_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(5));
        start_engine_feed_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(6));
        idle_2_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(7));
        start_cold_chilldown_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(8));
        start_cold_tank_fill_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(9));
        start_cold_warmup_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(10));
        start_cold_disconnect_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(11));
        idle_3_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(12));
        start_defuel_chilldown_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(13));
        start_defuel_drain_index = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(14));
        start_defuel_disconnect = find(Feed_temp_sweep_simOut(1, i).tout == mode_breakpoint_array(15));
    
        Ground_LH2_total = Feed_temp_sweep_simOut(1, i).yout{4}.Values.Data;
        AC_LH2_total = Feed_temp_sweep_simOut(1, i).yout{3}.Values.Data;
        Ground_LH2_total_time = Feed_temp_sweep_simOut(1, i).yout{4}.Values.Time;
    
        % disp("Total LH2 supplied by ground station = "+Ground_LH2_total(idle_1_index)+"kg.")
        % disp("Total LH2 in the UAM tank = "+AC_LH2_total(idle_1_index)+"kg.")

        LH2_consumed_warm_fill(i) = Ground_LH2_total(idle_1_index);
        LH2_in_AC_tank_warm_fill(i) = AC_LH2_total(idle_1_index);
        frac_useful_LH2_warm_fill(i) = LH2_in_AC_tank_warm_fill(i)/LH2_consumed_warm_fill(i);

        LH2_consumed_cold_fill(i) = Ground_LH2_total(idle_3_index) - Ground_LH2_total(idle_2_index);
        LH2_in_AC_tank_cold_fill(i) = AC_LH2_total(idle_3_index) - AC_LH2_total(idle_2_index);
        frac_useful_LH2_cold_fill(i) = LH2_in_AC_tank_cold_fill(i)/LH2_consumed_cold_fill(i);

        time_warm_refuel(i) = Ground_LH2_total_time(idle_1_index);

    end
end


figure(1)
plot(LH2_Feed_Temp_vec, time_warm_refuel)
xlabel("LH2 feed temperature (K)")
ylabel('Time taken per warm tank refuel (s)')
title("Time taken for for warm tank refuel with different LH2 feed temperature")
saveas(gcf, 'Graphs/Time taken for warm tank refuel vs LH2 feed temp.png')


figure(2)
plot(LH2_Feed_Temp_vec, LH2_consumed_warm_fill)
xlabel("LH2 feed temperature (K)")
ylabel('LH2 consumed (kg)')
title("Total LH2 consumed for for cold tank refuel with different LH2 feed temperature")
saveas(gcf, 'Graphs/LH2 consumed for warm tank filling vs LH2 feed temp.png')