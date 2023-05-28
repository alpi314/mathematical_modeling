function vrednosti = deCasteljau(b,t)
% vrednosti = deCasteljau(b,t)
% Metoda izracuna vrednost Bezierjeve krivulje pri parametrih vektorja t
% s pomocjo de Casteljauovega algoritma.
% Vektor b vsebuje kontrolne koeficiente Bezierjeve krivulje.
    times_t = b * t';
    times_one_minus_t = b * (1 - t)';
    b = times_t(2:end, :) + times_one_minus_t(1:end-1, :);
    if size(b, 1) == 1
        vrednosti = b';
    else
        vrednosti = deCasteljau(b, t);
    end
end