b = [0 1 2 3 4 2 1.5 1; 0 2 -1 1 3 2 1 0];
o = optimset('TolFun',1e-16, 'Display','off');

plotBezier(b);

% naloga 1
bk = b(:, :);

[~, b_0, ~] = deCasteljau(b, 0);
[~, b_1, ~] = deCasteljau(b, 1);

% very general solution
condition_f = @(X) move_and_rotate(b_0, b_1, bk, X(1), [X(2); X(3)]);
X = fsolve(condition_f, [pi/2; 1; 1], o);

bk = bk - [X(2); X(3)];
bk = rotiraj_bezier(bk, X(1), 0);

[~, v, ~] = deCasteljau(bk, 1/3);
naloga_1 = norm(v)

% naloga 2


% naloga 3
naloga_3 = bezier_mass_center(b)

% naloga 4
criteria_func = @(y) length_with_swap(b, y);
[~, naloga_4] = fminsearch(criteria_func, 1, o)

% naloga 5
naloga_5 = proznostna_energija(b)


function diff = move_and_rotate(b_0, b_1, bk, phi, shift)
    bk = bk - shift;
    bk = rotiraj_bezier(bk, phi, 0);

    [~, bk_0, ~] = deCasteljau(bk, 0);
    [~, bk_1, ~] = deCasteljau(bk, 1);

    diff = [norm(b_0 - bk_1), norm(b_1 - bk_0)];
end

function l = length_with_swap(b, y)
    b(2, 4) = y;
    l = bezier_length(b);
end

function P = proznostna_energija(b)
    l = bezier_length(b);
    energy_func = @(v) ukrivljenost(b, t_value_for_length(b, v)).^2;

    P = integral(energy_func, 0, l, "ArrayValued", true);
end

function t = t_value_for_length(b, v)
    o = optimset('TolFun',1e-16, 'Display','off');
    len_f = @(t_val) norm(bezier_derivative(b, t_val));
    length_until_t = @(t) integral(len_f, 0, t, 'ArrayValued', true);
    cirteria_func = @(t) length_until_t(t) - v;
    t = fsolve(cirteria_func, 1/2, o);
end
