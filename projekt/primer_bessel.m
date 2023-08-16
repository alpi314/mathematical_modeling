tocke = [0 1 2 3 3 3.5; 0 3 0 0 3 1];
alfa = 0.5; % alfa = 0.5 ... Besselov zlepek

% interpolacija po segmentih
s = interpoliraj(tocke, alfa);

hold on
% izrišemo tocke
scatter(tocke(1, :), tocke(2, :), 30, 'filled', 'red');

% izrisemo krivulje po segmentih
N = size(tocke, 2);
for segment_start = 1:3:3*(N-1)
    draw_bezier(s(:, segment_start:segment_start+3), 1000);
end
hold off