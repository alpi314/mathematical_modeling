tocke = [0 1 2 3; 0 3 -1 1.5];
alfa = 0.5;
t_l = [1; -2]; % tangenta v levem krajiscu
t_r = [-0.1; -0.4]; % tangenta v desnem krajiscu

% interpolacija po segmentih
s = interpoliraj(tocke, alfa, t_l, t_r);

hold on
% izrišemo tocke
scatter(tocke(1, :), tocke(2, :), 30, 'filled', 'red');

% izrisemo krivulje po segmentih
N = size(tocke, 2);
for segment_start = 1:3:3*(N-1)
    draw_bezier(s(:, segment_start:segment_start+3), 1000);
end
hold off