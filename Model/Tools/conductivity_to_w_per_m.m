

% thermal conductivity to heat transfer coefficients for pipes and hoses
function W_per_m = conductivity_to_w_per_m(conductivity, ...
    inner_dia, outer_dia, delta_T)
    W_per_m = 2*pi*conductivity/log(outer_dia/inner_dia)*delta_T;
end