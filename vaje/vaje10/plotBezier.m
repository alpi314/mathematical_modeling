function plotBezier(b_loc)
% Metoda izrise Bezierjevo krivuljo in kontrolni poligon. Za izracun
% tock na krivulji uporabimo deCasteljauov algoritem.
% Stolpec matrike b je zaporedna kontrolna tocka Bezierjeve krivulje.
    
    t = linspace(0, 1, 100);
    curve = zeros(2, length(t));
    for i = 1:length(t)
        [~, vrednost, ~] = deCasteljau(b_loc, t(i));
        curve(:, i) = vrednost; 
    end
    
    hold on
    plot(b_loc(1, :), b_loc(2, :))
    plot(curve(1, :), curve(2, :))
end