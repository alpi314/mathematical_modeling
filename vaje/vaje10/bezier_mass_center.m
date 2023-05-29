function c = bezier_mass_center(b)
    % mass_x = 1/L * integral x(t) * |dx(t)| dt
    % mass_y = 1/L * integral y(t) * |dy(t)| dt

    l = bezier_length(b);
    magnitude = @(t) norm(bezier_derivative(b, t));
    X = @(t) x_value(b, t);
    Y = @(t) y_value(b, t);

    mass_x = @(t) (1/l) * X(t) * magnitude(t);
    mass_y = @(t) (1/l) * Y(t) * magnitude(t);

    c_x = integral(mass_x, 0, 1, "ArrayValued", true);
    c_y = integral(mass_y, 0, 1, "ArrayValued", true);
    
    c = [c_x; c_y];
end

function x = x_value(b, t)
    [~, v, ~] = deCasteljau(b, t);
    x = v(1);
end

function y = y_value(b, t)
    [~, v, ~] = deCasteljau(b, t);
    y = v(2);
end