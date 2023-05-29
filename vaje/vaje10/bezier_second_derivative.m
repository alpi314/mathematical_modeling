function v = bezier_second_derivative(b, t)
    % according to https://pages.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/bezier-der.html
    binomial = @(n, i) factorial(n) / (factorial(i) * factorial(n - i)); % binomial coefficient
    B = @(n, i, t) binomial(n, i) * t.^i .* (1 - t).^(n - i);

    v = 0;
    n = size(b, 2) - 1;
    for i = 0 : n - 2
          v = v + B(n - 2, i, t) * (b(:, i + 3) - 2 *  b(:, i + 2) + b(:, i + 1));
    end
    v = v * n * (n - 1);
end