% --- REŠEVANJE NDE PRVEGA REDA --- %

% zelimo dobiti funkcijo y(t)
% t bi navadno bil x
dy = @(t, y) 2*t;
y0 = 1;
t_domain = [0, 5];

[tout, yout] = ode45(dy, t_domain, y0);

y = @(t) t.^2 + 1;



h = figure;
hold on
plot(tout, y(tout));
plot(tout, yout, 'o');
waitfor(h) % wait for figure close

% --- REŠEVANJE NDE VIŠJEGA REDA --- %

% prevedemo na vektorsko obliko enacbe NDE prvega reda
% imamo y'' = 6*t in imamo y(0) = 1 in y'(0) = 0
% funkcije, ki jih imamo v pogojih uporabimo kot nove spremenljivke 
% y1 := y in y2 = y'
% dobimo Y = [y1; y2] in Y' = [y1'; y2'] = [y2; y''] = ...
% ... = [Y(2), <nasa funkcija>

dd_y = @(t, Y) 6*t;
y0 = 1;
d_y0 = 0;

Y0 = [y0; d_y0];
d_Y = @(t, Y) [Y(2); dd_y(t, Y)]; % v splosnem
t_domain = [0, 5];

[tout, yout] = ode45(d_Y, t_domain, Y0);

y = @(t) t.^3 + 1;

hold on
plot(tout, yout(:, 1));
plot(tout, y(tout), 'o');

