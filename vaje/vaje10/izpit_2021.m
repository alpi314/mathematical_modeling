b = [-2.00     -1.06     0.00     0.96     0.00     3.00;     5.00     3.00     0.00     2.00     4.00     6.00];
o = optimset('TolFun',1e-16);

plotBezier(b);

b_rotated = rotiraj_bezier(b, pi, b(:, 1), 0);
b_rotated = zrcali_bezier(b_rotated, [0 1; 0 0], 0);
b_rotated = premakni_bezier(b_rotated, b(:, 1) - b_rotated(:, end), 0);



function d = match_ends(b, b_rotated, angle)
    new_b = rotiraj_bezier(b_rotated, angle, b_rotated(:, 1), 0);
    d = b()
end