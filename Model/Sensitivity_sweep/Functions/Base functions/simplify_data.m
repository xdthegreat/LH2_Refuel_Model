

function new_simOut = simplify_data(simOut)
% reduces freqnecy of data to avoid crashing computers

new_simOut = simOut;

max_time = max(new_simOut.tout);
dt = 0.001;
time_array = 0:dt:max_time;

for i = 1:33 % hardcoded because I am an idiot
     new_simOut.tout = interp1(simOut.tout, time_array);
     new_simOut.yout{i}.Values = retime(simOut.yout{i}.Values, 'regular', ...
         'fillwithmissing', 'Timestep', dt);

end