c = 61;
b = [0 1 3 + (c / 100) 4; 1 2 2 -1];
o = optimset('TolFun',1e-16, 'Display','off');

plotBezier(b)

% vzporednost normale in premice y = x
line_vector = [1; 1];
line_normal = [-1; 1];

citeria_f = @(t) line_normal' * bezier_normal(b, t);
line_paralel_t = fzero(citeria_f, 1/2)

% kot preseka premice 3x - 2y - 2 = 0 in tangente b(0.6)
line_func = @(x) (3/2) .* x - 1;
y_0 = line_func(0);
y_1 = line_func(1);
l_vec = [1; y_1 - y_0];
b_tangent = bezier_derivative(b, 0.6);
angle_b_tangent_line = intersect_angle(l_vec, b_tangent)

% dolzina
l = bezier_length(b)

% t ko je ploscina b1 b2 b(t) minimalna
citeria_f = @(t) triangle_area(b, t);
[best_t, min_area] = fminbnd(citeria_f, 0, 1, o)


function normal = bezier_normal(b, t)
    v = bezier_derivative(b, t);
    normal = [-v(2); v(1)];
end

function a = intersect_angle(v1, v2)
    dotv1v2 = dot(v1, v2);
    normv1 = norm(v1);
    normv2 = norm(v2);
    
    a = acos(dotv1v2/(normv1 * normv2));
end

function area = triangle_area(b, t)
    T1 = b(:, 2);
    T2 = b(:, 3);
    [~, T3, ~] = deCasteljau(b, t);
    
    p_x = [T1(1), T2(1), T3(1)];
    p_y = [T1(2), T2(2), T3(2)];
    area = polyarea(p_x, p_y);
end