

P_DIAGNOSTIC_elem = {'P_TANK_GS', 'P_PUMP_GS', 'P_GH2_SUPPLY_GS', 'P_VALVE_GS', ...
    'P_HOSE_GS', 'P_COUPLINGS_GS',     'P_COUPLING_AC', 'P_BYPASS', 'P_TANK_AC', ...
    'P_ENGINE_FEED', 'P_COUPLING_AC_RETURN', 'P_HOSE_RETURN_GS', 'P_SOV_RETURN_GS'};

T_DIAGNOSTIC_elem = {'T_TANK_GS', 'T_PUMP_GS', 'T_GH2_SUPPLY_GS', 'T_VALVE_GS', ...
    'T_HOSE_GS', 'T_COUPLINGS_GS', 'T_COUPLING_AC', 'T_BYPASS', 'T_TANK_AC', ...
    'T_ENGINE_FEED', 'T_COUPLING_AC_RETURN', 'T_HOSE_RETURN_GS', 'T_SOV_RETURN_GS'};

clear elems
for i = 1:length(P_DIAGNOSTIC_elem)
    elems(i) = Simulink.BusElement;
    elems(i).Name = cell2mat(P_DIAGNOSTIC_elem(i));
end

P_DIAGNOSTIC = Simulink.Bus;
P_DIAGNOSTIC.Elements = elems;


clear elems
for i = 1:length(T_DIAGNOSTIC_elem)
    elems(i) = Simulink.BusElement;
    elems(i).Name = cell2mat(T_DIAGNOSTIC_elem(i));
end

T_DIAGNOSTIC = Simulink.Bus;
T_DIAGNOSTIC.Elements = elems;
