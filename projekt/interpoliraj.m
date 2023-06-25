function s = interpoliraj(tocke, alfa, t_l, t_r)
    % tocke - (2, N) matrika tock, ki jih interpoliramo
    % alfa - parameter za izbor delilnih tock
    % t_l - tangenta v levi tocki
    % t_r - tangenta v desni tocki

    % izbor delilnih tock po alfa-parametrizaciji
    u = delilne_tocke(tocke, alfa); 
    delta_u = diff(u);
    delta_p = diff(tocke, 1, 2);
    
    % postavitev in resitev sistema za oceno vektorjev v tockah
    if nargin == 4
        [A, B] = sistem_za_vektorje(delta_p, delta_u, t_l, t_r);
    else
        [A, B] = sistem_za_vektorje(delta_p, delta_u);
    end
    v = A \ B;

    
    % dolocimo kontrolne tocke za vsak segment
    N = size(tocke, 2);
    s = zeros(2, 3*N-2);
    for j = 1:N-1
        % kontrolne tocke segmenta
        segment_start = 3*(j-1) +1;
        s(:, segment_start) = tocke(:, j);
        s(:, segment_start+1) = tocke(:, j) + (1/3) .* delta_u(j) .* v(j);
        s(:, segment_start+2) = tocke(:, j+1) - (1/3) .* delta_u(j) .* v(j+1);
        s(:, segment_start+3) = tocke(:, j+1); % nekoliko redundantno vendar se tako lepse predstavi ideja zlepka krivulj
    end
end

% funkcija vrne alfa parametrizacijo delilnih točk
function u = delilne_tocke(tocke, alfa)
    delta_p = diff(tocke, 1, 2);

    N = size(tocke, 2);
    u = zeros(1, N); % prvo tocko pustimo na 0
    for j = 2:N
        u(j) = u(j-1) + norm(delta_p(j-1)).^alfa;
    end
    u = u ./ u(end); % normaliziramo točke na interval [0, 1]
end

function [A, B] = sistem_za_vektorje(delta_p, delta_u, t_l, t_r)
    % postavitev sistema za izracun vektorjev V (tangent) v tockah
    N = size(delta_p, 2) +1;
    A = zeros(N, N);
    B = zeros(N, 2);
    
    % j = 1...N-1 (pri nas 2...N-1)
    for j = 2:N-1
        % ∆j/(∆j−1 + ∆j) * V(j−1) + 2 * V(j) + ∆j−1/(∆j−1 + ∆j) * V(j+1) = b(j)
        A(j, j-1) = delta_u(j) / (delta_u(j-1) + delta_u(j));
        A(j, j) = 2;
        A(j, j+1) = delta_u(j-1) / (delta_u(j-1) + delta_u(j));
        
        % b(j) =  3/(∆j−1 + ∆j) * (∆j/∆j−1 *∆P(j−1) + ∆j−1/∆j * ∆P(j))
        % napisano v vec vrsticah za lazjo berljivost
        delta_previous_P = delta_u(j) .* delta_p(:, j-1) ./ delta_u(j-1);
        delta_current_P = delta_u(j-1) .* delta_p(:, j) ./ delta_u(j);
        B(j, :) = (3 / (delta_u(j-1) + delta_u(j))) .* (delta_previous_P + delta_current_P);
    end

    if nargin == 4
        % v0 = t_l
        A(1, 1) = 1;
        B(1, :) = t_l;

        % vN = t_r
        A(N, N) = 1;
        B(N, :) = t_r;
    else
        % dodamo enacbi za besselov zlepek za tocki v krajsicih
        % Zacetni: v0 + v1 = (2 / delta0) * deltaP0
        A(1, 1) = 1;
        A(1, 2) = 1;
        B(1, :) = (2 / delta_u(1)) .* delta_p(:, 1);
        
        % Koncni: vN + vN-1 = (2 / deltaN-1) * deltaPN-1
        A(N, N-1) = 1;
        A(N, N) = 1;
        B(N, :) = (2 / delta_u(N-1)) .* delta_p(:, N-1);
    end
end