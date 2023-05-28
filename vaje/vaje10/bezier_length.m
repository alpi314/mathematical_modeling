function l = bezier_length(b)
    len_f = @(t) norm(bezier_derivative(b, t));
    l = integral(len_f, 0, 1, 'ArrayValued', true);
end