


% plot LH2 boiling point, pressure against temperature

[v,e] = pyversion; 
system([e,' -m pip install --user -U CoolProp']);

%% search for boiling point
% pressure range: 0.5-6 bar
bp_p_range = 50000:10000:600000;
bp_temp_range = zeros([1, length(bp_p_range)]);


for i = 1:length(bp_p_range)
    bp_temp_range(i) = py.CoolProp.CoolProp.PropsSI('T','P',bp_p_range(i),'Q',0,'Hydrogen');
end

figure(1)
plot(bp_temp_range, bp_p_range./10^5)
liquid_txt = "Liquid";
text(26, 1, liquid_txt)
gas_txt = "Gas";
text(20, 5, gas_txt)
ylabel("Pressure (bar)")
xlabel("Temperature (K)")
title("Boiling point of LH2")
saveas(gcf, 'Graphs/LH2 phase diagram.png')


%% 
LH2_nominal_density = py.CoolProp.CoolProp.PropsSI('D','P',120000,'T',20,'Hydrogen');