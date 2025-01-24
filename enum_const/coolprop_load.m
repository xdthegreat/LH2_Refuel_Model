[v,e] = pyversion; 

system([e,' -m pip install --user -U CoolProp']);



% http://www.coolprop.org/coolprop/HighLevelAPI.html#parameter-table
py.CoolProp.CoolProp.PropsSI('D','P',101325,'T',300,'Hydrogen');  %get density from pressure and temperature


pressure_vector = 100000:10000:700000;

u_min_liquid = py.CoolProp.CoolProp.PropsSI('Umass','P',min(pressure_vector),'T',15,'Hydrogen');  %get internal energy from pressure and temperature
u_max_gas = py.CoolProp.CoolProp.PropsSI('Umass','P',max(pressure_vector),'T',300,'Hydrogen');  %get internal energy from pressure and temperature


H2Tables = twoPhaseFluidTables([-1.45*10,3*10^3],[0.10,1],100,100,100,...
'Hydrogen','py.CoolProp.CoolProp.PropsSI');

save('H2Tables.mat', 'H2Tables')