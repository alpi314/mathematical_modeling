function draw_bezier(b, N, lineColor, vertexColor)
    % Metoda izrise Bezierjevo krivuljo in kontrolni poligon. Za izracun
    % tock na krivulji uporabimo deCasteljauov algoritem.
    % Stolpec matrike b je zaporedna kontrolna tocka Bezierjeve krivulje.
    
    % naredimo diskretizacijo intervala [0, 1] za parameter t
    t = linspace(0, 1, N);
    curve = zeros(2, length(t));
    for i = 1:length(t)
        % izracunamo tocke pri vsakem diskretnem t'
        [~, vrednost, ~] = deCasteljau(b, t(i));
        curve(:, i) = vrednost; 
    end
    
    % nastavitev barve
    if (nargin < 4)
        vertexColor = [2, 105, 2];
    end
    if (nargin < 3) 
        lineColor = [26, 186, 26];
    end
    
    % pretvorba v matlab rgb format
    lineColor = lineColor ./ 255;
    vertexColor = vertexColor ./ 255;
    
    % izris krivulje in tock
    plot(b(1, :), b(2, :), "Color", vertexColor)
    plot(curve(1, :), curve(2, :), "Color", lineColor)
end