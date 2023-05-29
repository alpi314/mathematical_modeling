function [left, middle, right] = deCasteljau(b_loc,t)
% b MORA BITI PODAN STOLPIČNO
% vrednosti = deCasteljau(b,t)
% Metoda izracuna vrednost Bezierjeve krivulje pri parametrih vektorja t
% s pomocjo de Casteljauovega algoritma.
% Vektor b vsebuje kontrolne koeficiente Bezierjeve krivulje.
    left = b_loc(:, 1);
    right = b_loc(:, end);

    times_t = b_loc * t;
    times_one_minus_t = b_loc * (1 - t);
    b_n = times_t(:, 2:end) + times_one_minus_t(:, 1:end-1);
    
    if size(b_n, 2) == 1
        middle = b_n';
    else
        [l, middle, r] = deCasteljau(b_n, t);
        left = [left l];
        right = [r right];
    end
end