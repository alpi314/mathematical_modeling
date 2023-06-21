% podane imamo točje p(j) j = 0...N
% podane imamo u(j) delilne točke j = 0...N
% veljati mora s(u(j)) = p(j) j = 0...N
% podane imamo tudi tangente s'(u(j)) = v(j) j = 0...N
% 
% C^1
% imamo kontrolne točke b(3*j + k) j = 0...N k = 0, 1, 2, 3
% robne točke: b(3*j) = p(j) in b(3*j + 3) = p(j + 1)
% notrajne točke: 
% b(3*j + 1) = b(3*j) + delta(j) * v(j) / 3
% j = 0...N-1
% b(3*j -1) = b(3*j) - delta(j-1) * v(j) / 3 
% j = 1...N
% 
% delta(j) = u(j + 1) - u(j) ... razlika med delilinimi točkami
%
% ponavadi ne poznamo u(j)
% predpostavimo da imamo d(j) j = 0...N
% d(j) je normalizirana smer tangente v podanih točkah p(j)
% ker sedaj nimamo delta(j) jo ocenimo z alfa(j) in beta(j)
%
% notrajne točke: 
% b(3*j + 1) = b(3*j) + alfa(j) * d(j)
% j = 0...N-1
% b(3*j -1) = b(3*j) - beta(j) * d(j)
% j = 1...N
%
% v praksi se izkaze da je alfa(j) = beta(j) = 0.4 * norm(deltaP(j))
% dobra ocena
% IMPLEMENTACIJA: interpolate_c1(


points = [0 5 6, 12; 5 8 6 -1];
alpha = 0.8;

b = interpolate(points, alpha)
hold on
scatter(points(1, :), points(2, :), 20, "red", "filled");
draw_bezier(b, 100);
hold off