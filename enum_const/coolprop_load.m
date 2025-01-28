


H2Tables = twoPhaseFluidTables([u_min_liquid/1000,u_max_gas/1000],[min(pressure_vector)/10^6, ...
    max(pressure_vector)/10^6],100,1000,100,...
'Hydrogen','py.CoolProp.CoolProp.PropsSI');

save('H2Tables.mat', 'H2Tables')