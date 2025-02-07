 

% TODO: change model to fluids_&_control.slx if needed
% change model to runtime configuration


clc
%% valve_diameter_sweep.m

valve_diameter_vector = 0.01:0.002:0.024;

tic;
% for i = 1:length(valve_diameter_vector)
% 
%     supply_valve_orifice_radius = valve_diameter_vector(i);
%     supply_valve_orifice_area = supply_valve_orifice_radius^2*pi;
% 
%     return_valve_orifice_radius = valve_diameter_vector(i)*2;
%     return_valve_orifice_area = return_valve_orifice_radius^2*pi;
% 
%     engine_feed_valve_orifice_radius = valve_diameter_vector(i);
%     engine_feed_valve_orifice_area = engine_feed_valve_orifice_radius^2*pi;
% 
% 
%     model = "simscape_automatic";
% 
%     simin = Simulink.SimulationInput(model);
%     simin = setModelParameter(simin,SimulationMode="accelerator");
% 
%     simOut(i) = sim(simin);
% end

%parsim version
mdl = "simscape_automatic";
simIn(1:length(valve_diameter_vector)) = Simulink.SimulationInput(mdl); 
for i = 1:length(valve_diameter_vector) 
    simIn(i) = simIn(i).setModelParameter('SimulationMode','accelerator');
    simIn(i) = simIn(i).setVariable('supply_valve_orifice_radius',valve_diameter_vector(i)); 
    supply_valve_orifice_area_per_sim = valve_diameter_vector(i)^2*pi;
    simIn(i) = simIn(i).setVariable('supply_valve_orifice_area',supply_valve_orifice_area_per_sim); 

    simIn(i) = simIn(i).setVariable('return_valve_orifice_radius',valve_diameter_vector(i)*2); 
    return_valve_orifice_area_per_sim = (valve_diameter_vector(i)*2)^2*pi;
    simIn(i) = simIn(i).setVariable('return_valve_orifice_area',return_valve_orifice_area_per_sim);

    simIn(i) = simIn(i).setVariable('engine_feed_valve_orifice_radius',valve_diameter_vector(i)); 
    engine_feed_valve_orifice_area_per_sim = valve_diameter_vector(i)^2*pi;
    simIn(i) = simIn(i).setVariable('engine_feed_valve_orifice_area',engine_feed_valve_orifice_area_per_sim);
end

simOut = parsim(simIn);

toc;


%% ans processing

for i = 1:length(valve_diameter_vector)
    if isempty(simOut(1, i).ErrorMessage)
        figure(i)
        AC_mode_data = simOut(1, i).yout{5}.Values.Data;
        time_array = simOut(1, i).yout{5}.Values.Time;
        plot(time_array, AC_mode_data)
    end
end
