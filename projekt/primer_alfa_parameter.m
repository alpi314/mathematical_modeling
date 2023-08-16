% Primer animira spreminjanje vrednosti parametra alfa

N = 25;
tocke = [0 1 2 3 3 3.5; 0 3 0 0 3 1];
alfa = linspace(0, 1, N);


hold on
% izrišemo tocke
scatter(tocke(1, :), tocke(2, :), 30, 'filled', 'red');

% animirana krvivulja
h = animatedline;
xlim([min(tocke(1, :))-1, max(tocke(1, :))+1])
ylim([min(tocke(2, :))-1, max(tocke(2, :))+1])

% animacija za vsak alfa
for j = 1:N
    % interpolacija po segmentih
    s = interpoliraj(tocke, alfa(j));

    % izrisemo krivulje po segmentih
    N_2 = size(tocke, 2);
    for segment_start = 1:3:3*(N_2-1)
        % izberemo segment
        b = s(:, segment_start:segment_start+3);

        % izvedemo deCasteljau algoritem da dobimo vse tocke
        t = linspace(0, 1, 200);
        curve = zeros(2, length(t));
        for i = 1:length(t)
            [~, vrednost, ~] = deCasteljau(b, t(i));
            curve(:, i) = vrednost; 
        end
        
        addpoints(h, curve(1, :), curve(2, :))
    end
    drawnow
    textBox = text(s(1, end) + 0.25, s(2, end), "alfa = " + num2str(alfa(j)));
    
    pause(1)
    if j ~= N
        clearpoints(h)
        drawnow
        delete(textBox)
    end
end
    
hold off