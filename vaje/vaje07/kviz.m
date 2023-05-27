T1 = [1; 5];
T2 = [6; 2];
T2_shifted = T2 - T1;
g = 9.81;

[k, theta] = isci_theta_k(T2_shifted(1), T2_shifted(2));
risi_brah(T1, T2, 1000)

% naloga 1
time = @(t) (k * t) / sqrt(2*g);
time_until_finish = time(theta)

% naloga 2
T3 = [3; 2];
T3_shifted = T3 - T1;
k13 = line_coeff(T1, T3);

integral_function = @(x) sqrt((1 + k13.^2) ./ (2 .* g .* (-k13 .* x)));
time_on_line = integral(integral_function, 0, T3_shifted(1));

horiz_distance = T2(1) - T3(1);
v_at_T3 = sqrt(2*g*-T3_shifted(2));

% SOLUTION BY SEPERATE INTEGRAL (using v0 =/= 0)
% k32 = line_coeff(T3, T2);
% T2_shifted_by_3 = T2 - T3;
% integral_function_from_T3 = @(x) sqrt((1 + k32.^2)) ./ (sqrt(2 .* g .* (-k32 .* x)) - v_at_T3);
% integral(integral_function, 0, T2_shifted_by_3(1))

% SOLUTION IN ONE PART WOULD BE LIKE
% k = @(x) k13 if x < T3(1) else k23
% integral_function = @(x) sqrt((1 + k(x).^2)) ./ sqrt(2 .* g .* (-k(x) .* x));
% integral(integral_function, 0, T2_shifted_by_3(1))

total_time = time_on_line + horiz_distance / v_at_T3

% naloga 3
speed_func = @(t) -speed_at(g, k, t);
[~, max_speed] = fminsearch(speed_func, 9)

% naloga 4
time = @(t) (k * t) / sqrt(2*g);
desired_time = @(theta) time(theta) - 1.5;
theta_for_1_5 = fzero(desired_time, T2(1));

x = (1/2) * k^2 * (theta_for_1_5 - sin(theta_for_1_5));
y = -(1/2) * k^2 * (1 - cos(theta_for_1_5));

T_1_5 = [x; y] + T1;
norm_1_5 = norm(T_1_5, 2)

% naloga 5
x = (1/2) * k^2 * (theta - sin(theta));
y = -(1/2) * k^2 * (1 - cos(theta));

v_end = sqrt(2*g*-y);
x = x + T1(1);
y = y + T1(2);

% PREDPOSTAVKA: kroglica se ne premika horizontalno
v_end_horiz = -cos(theta) * v_end
v_end_verti = -sin(theta) * v_end

% REŠIMO: s = (1/2) * g * t^2 + t * v
height = @(t) y + v_end_verti * t + (-g) * t^2;
t_to_ground = fzero(height, 1)

% PREDPOSTAVKA: kroglica se premika horizontalno
% t_to_ground = sqrt(2*y / g);

x_end = x + v_end_horiz * t_to_ground

function v = speed_at(g, k, t)
    y = -(1/2) * k^2 * (1 - cos(t));
    v = sqrt(2*g*-y);
end

function k = line_coeff(T1, T2)
    k = (T1(2) - T2(2)) / (T1(1) - T2(1));
end