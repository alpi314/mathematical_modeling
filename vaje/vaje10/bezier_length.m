function l = bezier_length(b)
    % lenght = integral sqrt(dx(t)^2 + dy(t)^2)
    % length = integral norm(d(t))
    len_f = @(t) norm(bezier_derivative(b, t));
    l = integral(len_f, 0, 1, 'ArrayValued', true);
end