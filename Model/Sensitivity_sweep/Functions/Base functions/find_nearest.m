

function index = find_nearest(target_value, array)
[C, index] = min(abs(array-target_value));
end