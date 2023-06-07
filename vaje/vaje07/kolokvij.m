T1 = [1.00; 5.35];
T2 = [6.85; 3.50];
T2_shifted = T2 - T1;
g = 9.81;

[k, theta] = isci_theta_k(T2_shifted(1), T2_shifted(2))

risi_brah(T1, T2, 1000)

% naloga 1
y = @(theta) (-k^2 / 2) * (1 - cos(theta));
dy_by_x = sqrt(-(k^2/y(theta)) - 1)

% naloga 2
T3 = [3; 3];
T3_shifted = T3 - T1;
k13 = line_coeff(T1, T3);

integral_function = @(x) sqrt((1 + k13.^2) ./ (2 .* g .* (-k13 .* x)));
time_on_line_one = integral(integral_function, 0, T3_shifted(1));

v_at_T3 = sqrt(2*g*-T3_shifted(2));

k32 = line_coeff(T3, T2);
T2_shifted_by_3 = T2 - T3;
integral_function_from_T3 = @(x) sqrt((1 + k32.^2)) ./ (sqrt(2 .* g .* (-k32 .* x)) - v_at_T3);
time_on_line_two = integral(integral_function, 0, T2_shifted_by_3(1))

time_on_line = time_on_line_one + time_on_line_two

% naloga 3
theta_1s = time_to_theta(g, k, 1);
y_1s = (-k^2 / 2) * (1 - cos(theta_1s));
naloga_3 = sqrt(2*g*-y_1s)

% naloga 4
x = (1/2) * k^2 * (theta - sin(theta));
dx = (1/2) * k^2 * (1 - cos(theta));
y = -(1/2) * k^2 * (1 - cos(theta));
dy = (1/2) * k^2 * sin(theta);

v_end = sqrt(2*g*-y);
v_direction = [dx; dy];
v_end_directional = (v_direction / norm(v_direction)) .* v_end;

height = @(t) (-g/2) * t^2 - v_end_directional(2) * t + T2(2);

y_end = height(1)

% naloga 5
cirteria_func = @(T2_new) naloga_5(g, T1, T2_new);
[T2_new, error] = fsolve(cirteria_func, T2);

naloga_5_solution = norm(T2_new)

function theta = time_to_theta(g, k, t)
    theta = t * sqrt(2*g) / k;
end

function error = naloga_5(g, T1, T2)
    T2_shifted = T2 - T1;
    [k, theta] = isci_theta_k(T2_shifted(1), T2_shifted(2));
    time = (k * theta) / sqrt(2*g);
    
    y = @(theta) (-k^2 / 2) * (1 - cos(theta));
    dy_by_x = sqrt(-(k^2/y(theta)) - 1);

    
    error = [abs(time - 1.5); dy_by_x];

end

function k = line_coeff(T1, T2)
    k = (T1(2) - T2(2)) / (T1(1) - T2(1));
end