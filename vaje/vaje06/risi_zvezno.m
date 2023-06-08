function [T_min, w, C, D] = risi_zvezno(obesisceL,obesisceD,L,tol)
% function [T_min,w] = zvVeriznica(obesisceL,obesisceD,L,tol)
% Funkcija zvVeriznica doloci (in narise) zvezno veriznico w in poisce njeno najnizjo tocko.
%
% Po knjigi Matematicno modeliranje (E. Zakrajsek).
%
% Vhod
% obesisceL, obesisceD: levo in desno obesisce veriznice, obesisceL=[a;A], obesisceD=[b;B]
% L:                    dolzina
% tol:                  toleranca pri iteraciji
%
% Izhod
% T_min:                najnizja tocka veriznice
% w:                    funkcija ('function handle') w, ki opisuje visino veriznice v tocki x
%

    z = zvezna_veriznica(obesisceL, obesisceD, L, pi, tol);

    v_plus_u = 2 * atanh((obesisceD(2) - obesisceL(2)) / L);
    v_minus_u = 2 * z;

    v = (v_plus_u + v_minus_u) / 2;
    u = (v_plus_u - v_minus_u) / 2;

    C = (obesisceD(1) - obesisceL(1)) / (v - u);
    D = obesisceL(1) - u * C;

    lambda = obesisceL(2) - C * cosh((obesisceL(1) - D) / C);

    w = @(x) lambda + C * cosh((x - D) / C);

    % draw link
    x = linspace(obesisceL(1), obesisceD(1), 1000);
    y = w(x);
    plot(x, y);
    hold on

    x0 = (obesisceD(1) - obesisceL(1)) / 2;
    x_min = fminbnd(w, obesisceL(1), obesisceD(1));
    y_min = w(x_min);
    T_min = [x_min; y_min];
       
    % draw min point
    scatter(x_min, y_min)
end