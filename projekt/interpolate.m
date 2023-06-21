function s = interpolate(p, alpha, t_l, t_r)
    delta_p = diff(p, 1, 2);

    u = division_points(delta_p, alpha);
    delta_u = diff(u);
    
    [A, B] = c2_system(delta_p, delta_u);
    v = A \ B;

    if (nargin == 4)
        v0 = t_l;
        vN = t_r;
    elseif (nargin == 2)
        v0 = 2 .* (delta_p(:, 1) - v(:, 1)) ./ delta_u(1);
        vN = 2 .* (delta_p(:, end) - v(:, end)) ./ delta_u(end);
    else
        error("Invalid number of arguments");
    end
    v = [v0 v' vN];
    
    N = size(p, 2);
    s = zeros(2, 3*N-2);
    for j = 1:N-1
        l_idx = 3*(j-1);
        s(:, l_idx+1) = p(:, j); % stične točke
        s(:, l_idx+2) = p(:, j) + delta_u(j) .* v(:, j) ./ 3; % prva notranja
        s(:, l_idx+3) = p(:, j+1) - delta_u(j) .* v(:, j+1) ./ 3; % druga notranja 
    end
    s(:, end) = p(:, end); % koncna sticna tock
end

function u = division_points(delta_p, alpha)
    delta_p_alpha = vecnorm(delta_p, 2).^alpha;

    N = size(delta_p, 2) + 1;
    u = zeros(1, N);
    for j = 2:N
        u(j) = u(j - 1) + delta_p_alpha(j - 1);
    end
    u = u / u(end);
end

function [A, B] = c2_system(delta_p, delta_u)
    N = size(delta_p, 2) + 1; % stevilo tock (N-2 stevilo notranjih tock)
    A = zeros(N - 2, N - 2);
    B = zeros(N - 2, 2);
    for j = 1:N-2
        if j ~= 1
            A(j, j-1) = delta_u(j+1)/(delta_u(j)+delta_u(j+1));
        end
        A(j, j) = 2;
        if j ~= N-2
            A(j, j+1) = delta_u(j)/(delta_u(j)+delta_u(j+1));
        end

        B(j, :) = 3 .* (delta_u(j+1) .* delta_p(:, j) ./ delta_u(j) + delta_u(j) .* delta_p(:, j+1) ./ delta_u(j+1)) ./ (delta_u(j) + delta_u(j+1));
    end
end