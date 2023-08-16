% Manjsi primer na fiksnem stevilu tock, kjer si lazje predstavljamo
% algoritem zapisan v interpoliraj.m

A = [0; 2];
B = [1; 4];
C = [2; -1];
tocke = [A B C];

alfa = 0.5; % alfa je na [0, 1]

% izbor delilnih tock po alfa-parametrizaciji
u = delilne_tocke(tocke, alfa); 
delta_u = diff(u);
delta_p = diff(tocke, 1, 2);

% postavitev sistema za izracun vektorjev V (tangent) v tockah
N = size(tocke, 2);
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

% dodamo enacbi za besselov zlepek za tocki v krajsicih
% Zacetni: v0 + v1 = (2 / delta0) * deltaP0
A(1, 1) = 1;
A(1, 2) = 1;
B(1, :) = (2 / delta_u(1)) .* delta_p(:, 1);

% Koncni: vN + vN-1 = (2 / deltaN-1) * deltaPN-1
A(N, N-1) = 1;
A(N, N) = 1;
B(N, :) = (2 / delta_u(N-1)) .* delta_p(:, N-1);

% izracunamo vektorje
v = A \ B;

% dolocimo kontrolne tocke za vsak segment
s = zeros(2, 3*N-2);
for j = 1:N-1
    % kontrolne tocke segmenta
    segment_start = 3*(j-1) +1;
    s(:, segment_start) = tocke(:, j);
    s(:, segment_start+1) = tocke(:, j) + (1/3) .* delta_u(j) .* v(j);
    s(:, segment_start+2) = tocke(:, j+1) - (1/3) .* delta_u(j) .* v(j+1);
    s(:, segment_start+3) = tocke(:, j+1); % nekoliko redundantno vendar se tako lepse predstavi ideja zlepka krivulj
end

% izrišemo tocke in krivuljo
hold on
scatter(tocke(1, :), tocke(2, :), 30, 'filled', 'red');
% izrisemo krivulje po segmentih
for segment_start = 1:3:3*(N-1)
    draw_bezier(s(:, segment_start:segment_start+3), 1000);
end
hold off

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