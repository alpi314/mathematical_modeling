% nova naloga
o = optimset('TolFun',1e-16, 'Display','off');

TA = [7; 16];
TB = [12; 19];
TC = [20; 20];


citeria_f = @(l) zvezna_min_y(TA, TB, l) - 12; % hocemo visino 12 na minimumu
AB_l = fzero(citeria_f, 20)
[AB_min, wAB] = risi_zvezno(TA, TB, AB_l, 1e-16);
AB_min_x = AB_min(1)

citeria_f = @(l) zvezna_min_y(TB, TC, l) - 14; % hocemo visino 14 na minimumu
BC_l = fzero(citeria_f, 20)
[BC_min, wBC] = risi_zvezno(TB, TC, AB_l, 1e-8);

% -----------
obesisceL = TA;
obesisceD = TB;
z = zvezna_veriznica(obesisceL, obesisceD, AB_l, pi, 1e-16);

v_plus_u = 2 * atanh((obesisceD(2) - obesisceL(2)) / AB_l);
v_minus_u = 2 * z;

v = (v_plus_u + v_minus_u) / 2;
u = (v_plus_u - v_minus_u) / 2;

C = (obesisceD(1) - obesisceL(1)) / (v - u);
D = obesisceL(1) - u * C;
%----------

% skupen min vrvi hocemo spraviti najvisje (del vrvi potegnemo iz AB na BC
% zelimo cimvisjo tocko zato predznak -
citeria_f = @(l_diff) -global_min_zvezna(TA, TB, TC, AB_l - l_diff, BC_l + l_diff);
rope_pull = fminbnd(citeria_f, 0, AB_l)

% skrajsamo AB_l za eno enoto
AB_l_new = AB_l - 1;
length_to_T = line_length(C, D, TA(1), AB_min_x)

% -----------
obesisceL = TA;
obesisceD = TB;
z = zvezna_veriznica(obesisceL, obesisceD, AB_l_new, pi, 1e-16);

v_plus_u = 2 * atanh((obesisceD(2) - obesisceL(2)) / AB_l_new);
v_minus_u = 2 * z;

v = (v_plus_u + v_minus_u) / 2;
u = (v_plus_u - v_minus_u) / 2;

C = (obesisceD(1) - obesisceL(1)) / (v - u);
D = obesisceL(1) - u * C;
%----------

criteria_func = @(x) abs(line_length(C, D, TA(1), x) - (length_to_T - 1));
[new_x, l] = fminbnd(criteria_func, 6, 10, o)

diff = abs(new_x - AB_min_x)


function y = zvezna_min_y(L, D, l)
    z = zvezna_veriznica(L, D, l, pi, 1e-16);

    v_plus_u = 2 * atanh((D(2) - L(2)) / l);
    v_minus_u = 2 * z;

    v = (v_plus_u + v_minus_u) / 2;
    u = (v_plus_u - v_minus_u) / 2;

    C = (D(1) - L(1)) / (v - u);
    kD = L(1) - u * C;

    lambda = L(2) - C * cosh((L(1) - kD) / C);

    w = @(x) lambda + C * cosh((x - kD) / C);

    x_min = fminbnd(w, L(1), D(1));
    y = w(x_min);
end

function y = global_min_zvezna(A, B, C, l1, l2)
    AB_min_y = zvezna_min_y(A, B, l1);
    BC_min_y = zvezna_min_y(B, C, l2);
    y = min(AB_min_y, BC_min_y);
end

function l = line_length(C, D, a, b)
   l = C * sinh((b - D) / C) - C * sinh((a - D) / C);
end
