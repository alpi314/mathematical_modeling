function draw_bezier(b, N)
% Metoda izrise Bezierjevo krivuljo in kontrolni poligon. Za izracun
% tock na krivulji uporabimo deCasteljauov algoritem.
% Stolpec matrike b je zaporedna kontrolna tocka Bezierjeve krivulje.
    
    t = linspace(0, 1, N);
    curve = zeros(2, length(t));
    for i = 1:length(t)
        [~, vrednost, ~] = deCasteljau(b, t(i));
        curve(:, i) = vrednost; 
    end
    
    plot(b(1, :), b(2, :), "Color", "#074d01")
    plot(curve(1, :), curve(2, :), "Color", "#10ab02")
end