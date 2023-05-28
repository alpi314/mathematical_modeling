A = [1; 3.07];
B = [5; 4.5];
L = [1.07 3.53 1.05];
M = [1.07 5*3.53 1.05];
W0 = [-0.5;-1.2];


% naloga 1

X = diskretna_veriznica(W0, A, B, L, M)

% naloga 2

T = tezisce(X, M)

% naloga 3
L2 = L;
M2 = M;

L2(1) = L2(1) * 0.9;
L2(end) = L2(end) * 0.9;

M2(1) = L2(1);
M2(end) = L2(end);

X2 = diskretna_veriznica(W0, A, B, L2, M2);

naloga_3 = polyarea([X2(:, 1); A(1); B(1)], [X2(:, 2); A(2); B(2)])


% naloga 4
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
f = @(l) naklon_mostu(l, W0, A, B, L, M);
right_length = fsolve(f, 1, options)

L3 = L;
L3(end) = right_length;
M3 = M;
M3(end) = right_length;
fig = figure;
risi_diskretno([A B], L3, M3);
uiwait(fig);

% naloga 5
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);
f = @(val) naklon_mostu_2(val, W0, A, B, L, M);
lengths = fsolve(f, [1; 1], options);

L3 = L;
L3(end) = lengths(2);
L3(1) = lengths(1);
M3 = M;
M3(end) = lengths(2);
M3(1) = lengths(1);
risi_diskretno([A B], L3, M3);

naloga_5 = sum(lengths)

function T = tezisce(X, M)
    y = X(2, :);
    x = X(1, :);
    
    center_y = (y(2:end) + y(1:end-1)) / 2;
    center_x = (x(2:end) + x(1:end-1)) / 2;
    weights = M ./ sum(M);
    
    T = [sum(center_x .* weights); sum(center_y .* weights)];
end


function k = naklon_mostu(right_string_len, W0, A, B, L, M)
    L(end) = right_string_len;
    M(end) = right_string_len;
    X = diskretna_veriznica(W0, A, B, L, M);
    
    index = 2;
    y_diff = X(2, index) - X(2, index +1);
    x_diff = X(1, index) - X(1, index +1);

    k = y_diff / x_diff;
end

function error = naklon_mostu_2(lengths, W0, A, B, L, M)
    L(end) = lengths(2);
    M(end) = lengths(2);
    L(1) = lengths(1);
    M(1) = lengths(1);
    X = diskretna_veriznica(W0, A, B, L, M);
    
    index = 2;
    y_diff = X(2, index) - X(2, index +1);
    x_diff = X(1, index) - X(1, index +1);

    k_other = y_diff / x_diff ;
    error = [k_other; abs(X(2, index) - 1)];
end
