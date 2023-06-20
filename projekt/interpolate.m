function b = interpolate(points, tangents)
    % na segmentu med točjo j in (j+1):
    % - > interpoliramo z Bezierovo krivuljo s tockami 
    % b(3j + k), k = 0, 1, 2, 3
    % koncna tocka je enaka u(j) zacetna pa u(j+1)
    delta_j = @(j) points(1, j + 1) - points(1, j);
    
    N = size(points, 2); % stevilo tock
    b = zeros(2, 3*N);
    for j = 1 : N
        idx = 3*(j - 1);
        b(:, idx + 1) = points(:, j); % 1
        b(:, idx + 4) = points(:, j + 1); % 4 

        b(:, idx + 2) = b(:, idx + 1) + (delta_j(j - 1) .* tangents(j - 1)) / 3;
        b(:, idx + 3) = b(:, idx + 4) - (delta_j(j - 1) .* tangents(j)) / 3;
    end
end