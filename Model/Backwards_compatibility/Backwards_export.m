

% list of models to export for R2024a
model_list = {'GH2_prop_valve_controller', ...
    'LH2_prop_valve_controller', 'Vent_prop_valve_controller', ...
    'LH2_prop_valve', 'Gas_prop_valve', 'Return_gas_prop_valve', 'Return_coupling', ...
    'Supply_coupling', 'AC_gauge', 'AC_Engine_SOV', 'AC_bypass_pipe', ...
    'AC_engine_line_pipe', 'AC_return_SOV', 'AC_return_line_pipe', 'AC_supply_SOV', ...
    'AC_supply_line_pipe', 'AC_tank', 'GS_return_SOV', 'GS_supply_SOV', ...
    'simscape_thermofluids_full_subsystem', 'aircraft_refuel_control', ...
    'GS_refuel_control', ...
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


for i = 1:length(model_list)
    load_system(model_list{i});
    filename = save_system(model_list{i}, model_list_R2024a{i});
end


% load model
open('simscape_automatic.slx')



%% change referenced blocks

for i = 1:length(model_list)
    load_system(model_list_R2024a{i});
end

% simscape_automatic
set_param('simscape_automatic_R2024a/Fluids and controls', 'ReferencedSubsystem', 'fluids_and_control_subsystem_R2024a')



%fluids_and_control_subsystem
set_param('fluids_and_control_subsystem_R2024a/LH2 prop valve controller', 'ReferencedSubsystem', 'LH2_prop_valve_controller_R2024a')
set_param('fluids_and_control_subsystem_R2024a/GH2 prop valve controller', 'ReferencedSubsystem', 'GH2_prop_valve_controller_R2024a')
set_param('fluids_and_control_subsystem_R2024a/LH2 Vent prop valve controller', 'ReferencedSubsystem', 'Vent_prop_valve_controller_R2024a')
set_param('fluids_and_control_subsystem_R2024a/GH2 return prop valve controller', 'ReferencedSubsystem', 'Vent_prop_valve_controller_R2024a')
set_param('fluids_and_control_subsystem_R2024a/AC Gauge computer', 'ReferencedSubsystem', 'AC_gauge_R2024a')
set_param('fluids_and_control_subsystem_R2024a/Thermofluids', 'ReferencedSubsystem', 'simscape_thermofluids_full_subsystem_R2024a')



%simscape_thermofluids_full_subsystem
set_param('simscape_thermofluids_full_subsystem_R2024a/LH2 Proportional valve', 'ReferencedSubsystem', 'Return_gas_prop_valve_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GH2 vent proportional valve', 'ReferencedSubsystem', 'Return_gas_prop_valve_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GS_Supply_SOV', 'ReferencedSubsystem', 'GS_supply_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GS_GH2_Return', 'ReferencedSubsystem', 'GS_supply_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GS_Supply_Coupling', 'ReferencedSubsystem', 'Supply_coupling_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GS_Return_Coupling', 'ReferencedSubsystem', 'Return_coupling_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GS LH2 Return SOV', 'ReferencedSubsystem', 'GS_return_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GS GH2 SOV', 'ReferencedSubsystem', 'GS_return_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/LH2 vent proportional valve', 'ReferencedSubsystem', 'Return_gas_prop_valve_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/GH2 Proportional valve', 'ReferencedSubsystem', 'Gas_prop_valve_R2024a')

set_param('simscape_thermofluids_full_subsystem_R2024a/AC_Return_Coupling', 'ReferencedSubsystem', 'Return_coupling_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC_Supply_Coupling', 'ReferencedSubsystem', 'Supply_coupling_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC_supply_line_pipe', 'ReferencedSubsystem', 'AC_supply_line_pipe_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC return line pipe', 'ReferencedSubsystem', 'AC_return_line_pipe_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC bypass pipe', 'ReferencedSubsystem', 'AC_bypass_pipe_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC_Bypass_SOV', 'ReferencedSubsystem', 'AC_return_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC_Supply_SOV', 'ReferencedSubsystem', 'AC_supply_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC_Return_SOV', 'ReferencedSubsystem', 'AC_return_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC tank', 'ReferencedSubsystem', 'AC_tank_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC_Engine_SOV', 'ReferencedSubsystem', 'AC_Engine_SOV_R2024a')
set_param('simscape_thermofluids_full_subsystem_R2024a/AC engine feed pipe', 'ReferencedSubsystem', 'AC_engine_line_pipe_R2024a')


% save changed blocks
% for i = 1:length(model_list)
%     filename = save_system(model_list_R2024a{i}, 'SaveDirtyReferencedModels','on');
% end


%% export to R2024a

%save copy first
for i = 1:length(model_list)
    load_system(model_list{i} + "_R2024a");
    filename = save_system(model_list{i} + "_R2024a", ...
        "Model/Backwards_compatibility/" + model_list{i} + "_R2024a_Copy");
end


for i = 1:length(model_list)
    Simulink.exportToVersion(model_list{i} + "_R2024a_Copy", model_list_R2024a{i}, 'R2024a', ...
        'BreakUserLinks', false);
    pause(2)
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