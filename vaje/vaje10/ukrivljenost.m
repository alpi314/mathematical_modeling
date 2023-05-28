function H = ukrivljenost(b, t)
    d = bezier_derivative(b, t);
    dd = bezier_second_derivative(b, t);
    det_d_dd = d(1,:) .* dd(2,:) - d(2,:) .* dd(1,:);

    H = det_d_dd ./ vecnorm(d, 2, 1).^3;
end