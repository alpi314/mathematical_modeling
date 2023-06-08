c = 94;
n = 21 + 2 * mod(c, 21);

% u''(x) = f(x)
% u(-1) = u(1) = 0
% x on [-1, 1]

X = linspace(-1, 1, n + 2); % razdelitev intervala
h = 2 / (n + 1);

f = @(x) -abs(x) + 1 + 1/100;

A = zeros(n, n + 2);
for j = 1 : n
    A(j, :) = A_row(n, h, j);
end

b = f(X(2:end-1));

u = A \ b';

u_0_idx = index(h, 0);
u(u_0_idx)


function row = A_row(n, h, j)
    row = zeros(1, n + 2);
    if j == 1
        row(1) = 11;
        row(2) = -20;
        row(3) = 6;
        row(4) = 4;
        row(5) = -1;
        row = row ./ (12 * h^2);
        return
    end
    
    if j == n
        row(n - 2) = -1;
        row(n - 1) = 4;
        row(n) = 6;
        row(n + 1) = -20;
        row(n + 2) = 11;
        row = row ./ (12 * h^2);
        return
    end

    row(j - 1) = -1;
    row(j) = 16;
    row(j + 1) = -30;
    row(j + 2) = 16;
    row(j + 3) = -1;
    row = row ./ (12 * h^2);
    return
end

function i = index(h, value)
    i = (value + 1) / h;
end