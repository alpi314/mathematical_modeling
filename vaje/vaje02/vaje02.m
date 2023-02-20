format long

f = @(x) x^3 + pi;
fzero(f, 3)

h = @(x) (x - 1).^2;
fzero(h, 1.1); % problem z ničlami sode stopnje

fsolve(h, 1.1) % večje stopnje ničle nižajo natančnost

f1 = @(x, y) x.^2 + y.^2 -1;
f2 = @(x, y) (x - 1).^2 + y.^2 -1;

figure
hold on
axis equal
fimplicit(f1, 'linewidth', 2)
fimplicit(f2, 'linewidth', 2)

F = @(x) [f1(x(1), x(2)); f2(x(1), x(2))];
presek = fsolve(F, [0.5; 0.5]); % deluje zgolj z funkcijami z enim parametrom (lahko je to vektor)
plot(presek(1), presek(2), '.', 'Markersize', 30, 'color', [0; 0; 0], 'MarkerFaceColor', 'auto')

figure
hold on
axis equal
[xx, yy] = ndgrid(linspace(-1, 1), linspace(-1, 1));
% contour()

f = @(x) exp(x(1)).^x(2) -1;
fmincon(f, [0.5; 0.5], [], [], [], [], [-1; 1], [-1; 1]) % vezani ekstremi



