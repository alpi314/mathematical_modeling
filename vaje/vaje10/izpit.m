% fminbnd, fminsearch, fmincon
% fzero, 
b = [-2.02     0.00     0.00     0.96     0.00     2.00; 5.00     3.00     0.00     2.02     3.00     4.00];

bezier_length(b)

criteria_func = @(shift) length_with_shift(b, shift);
[shift, v] = fminbnd(criteria_func, -10, 10)


plotBezier(b);

b_ground = premakni_bezier(b, -b(:, 1), 0);

criteria_func = @(angle) rotate_height_offset(b_ground, angle);
angle = fzero(criteria_func, pi);

b_ground = rotiraj_bezier(b_ground, angle, [0; 0], 1);

criteria_func = @(t) -height(b_ground, t);
[t, h] = fminbnd(criteria_func, 0, 1)

function l = length_with_shift(b, shift)
    b_new = b;
    b_new(2, 3) = shift;

    l = bezier_length(b_new);
end

function h = rotate_height_offset(b, angle)
    b_new = rotiraj_bezier(b, angle, [0; 0], 0);
    h = b_new(2, end);
end

function h = height(b, t)
    [~, P, ~] = deCasteljau(b, t);
    h = P(2);
end