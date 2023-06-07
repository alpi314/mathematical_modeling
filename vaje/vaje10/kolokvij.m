b = [0.00 1.00 2.00 3.01 4.00 2.04 3.00; 0.00 2.00 -0.95 -1.00 3.02 1.00 0.00];
o = optimset('TolFun',1e-16, 'Display','off');

plotBezier(b)

% naloga 1
v_0 = bezier_derivative(b, 0);
v_end = bezier_derivative(b, 1);

naloga_1 = norm(v_0) + norm(v_end)


% naloga 2
cirteria_func = @(X) point_difference(b, X(1), X(2));
[t1_t2] = fminsearch(cirteria_func, [0; 1], o);
[b1, b2] = sub_demo(b, t1_t2(1), 0);
naloga_2 = mean(b1(1, :))

% naloga 3
speed_at = @(t) norm(bezier_derivative(b, t));
average_speed = integral(speed_at, 0, 1, "ArrayValued", true)

% naloga 4
len_f = @(t) norm(bezier_derivative(b, t));

speed_at_b = @(t) norm(bezier_derivative(b, t));
average_speed_left = integral(speed_at_b, 0, t1_t2(2), "ArrayValued", true)

b_reversed = flip(b, 2);
speed_at_b_reversed = @(t) norm(bezier_derivative(b_reversed, t));
average_speed_right = integral(speed_at_b_reversed, 0, 1 - t1_t2(2), "ArrayValued", true)

bezier_length(b)

% naloga 5


function d = point_difference(b, t1, t2)
    [~, v1, ~] = deCasteljau(b, t1);
    [~, v2, ~] = deCasteljau(b, t2);

    d = norm(v1 - v2);
end