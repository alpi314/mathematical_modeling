a = 96;
A1 = [0; 5];
A2 = [8; 2 + 96 / 100];
g = 9.8;

A2_shifted = A2 - A1;
[k, theta] = isci_theta_k(A2_shifted(1), A2_shifted(2));
hold on
risi_brah(A1, A2, 1000);

x = @(theta) (1/2) * k^2 * (theta - sin(theta));
y = @(theta) (-k^2 / 2) * (1 - cos(theta));

% naloga 1
time = (k * theta) / sqrt(2*g)

% naloga 2
e = 1e-5;
criteria_func = @(theta) abs(tangent_coefficient(x(theta), x(theta + e), y(theta), y(theta + e)) + 3/4);
matching_theta = fminbnd(criteria_func, 0, pi);
P = [x(matching_theta); y(matching_theta)] + A1;
scatter(P(1), P(2))
P_y = P(2)

% naloga 3
criteria_func = @(theta) y(theta);
lowest_theta = fminbnd(criteria_func, 0, pi);
M = [x(lowest_theta); y(lowest_theta)];

p = polyfit([0, A2_shifted(1), M(1)], [0, A2_shifted(2), M(2)], 2);
% points_x = linspace(A1(1), A2(1), 100);
% points_y = p * [points_x.^2; points_x; ones(size(points_x))];
% plot(points_x, points_y)
dp = [p(1) * 2, p(2)];

time_func = @(x) sqrt((1 + polyval(dp, x).^2)) ./ sqrt(2 .* g .* -polyval(p, x));
time = integral(time_func, 0, A2_shifted(1))


function k = tangent_coefficient(x1, x2, y1, y2)
    k = (y2 - y1) / (x2 - x1);
end
