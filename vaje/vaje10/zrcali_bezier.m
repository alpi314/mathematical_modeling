function b_mirrored = zrcali_bezier(b, risi)
% Metoda prezrcali Bezierjevo krivuljo, podano s kontrolnimi
% tockami b, preko premice p, dolocene z zacetno in koncno kontrolno tocko.
% Izrise tudi zacetno in prezrcaljeno krivuljo ter oba kontrolna poligona.

    % parametri premice za zrcaljenje 
    % (!!! pricakuje b v dveh stolpcih ne vrstiah !!!)
    % k = (b(1, 2) - b(end, 2)) / (b(1, 1) - b(end, 1));
    % n = b(1, 2) - b(1, 1) * k;

    % zrcaljena tocke
    % middle_points_x = (b(:, 1) + k * b(:, 2) - k*n) / (k^2 + 1);
    % middle_points_y = middle_points_x .* k + n;
    % b_mirrored = 2 .* [middle_points_x middle_points_y] - b;
    
    direction = b(:, 1) - b(: ,end);
    normal = [-direction(2); direction(1)];
    b_mirrored = b - 2 * normal * (normal'  * b);
    
    if risi
        plotBezier(b);
        plotBezier(b_mirrored);
    end

end