function draw_bezier(b, N, lineColor, vertexColor)
% Metoda izrise Bezierjevo krivuljo in kontrolni poligon. Za izracun
% tock na krivulji uporabimo deCasteljauov algoritem.
% Stolpec matrike b je zaporedna kontrolna tocka Bezierjeve krivulje.
    
    t = linspace(0, 1, N);
    curve = zeros(2, length(t));
    for i = 1:length(t)
        [~, vrednost, ~] = deCasteljau(b, t(i));
        curve(:, i) = vrednost; 
    end
    
    if (nargin < 4)
        vertexColor = [2, 105, 2];
    end
    if (nargin < 3) 
        lineColor = [26, 186, 26];
    end

    lineColor = lineColor ./ 255;
    vertexColor = vertexColor ./ 255;
    
    plot(b(1, :), b(2, :), "Color", vertexColor)
    plot(curve(1, :), curve(2, :), "Color", lineColor)
end