function zakotali_kroglico(T1,T2,st_tock);
    T2 = T2 - T1;

    [k, theta] = isci_theta_k(T2(1), T2(2))

    points = linspace(0, theta, st_tock + 1);

    x = @(p) ((k^2/2) .* (p - sin(p)) + T1(1));
    y = @(p) ((-k^2/2) .* (1 - cos(p)) + T1(2));
   
    plot(x(points), y(points));
    axis equal;
    hold on;

    g = 9.81;
    time = @(s, e) (k * (e - s) / sqrt(2*g));
    for i = 1:st_tock
        pt = points(i);
        ball = plot(x(pt), y(pt), 'ro');

        wait_time = time(points(i), points(i + 1));
        pause(wait_time);

        delete(ball);
    end
end