

[v,e] = pyversion; 
system([e,' -m pip install --user -U CoolProp']);

% http://www.coolprop.org/coolprop/HighLevelAPI.html#parameter-table
pressure_vector = 30000:10000:1100000;
Temp_vector = 15:1:400;

u_min_liquid = py.CoolProp.CoolProp.PropsSI('Umass','P|liquid', min(pressure_vector), 'T', min(Temp_vector), 'Hydrogen');  %get internal energy from pressure and temperature
u_max_gas = py.CoolProp.CoolProp.PropsSI('Umass','P', max(pressure_vector), 'T', max(Temp_vector), 'Hydrogen');  %get internal energy from pressure and temperature


H2Tables = twoPhaseFluidTables([u_min_liquid/1000,u_max_gas/1000],[min(pressure_vector)/10^6, ...
    max(pressure_vector)/10^6],100,1000,100,...
'Hydrogen','py.CoolProp.CoolProp.PropsSI');

save('H2Tables.mat', 'H2Tables')

%% density lookup table
LH2_density_table = zeros(length(short_pressure_vector), length(short_temp_vector));
for i = 1:length(short_pressure_vector)
    for j = 1:length(short_temp_vector)
        %check if liquid phase exists
        phase = py.CoolProp.CoolProp.PropsSI('Phase','P',short_pressure_vector(i),'T',Temp_vector(j),'Hydrogen');
        if phase == 0 || phase == 6
            LH2_density_table(i, j) = py.CoolProp.CoolProp.PropsSI('D','P|liquid',short_pressure_vector(i),'T',Temp_vector(j),'Hydrogen');
        else
            LH2_density_table(i, j) = 0;
        end
    end
    for j = 2:length(LH2_density_table(i, :))
        if LH2_density_table(i, j) == 0 && LH2_density_table(i, j-1) ~= 0
            LH2_density_table(i, j) = LH2_density_table(i, j-1);
        end
    end
end

save('LH2_density_table.mat', 'LH2_density_table')

%% thermal conductivity of H2
LH2_conductivity = py.CoolProp.CoolProp.PropsSI('conductivity','P|liquid', 250000, 'T', 21, 'Hydrogen');
GH2_conductivity = py.CoolProp.CoolProp.PropsSI('conductivity','P|gas', 250000, 'T', 24, 'Hydrogen');


save('LH2_conductivity.mat', 'LH2_conductivity')
save('GH2_conductivity.mat', 'GH2_conductivity')