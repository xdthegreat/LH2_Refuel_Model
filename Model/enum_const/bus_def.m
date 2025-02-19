

P_DIAGNOSTIC_elem = {'P_TANK_GS', 'P_PUMP_GS', 'P_GH2_SUPPLY_GS', 'P_VALVE_GS', ...
    'P_HOSE_GS', 'P_COUPLINGS_GS',     'P_COUPLING_AC', 'P_BYPASS', 'P_TANK_AC', ...
    'P_ENGINE_FEED', 'P_COUPLING_AC_RETURN', 'P_HOSE_RETURN_GS', 'P_VALVE_RETURN_GS', 'P_GAS_RETURN'};

T_DIAGNOSTIC_elem = {'T_TANK_GS', 'T_PUMP_GS', 'T_GH2_SUPPLY_GS', 'T_VALVE_GS', ...
    'T_HOSE_GS', 'T_COUPLINGS_GS', 'T_COUPLING_AC', 'T_BYPASS', 'T_TANK_AC', ...
    'T_ENGINE_FEED', 'T_COUPLING_AC_RETURN', 'T_HOSE_RETURN_GS', 'T_VALVE_RETURN_GS', 'T_GAS_RETURN'};

GS_VALVE_FEEDBACK_elem = {'LH2_PROP_VALVE_POS', 'GH2_PROP_VALVE_POS', 'GS_Supply_SOV_POS'...
    'GS_GH2_SOV_POS', 'GS_LH2_Return_SOV_POS', 'GS_RETURN_PROP_POS', 'GS_GH2_RETURN_PROP_POS'...
    'GS_GH2_RETURN_SOV_POS'};

AC_VALVE_FEEDBACK_elem = {'AC_Return_SOV_POS', 'AC_Supply_SOV_POS', 'AC_Bypass_SOV_POS'...
    'AC_Engine_SOV_POS'};


AC_QDOT_elem = {'AC_return_coupling_Qdot', 'AC_supply_coupling_Qdot', 'AC_bypass_line_Qdot', ...
    'AC_Tank_return_line_Qdot', 'AC_TANK_SUPPLY_LINE_QDOT', 'Engine_feed_Qdot', 'AC_Tank_Vent_Qdot'};

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

clear elems
for i = 1:length(GS_VALVE_FEEDBACK_elem)
    elems(i) = Simulink.BusElement;
    elems(i).Name = cell2mat(GS_VALVE_FEEDBACK_elem(i));
end

GS_VALVE_FEEDBACK = Simulink.Bus;
GS_VALVE_FEEDBACK.Elements = elems;

clear elems
for i = 1:length(AC_VALVE_FEEDBACK_elem)
    elems(i) = Simulink.BusElement;
    elems(i).Name = cell2mat(AC_VALVE_FEEDBACK_elem(i));
end

AC_VALVE_FEEDBACK = Simulink.Bus;
AC_VALVE_FEEDBACK.Elements = elems;


clear elems
for i = 1:length(AC_QDOT_elem)
    elems(i) = Simulink.BusElement;
    elems(i).Name = cell2mat(AC_QDOT_elem(i));
end

AC_QDOT = Simulink.Bus;
AC_QDOT.Elements = elems;
