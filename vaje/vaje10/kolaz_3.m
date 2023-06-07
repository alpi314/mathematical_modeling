c = 96;
o = optimset('TolFun',1e-16, 'Display','off');

b = [2, 3 + c/100, 9/2, 5; 0 3/2, 1, -1];

plotBezier(b)

% ukrivljenost
ukrivljenost(b, 0.5)

% vzporednost s premico
line_v = b(:, 1) - b(:, 4);
criteria_func = @(t) (line_v' * bezier_derivative(b, t)) / (norm(line_v) * norm(bezier_derivative(b, t)));
vzporeden_t = fminsearch(criteria_func, 1/2, o)

[~, P, ~] = deCasteljau(b, vzporeden_t);
scatter(P(1), P(2));

% rotiranje
b_rot = rotiraj_bezier(b, pi/2, b(:, 1), 1);
[~, P, ~] = deCasteljau(b_rot, 0.5);
S = b(:, 1) + (b(:, 4) - b(:, 1)) ./ 2;

line = [P, P - S];
sum(presek_s_premico(b, line, 1e-8))

% druga krivulja
c = [5, 5, 6; -1 1 2];

desired_d = bezier_derivative(b, 1)
criteria_func = @(V) abs(desired_d - shifted_derivative(c, V));
V = fsolve(criteria_func, [1; 1], o);
shifted_derivative(c, V)

norm(V)

function d = shifted_derivative(c, V)
    c(:, 1) = V;
    d = bezier_derivative(c, 0);
end


