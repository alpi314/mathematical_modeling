c = 85;
o = optimset('TolFun',1e-16, 'Display','off');

T1 = [-2; 1];
T2 = [2, 4 + c/100];
l = 11;
g = 9.81;

[Tmin, w, C, D] = risi_zvezno(T1, T2 ,l, 1e-16);

% najblizje izhodiscu
criteria_func = @(x) norm([x; w(x)]);
x = fminbnd(criteria_func, T1(1), T2(1), o)

% dolzina
dw_dx = @(x) sinh((x - D) / C);
length_f = @(x) sqrt(1 + dw_dx(x).^2);
L = integral(length_f, T1(1), T2(1), 'ArrayValued', true)

% hitrost
% ohranitev energije (1/2)*m*v^2 = m*g*h
% v = sqrt(2*g*h)
v0 = 10;
speed_f = @(x) 1 / (sign(T1(2) - w(x)) * sqrt(2*g*abs(T1(2) - w(x))) + v0);
V = integral(speed_f, T1(1), T2(1), 'ArrayValued', true)

% time
time_f = @(x) length_f(x) * speed_f(x);
T = integral(time_f, T1(1), T2(1), 'ArrayValued', true)


% NALOGA ---- half time
t_half = T / 2;

criteria_func = @(x) abs(integral(time_f, T1(1), x, 'ArrayValued', true) - t_half);
x = fminbnd(criteria_func, T1(1), T2(1));

integral(time_f, T1(1), x, 'ArrayValued', true);

