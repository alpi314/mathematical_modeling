A = [0.5; 1];
B = [3.5; 0.5];
edges = [A B];
L = [1 1 2 1 1.5 1];


% naloga 1
fig = figure; 

[x, y] = risi_diskretno(edges,L,L);
[~, i] = min(y);

naloga_1 = x(i) + y(i)

% naloga 2
g = 9.81;
potencialna_energija = potential_energy(y, L, g)

uiwait(fig);

% naloga 3
fig = figure; 

options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
f = @(l) fourth_coefficient(l, edges, L);
best_length_naloga_3 = fsolve(f, 1, options)

L_altered = L;
L_altered(end) = best_length_naloga_3;

risi_diskretno(edges,L_altered,L_altered);

uiwait(fig);

% naloga 4
fig = figure; 

normal_force_vector = [0; -1];
force_vector = [-1; -1];

product = normal_force_vector' * force_vector;
norm_product = norm(normal_force_vector, 2) * norm(force_vector, 2);
theta = acos(product / norm_product);

A = rotate([0.5; 1], theta);
B = rotate([3.5; 0.5], theta);
edges_2 = [A B];

X = diskretna_veriznica([-0.5;-1.2], edges_2(:, 1), edges_2(:, 2), L, L);

for i = 1:size(X, 2)
    V = rotate(X(:, i), -theta);
    X(:, i) = V;
end

hold on
plot(X(1,:),X(2,:),'LineWidth',3)
plot(X(1,:),X(2,:),'o','MarkerSize', 5,'LineWidth', 5);
axis equal
hold off

naloga_4 = min(X(2, :))

uiwait(fig);

% naloga 5
fig = figure;

options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
T = [2; 0];
f = @(r) napaka_tezisca(r, edges, L, T);
best_r = fsolve(f, 0.25, options)

hold on
L_smaller = L * best_r;
risi_diskretno(edges,L_smaller, L_smaller);
scatter(T(1), T(2));
hold off

T = tezisce(edges, L_smaller)
naloga_5 = norm(T, 2)

uiwait(fig);

function E = potential_energy(y, m, g)
    weight_centers = (y(2:end) + y(1:end-1)) / 2;
    E = sum(weight_centers .* m .* g);
end

function k = fourth_coefficient(last_length, zac, L)
    L(end) = last_length;

    X = diskretna_veriznica([-0.5;-1.2], zac(:, 1), zac(:, 2), L, L);
    
    index = 4;
    y_diff = X(2, index) - X(2, index +1);
    x_diff = X(1, index) - X(1, index +1);

    k = y_diff / x_diff;
end 

function e = napaka_tezisca(r, zac, L, T)
    L_smaller = L * r;
    T_aprox = tezisce(zac, L_smaller);

    e = norm(T - T_aprox, 2);
end

function T = tezisce(zac, L)
    X = diskretna_veriznica([-0.5;-1.2], zac(:, 1), zac(:, 2), L, L);

    y = X(2, :);
    x = X(1, :);
    
    center_y = (y(2:end) + y(1:end-1)) / 2;
    center_x = (x(2:end) + x(1:end-1)) / 2;
    weights = L ./ sum(L);
    
    T = [sum(center_x .* weights); sum(center_y .* weights)];
end

function V = rotate(V, theta)
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    V = R*V;
end

