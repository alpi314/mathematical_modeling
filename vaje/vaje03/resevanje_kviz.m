% podatki
start_height = 40000; % zacetna visina
m = 90; % masa padalca
c = 1; % koeficient upora
S = 0.9; % povrsina na katero deluje uport
n = 10000; % delitve intervala
r = 6371000; % radij zemlje
g0 = 9.81; % gravitacijski pospesek 0

parametri = [m,c,S,r,g0,0];
start_condtion = [start_height;0];

% naloga 1
end_time = 25;
[t, h, v] = padalec_ode23s(start_condtion, end_time, n, parametri, 4);

naloga_1 = start_height - h(end)

% naloga 2
end_time = 60;

[t, h, v1] = padalec_ode23s(start_condtion, end_time, n, parametri, 4);
end_v1 = v1(end);

parametri_v2 = parametri;
parametri_v2(1) = 190;
parametri_v2(2) = 1.1;
parametri_v2(3) = 1;

[t, h, v2] = padalec_ode23s(start_condtion, end_time, n, parametri_v2, 4);
end_v2 = v2(end);

naloga_2 = abs(end_v1 - end_v2)

% naloga 3
f = @(t) end_speed(t, start_condtion, n, parametri);
[time_until_ground, max_speed] = fminbnd(f, 0, 10000)

% naloga 4
f = @(t) height_in_400s(t, start_condtion, n, parametri);
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
[t_parachute, end_height] = fsolve(f, 30, options)

% naloga 5
% Razmislek: prvih 50m padalec pada prosto ('normalno')
% Potem se zacne raztezati vrv, ki deluje proti sili gravitacije
% Fg = m * g, spremenjena sila pa se glasi F = Fg - F(vrvi)
% Novi pospešek je torej g = F / m
% Dodali bomo novi case v switch z indeksom 5, ki bo vpošteval spremembo

start_condtion = [100; 0];
parametri = [90, 0.9, 1, r, g0];

f = @(t) height(t, start_condtion, n, parametri, 5);
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
time_to_ground = fsolve(f, 5, options)

[~, h, v] = padalec_ode23s(start_condtion, time_to_ground, n, parametri, 5);
koncna_hitrost = v(end)
koncna_visina = h(end)

function v = end_speed(end_time, start_condtion, n, parametri)
    [~, ~, V] = padalec_ode23s(start_condtion, end_time, n, parametri, 4);
    v = V(end);
end

function h_end = height_in_400s(t_parachute, start_condtion, n, parametri)
    [~, h, v] = padalec_ode23s(start_condtion, t_parachute, n, parametri, 4);

    parametri_v2 = [parametri(1) parametri(2)*5 parametri(3)+10 parametri(4) parametri(5)];
    [~, h, ~] = padalec_ode23s([h(end); v(end)], 400 - t_parachute, n, parametri_v2, 4);
    h_end = h(end);
end

function h_after = height(t, start_condtion, n, parametri, type)
    [~, h, ~] = padalec_ode23s(start_condtion, t, n, parametri, type);
    h_after = h(end);
end