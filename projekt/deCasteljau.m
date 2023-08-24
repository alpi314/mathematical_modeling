function [left, middle, right] = deCasteljau(b,t)
    % vrednosti = deCasteljau(b,t)
    % Metoda izracuna vrednost Bezierjeve krivulje pri parametrih vektorja t
    % s pomocjo de Casteljauovega algoritma.
    % Vektor b vsebuje kontrolne koeficiente Bezierjeve krivulje.
    % Metoda vrne tocko pri parametru t in kontrolne tocke
    % krivulje levo in desno od tocke middle.

    left = b(:, 1);
    right = b(:, end);

    % izracunamo trenutni nivo deCastaljau-evega algoritma
    times_t = b * t;
    times_one_minus_t = b * (1 - t);
    b_n = times_t(:, 2:end) + times_one_minus_t(:, 1:end-1);
    
    if size(b_n, 2) == 1
        % ce imamo zgolj se eno tocko je to tocka pri casu t
        middle = b_n;
    else
        % nadaljujemo algoritem na naslednjem nivoju rekurzivno
        [l, middle, r] = deCasteljau(b_n, t);
        % levim kontrolnim tockam dodamo trenutno zacetno kontrolno tocko
        left = [left l];
        % desnim kontrolnim tockam dodamo trenutno zadnjo tocko na konec
        right = [r right];
    end
end