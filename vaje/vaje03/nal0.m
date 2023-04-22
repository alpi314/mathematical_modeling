% naloga 0

% a) y' = 2t, y0 = 1, na [0, 5];
% tocna resitev: y(t) = t^2 + 1
y0 = 1;
interval = [0 5];
f_rhs = @(t,y) 2*t;
[t,y] = ode45(f_rhs,interval,y0);

plot(t,y);


% b) y'' = 6t, y0 = 1, y0' = 0
% tocna resitev: y(t) = t^3 + 1
y0 = [1;0];
f_rhs2 = @(t,y) [y(2);6*t];
[t,y] = ode45(f_rhs2,interval,y0);

% prvi stolpec vsebuje vrednost y, drugi stolpec vrednosti y'
figure
plot(t,y(:,1)) 

