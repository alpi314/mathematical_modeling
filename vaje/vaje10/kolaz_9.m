b = [0.0 1.0 1.9 3.0 4.0 2.0 1.5 1.0; 0.0 2.0 -1.0 1.0 2.8 2.2 1.0 0.0];
o = optimset('TolFun',1e-16, 'Display','off');

% samopresecisce
cirteria_func = @(T) norm(middle_point(b, T(1)) - middle_point(b, T(2)));
T_intersect1 = fminsearch(cirteria_func, [0.2; 0.8], o);

[b1, b2] = sub_demo(b, T_intersect1(1), 0);

cirteria_func = @(T) norm(middle_point(b2, T(1)) - middle_point(b2, T(2)));
T_intersect2 = fminsearch(cirteria_func, [0.1; 0.6], o);

[b2, b3] = sub_demo(b2, T_intersect2(2), 0);
 
hold on
plotBezier(b1);
plotBezier(b2);
plotBezier(b3);

% naloge

% odvod v b2(0)
bezier_derivative(b2, 0)

% tocka najdlje od b2(0)
criteria_func = @(t) -point_distance(b2, 0, t);
[point_t, distance] = fminsearch(criteria_func, 1/2)

[~, P1, ~] = deCasteljau(b2, 0);
[~, P2, ~] = deCasteljau(b2, point_t);
scatter([P1(1), P2(1)], [P1(2), P2(2)])

% povrsina omejena z b2
bezier_surface(b2, 10000)

[~, fixed_point, ~] = deCasteljau(b2, 1/4);
tangent = bezier_derivative(b2, 1/4);
normal = [-tangent(2); tangent(1)]

criteria_func = @(t) -directional_height(b2, normal, t);
[t_h, height] = fminsearch(criteria_func, 4/5)

heighest_point = middle_point(b2, 3/4);
scatter(heighest_point(1), heighest_point(2), 'yellow')
scatter(fixed_point(1), fixed_point(2), 'green')

function m = middle_point(b, t)
    [~, m, ~] = deCasteljau(b, t);
end

function d = point_distance(b, t1, t2)
    [~, P1, ~] = deCasteljau(b, t1);
    [~, P2, ~] = deCasteljau(b, t2);
    d = norm(P1 - P2);
end

function s = bezier_surface(b, N)
    points = zeros(2, N);

    t = linspace(0, 1, N);
    for i = 1 : N
        [~, points(:, i), ~] = deCasteljau(b, t(i));
    end

    s = polyarea(points(1, :), points(2, :));
end

function h = directional_height(b, tangent, t)
    p = middle_point(b, t);
    projected = (p' * tangent) / norm(tangent);
    h = norm(p - projected);
end
