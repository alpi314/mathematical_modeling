b = 24;
l = 16;

T1 = [1; 0];
T2 = [5; 4 + b/100];

hold on
[Tmin, w] = risi_zvezno(T1, T2, l, 1e-8);

% dolzina
line_length(w, Tmin(1), T2(1))

% ploscina lika -- loci ko se obrne
N = 1000000;

criteria_func = @(x) abs(w(x));
zero_x = fminbnd(criteria_func, 2, 5);

x = linspace(1, zero_x, N);
w_y = w(x);
total_area = polyarea([x, flip(x)], [w_y, -w_y])

x = linspace(zero_x, 5, N);
w_y = w(x);
total_area = total_area + polyarea([x, flip(x)], [w_y, -w_y])

% njamanjsi kot med premicami
criteria_func = @(x) line_angle(T1, [x; w(x)], T2);
S_x = fminbnd(criteria_func, T1(1), T2(1))

% g func
P1 = T1;
P2 = T2;
P3 = [3; w(3)];

%  w = @(x) lambda + C * cosh((x - D) / C);
% dw_dx = @(x) sinh((x - D) / C);

line1_k = zvezna_derivative(w, P1(1));
line1_n = P1(2) - line1_k * P1(1);
line1 = @(x) line1_k * x + line1_n;

line2_k = zvezna_derivative(w, P2(1));
line2_n = P2(2) - line2_k * P2(1);
line2 = @(x) line2_k * x + line2_n;

line3_k = zvezna_derivative(w, P3(1));
line3_n = P3(2) - line3_k * P3(1);
line3 = @(x) line3_k * x + line3_n;

g = @(x) max([line1(x), line2(x), line3(x)]);
[~, g_min] = fminbnd(g, T1(1), T2(1), o)
Tmin(2)
min_diff = abs(g_min - Tmin(2))

x = linspace(T1(1), T2(1), 1000);
y = zeros(size(x));
for i = 1 : length(x)
    y(i) = g(x(i));
end

plot(x, y)

function l = line_length(w, x1, x2)
    x = linspace(x1, x2, 10000);
    y = w(x);

    x_diff = diff(x);
    y_diff = diff(y);
    l = sum(sqrt(x_diff.^2 + y_diff.^2));
end

function a = line_angle(T1, S, T2)
    v1 = (T1 - S);
    v2 = (T2 - S);
    a = acos((v1' * v2) / (norm(v1) * norm(v2)));
end

function k = zvezna_derivative(w, x)
    x1 = x;
    x2 = x + 1e-14;
    y1 = w(x);
    y2 = w(x2);

    k = (y2 - y1) / (x2 - x1);
end

