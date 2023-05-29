b = [0 1 2 3 4 2 1.5 1; 0 2 -1 1 3 2 1 0];
o = optimset('TolFun',1e-16, 'Display','off');

% osnovna oblika podatkov
% 2 vrstici:
%   prva = x kordinate
%   druga = y kordinate

% deCasteljau sprejme kontrolne tocke in parameter krivluje med 0 in 1
% vrne left, middle, right
% middle predstavlja vrednost ob podanem parametru
% left so leve kontrolne tocke subdivizije na middle (brez middle pointa)
% right so desne kontrolne tocke subdivizije na middle (brez middle pointa)

% sub_demo
% izvede deCasteljau in vrne samo left in right z dodanim middle pointom

% integriranje funkcij katerih parameter ne sme biti array (znajo delati
% samo s posamičnimi vrednostmi)
% "ArrayValued", true

% -------------------------------------------------------------------------
% naloga 1 - nova krivulja, ki se ujema v dveh tockah ob t = 0 in t = 1
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

% naloga 2 - iskanje preseka (minimiziramo normo dveh tock, zacetne
% priblizke za t nastavimo iz slike)
cirteria_func = @(X) point_difference(b, X(1), X(2));
[t1_t2] = fminsearch(cirteria_func, [0.2; 0.9], o);

[b1, right] = sub_demo(b, t1_t2(1), 0);

cirteria_func = @(X) point_difference(right, X(1), X(2));
[t2_t3] = fminsearch(cirteria_func, [0; 0.9], o);

[b2, b3] = sub_demo(right, t2_t3(2), 0);

hold off
plotBezier(b1);
plotBezier(b2);
plotBezier(b3);
hold off

[~, v, ~] = deCasteljau(b2, 1/3);
naloga_2 = norm(v)

% naloga 3 - iskanje težišča, rabimo dolžino in integral za x in y ločeno
naloga_3 = bezier_mass_center(b)

% naloga 4 - računamo dolžino tako kot pri 3
criteria_func = @(y) length_with_swap(b, y);
[~, naloga_4] = fminsearch(criteria_func, 1, o)

% naloga 5 - formula iz navodil, pazimo, ker ukrivljenosts sprejeme
% parameter med 0 in 1 tako da moramo dolžino prevesti v parameter t
naloga_5 = proznostna_energija(b)
% -------------------------------------------------------------------------

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

% parameter t kjer bo dolžina krivulje enaka v
function t = t_value_for_length(b, v)
    o = optimset('TolFun',1e-16, 'Display','off');
    len_f = @(t_val) norm(bezier_derivative(b, t_val)); % funkcija dolžine
    length_until_t = @(t) integral(len_f, 0, t, 'ArrayValued', true); % dolžina od 0 do t

    cirteria_func = @(t) length_until_t(t) - v; % želimo da je dolžina == v
    t = fsolve(cirteria_func, 1/2, o); % rešitev kriterijske funkcije
end

function d = point_difference(b, t1, t2)
    [~, v1, ~] = deCasteljau(b, t1);
    [~, v2, ~] = deCasteljau(b, t2);

    d = norm(v1 - v2);
end
