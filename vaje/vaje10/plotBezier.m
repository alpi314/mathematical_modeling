function plotBezier(b)
% Metoda izrise Bezierjevo krivuljo in kontrolni poligon. Za izracun
% tock na krivulji uporabimo deCasteljauov algoritem.
% Stolpec matrike b je zaporedna kontrolna tocka Bezierjeve krivulje.
    
    
    t = linspace(0, 1, 100);
    curve = zeros(length(t), 2);
    for i = 1:length(t)
        curve(i, :) = deCasteljau(b, t(i));
    end
    
    hold on
    plot(b(:, 1), b(:, 2))
    plot(curve(:, 1), curve(:, 2))
end