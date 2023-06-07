function risi_brah(T1,T2,st_tock);
%RISI_BRAH narise brahistohrono
%RISI_BRAH(T1,T2,st_tock)
%T1=[x_1;y1]; T_2=[x_2;y_2]
%st_tock je stevilo razdelitev intervala [x_1,x_2]
    T2 = T2 - T1;

    [k, theta] = isci_theta_k(T2(1), T2(2));

    points = linspace(0, theta, st_tock);

    x = @(p) ((k^2/2) .* (p - sin(p)) + T1(1));
    y = @(p) ((-k^2/2) .* (1 - cos(p)) + T1(2));
   
    plot(x(points), y(points));
    axis equal;
    
    g = 9.81;
    time = @(t) (k * t) / sqrt(2*g);
    time_until_finish = time(theta);
    
    % razlaga:
    % formula za čas je da integriramo po x (med T1, T2) funkcijo
    % sqrt(1 + y'^2) / sqrt(2*g*(-y))
    % ker imamo premico je y' = koeficient premice
    % ker je ena točka T1 po predpostavki (0, 0) je n od premice enak 0, k
    % pa je enak T2(2) / T2(1)
    coeff = T2(2) / T2(1);
    integral_function = @(x) sqrt((1 + coeff.^2) ./ (2 .* g .* (-coeff .* x)));
    time_on_line = integral(integral_function, 0, T2(1));
end