

function save_simout_disk(simOut)
% save simout of each run to disk

save("Graphs/simOut.mat", "simOut", '-v7.3')
simOut = [];

end