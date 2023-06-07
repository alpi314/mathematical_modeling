T1_x = 0;
T2 = [5; 0.1];
g = 9.81;
t = 1.29;
o = optimset('TolFun',1e-16, 'Display','off');


citeria_f = @(T1_y) abs(time([T1_x; T1_y], T2, g) - t);
T1_y = fminbnd(citeria_f, T2(2), 100)

[k, theta] = isci_theta_k(T2(1) - T1_x, T2(2) - T1_y);
risi_brah([T1_x; T1_y], T2, 1000);

% x = (k^2 / 2) * (theta - sin(theta) ... theta in [0, 1]
T_x = (1/3) * T1_x + (2/3) * T2(1)
citeria_f = @(theta) abs(((k^2 / 2) * (theta - sin(theta))) - (T_x - T1_x));
theta_for_T_x = fminbnd(citeria_f, 0, theta);

% y = (-k^2 / 2) * (1 - cos(theta)) ... theta in [0, 1]
T_y = (-k^2 / 2) * (1 - cos(theta_for_T_x)) + T1_y
hold on
scatter(T_x, T_y)

% naloga 8.3
T1_new_x = T2(1);
T2_new = [0; T2(2)];
FWANUF = [T_x; T_y]

cirteria_func = @(v) norm(intersect(k, theta, [T1_x; T1_y], T2_new, [T1_new_x; v], 0) - FWANUF);
[v, error] = fsolve(cirteria_func, 0.5, o)

intersect(k, theta, [T1_x; T1_y], T2_new, [T1_new_x; v], 1);

function t = time(T1, T2, g)
    T2_shifted = T2 - T1;
    [k,theta] = isci_theta_k(T2_shifted(1), T2_shifted(2));
    
    t =(k * theta) / sqrt(2*g);
end

function P = point_at(theta, K, T0)
    x = @(p, k) ((k^2/2) .* (p - sin(p)) + T0(1));
    y = @(p, k) ((-k^2/2) .* (1 - cos(p)) + T0(2));
    P = [x(theta, K); y(theta, K)];
end

function T = intersect(k1, theta1, T1, T2_new, T1_new, risi)
    [k2, theta2] = isci_theta_k(T2_new(1) - T1_new(1), T2_new(2) - T1_new(2));

    criteria_func = @(THETA) norm(point_at(THETA(1), k1, T1) - point_at(THETA(2), k2, T1_new));
    o = optimset('TolFun',1e-16, 'Display','off');
    THETA = fminsearch(criteria_func, [theta1/2; theta2/2], o);

    T = point_at(THETA(1), k1, T1)

    if risi
        hold on
        risi_brah(T1_new, T2_new, 1000);
        scatter(T(1), T(2));
    end
end
