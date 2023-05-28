% podatki
start_height = 20; % zacetna visina
m = 77; % masa padalca
c = 1.4; % koeficient upora
S = 0.15; % povrsina na katero deluje uport
n = 10000; % delitve intervala
r = 6371000; % radij zemlje
g0 = 9.81; % gravitacijski pospesek 0
vertical_air_speed = 0;

parametri = [m,c,S,r,g0, vertical_air_speed];
start_condtion = [start_height;0];

% naloga 1
[t, h, v] = padalec_ode23s([start_height; 2], 2, n, parametri, 1);
naloga_1 = v(end)

% naloga 2
f = @(t) height([start_height; 2], t, n, parametri, 1);
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
naloga_2 = fsolve(f, 5, options)

% naloga 3
points = 10000;
v_horiz = 1;
[t, h, v] = padalec_ode23s([start_height; 0], 1, points, parametri, 1);

% dolzina poti vertikalno na odseku je enaka (h(i-1) - h(i))
h2 = [start_height; h];
a = (h2(1:end-1) - h2(2:end));
% dolzina poti horizontalno na odseku je enaka (t(i) - t(i -1)) * v_horiz
t2 = [0; t];
b = (t2(2:end) - t2(1:end-1)) .* v_horiz;
% dolzina skupne poti na odseku je potem enaka sqrt(a^2 + b^2)
naloga_3 = sum(sqrt(a.^2 + b.^2))

% naloga 4
end_time = 1.5;
parametri2 = parametri;
parametri2(end) = -10;
[~, ~, v] = padalec_ode23s([start_height; 0], end_time, points, parametri2, 1);
naloga_4 = v(end)

% naloga 5
f = @(t) end_speed(t, [start_height; 0], n, parametri);
[time_until_stopped, max_speed] = fminbnd(f, 0, 100)

[t, h, v] = padalec_ode23s([start_height; 0], time_until_stopped, n, parametri, 6);
naloga_5 = h(end)

function end_h = height(start_condition, t, n, parametri, naloga)
    [~, h, ~] = padalec_ode23s(start_condition, t, n, parametri, naloga);
    end_h = h(end);
end

function v = end_speed(end_time, start_condtion, n, parametri)
    [~, ~, V] = padalec_ode23s(start_condtion, end_time, n, parametri, 6);
    v = abs(V(end));
end
