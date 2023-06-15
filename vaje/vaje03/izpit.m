N = 10000;

g0 = 9.81;
r = 6371000;
m = 12.80;
S = 0.01;
c = 0.24;

parametri = [m,c,S,r,g0];

start_height = 0;
start_speed = 100;
start_condtion = [start_height; start_speed];

end_time = 10;
[t, h, v] = padalec_ode23s(start_condtion, end_time, N, parametri);

visina_po_10s = h(end)

criteria_func = @(t) height_after(start_condtion, t, N, parametri);
t_to_ground = fzero(criteria_func, 30);

[t, h, v] = padalec_ode23s(start_condtion, t_to_ground, N, parametri);
plot(h)

path = sum(abs(diff(h)))

start_condtion2 = [500; 0];
criteria_func = @(t) height_difference(start_condtion, start_condtion2, t, N, parametri);
collision_time = fminbnd(criteria_func, 0, t_to_ground)

[t, h, v] = padalec_ode23s(start_condtion, collision_time, N, parametri);
v1 = v(end)

[t, h, v] = padalec_ode23s(start_condtion2, collision_time, N, parametri);
v2 = v(end)

v_relative = -v1 + v2


function h = height_after(start_condtion, end_time, N, parametri)
    [t, H, v] = padalec_ode23s(start_condtion, end_time, N, parametri);
    h = H(end);
end

function h_diff = height_difference(start_condtion1, start_condtion2, end_time, N, parametri)
    h1 = height_after(start_condtion1, end_time, N, parametri);
    h2 = height_after(start_condtion2, end_time, N, parametri);
    h_diff = abs(h2 - h1);
end