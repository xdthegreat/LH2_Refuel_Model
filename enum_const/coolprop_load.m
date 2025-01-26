[v,e] = pyversion; 

system([e,' -m pip install --user -U CoolProp']);



% http://www.coolprop.org/coolprop/HighLevelAPI.html#parameter-table
pressure_vector = 100000:10000:1000000;

u_min_liquid = py.CoolProp.CoolProp.PropsSI('Umass','P|liquid',min(pressure_vector),'T',15,'Hydrogen');  %get internal energy from pressure and temperature
u_max_gas = py.CoolProp.CoolProp.PropsSI('Umass','P',max(pressure_vector),'T',400,'Hydrogen');  %get internal energy from pressure and temperature


H2Tables = twoPhaseFluidTables([u_min_liquid/1000,u_max_gas/1000],[0.10,1],100,1000,100,...
'Hydrogen','py.CoolProp.CoolProp.PropsSI');

save('H2Tables.mat', 'H2Tables')