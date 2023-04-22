% podatki
start_height = 40000; % zacetna visina
m = 105; % masa padalca
c = 1; % koeficient upora
S = 1.2; % povrsina na katero deluje uport
n = 10000; % delitve intervala
r = 6371000; % radij zemlje
g0 = 9.81; % gravitacijski pospesek 0

parametri = [m,c,S,r,g0];
zac = [start_height;0];

% naloga 1
naloga = 1;
[~, ~, v] = padalec(zac, 300, n, parametri, 1);

povprecna_hitrost = mean(v)

% naloga 2
maximalna_hitrost = -max(-v)
terminal_vel = -sqrt(m*9.81/(1.225*c*S/2))

% naloga 3
[~, h, ~] = padalec(zac, 300, n, parametri, 3);

visina_padalca_var_g = h(end)

% naloga 4
[t, h, v] = padalec(zac, 300, n, parametri, 4);

visina_padalca_var_g_and_ro = h(end)

% naloga 5
zac = [start_height; 0];
[~, ~, v1] = padalec(zac, 30, n, parametri, 4);
v_no_speed = v1(end)

zac = [start_height; -3];
[~, ~, v2] = padalec(zac, 30, n, parametri, 4);
v_with_start_speed = v2(end)

speed_difference = v_with_start_speed - v_no_speed

% naloga 6
zac = [start_height;0];
f = @(tk) end_speed(parametri,zac,tk,n,4);

%options = optimoptions('fsolve','Display','iter', 'FunctionTolerance', 1e-16);
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
desired_speed_reached_after = fsolve(@(h) f(h) + 300,30,options)

% zacetni priblizek preberimo iz grafa
% figure
% subplot(1,2,1)
% plot(t,y,'bo-')
% hold on
% title('Pozicija v odvisnosti od casa')

% subplot(1,2,2)
% plot(t,v,'bo-')
% hold on
% title('Hitrost v odvisnosti od casa')


function hitrost = end_speed(parametri,stat_condition,end_time,n,naloga)
    [~, ~, v] = padalec(stat_condition, end_time, n, parametri, naloga);
    hitrost = v(end);

end

    
