
% model to load model
open('simscape_automatic.slx')

% list of models to export for R2024a
model_list = {'GH2_prop_valve_controller', ...
    'LH2_prop_valve_controller', 'Vent_prop_valve_controller', ...
    'LH2_prop_valve', 'Gas_prop_valve', 'Return_gas_prop_valve', 'Return_coupling', ...
    'Supply_coupling', 'AC_gauge', 'AC_Engine_SOV', 'AC_bypass_pipe', ...
    'AC_engine_line_pipe', 'AC_return_SOV', 'AC_return_line_pipe', 'AC_supply_SOV', ...
    'AC_supply_line_pipe', 'AC_tank', 'GS_return_SOV', 'GS_supply_SOV', ...
    'simscape_thermofluids_full_subsystem', ...
    'fluids_and_control_subsystem', 'simscape_automatic'};

% generate R2024a model paths
model_list_R2024a = cell([1, length(model_list)]);
for i = 1:length(model_list)
    model_list_R2024a{i} = "Model/Backwards_compatibility/" + model_list{i} + "_R2024a.slx";
end

% delete potentially doubled models
for i = 1:length(model_list)
    delete(model_list_R2024a{i})
end

%export to R2024a
for i = 1:length(model_list)
    Simulink.exportToVersion(model_list{i}, model_list_R2024a{i}, 'R2024a', ...
        'BreakUserLinks',false);
    pause(1)
end


% 
% 
% %% overall models
% 
% Simulink.exportToVersion('simscape_automatic','simscape_automatic_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('fluids_and_control_subsystem','fluids_and_control_subsystem_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% %% Control models
% % Simulink.exportToVersion('aircraft_refuel_control','aircraft_refuel_control_R2024a.slx','R2024a', ...
% %   'BreakUserLinks',true);
% 
% Simulink.exportToVersion('GH2_prop_valve_controller','GH2_prop_valve_controller_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('LH2_prop_valve_controller','LH2_prop_valve_controller_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('Vent_prop_valve_controller','Vent_prop_valve_controller_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% %% Thermofluids
% 
% Simulink.exportToVersion('simscape_thermofluids_full_subsystem','simscape_thermofluids_full_subsystem_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('LH2_prop_valve','LH2_prop_valve_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('Gas_prop_valve','Gas_prop_valve_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('Return_gas_prop_valve','Return_gas_prop_valve_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('Return_coupling','Return_coupling_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('Supply_coupling','Supply_coupling_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_gauge','AC_gauge_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_Engine_SOV','AC_Engine_SOV_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_bypass_pipe','AC_bypass_pipe_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_engine_line_pipe','AC_engine_line_pipe_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_return_SOV','AC_return_SOV_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_return_line_pipe','AC_return_line_pipe_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_supply_SOV','AC_supply_SOV_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_supply_line_pipe','AC_supply_line_pipe_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('AC_tank','AC_tank_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('GS_return_SOV','GS_return_SOV_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);
% 
% Simulink.exportToVersion('GS_supply_SOV','GS_supply_SOV_R2024a.slx','R2024a', ...
%     'BreakUserLinks',true);