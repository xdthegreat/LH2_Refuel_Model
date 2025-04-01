

%% Room conditions

[v,e] = pyversion; 
system([e,' -m pip install --user -U CoolProp']);

%% 
H2_room_density = py.CoolProp.CoolProp.PropsSI('D','P',101325,'T',298,'Hydrogen');
room_energy_density = 120*H2_room_density