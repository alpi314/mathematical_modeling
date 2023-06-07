function [r,u]=povesi(f,R,n)
    % u'' + 1/r u' = f(r)
    % R je radij krozne zanke
    % n je stevilo notranjih delilnih tock
    %
    % r je delitev v r-smeri
    % u je vektor priblizkov za resitev
    
    r = linspace(0,R,n+1); % n+1 delilnih tock
    h = R/n;
    
    rhs = h.^2 * f(r(1:end-1)); % zadnjega ne vzamemo, saj je na robu opna pripeta
    
    a = 1 - h/2 * 1./r(2:n); % poddiagonala
    b = -2 * ones(n,1); % diagonala
    c = 1 + h/2 * 1./r(2:n-1); % naddiagonala
    c = [2 c];
    
    
    u = resi3(a,b,c,rhs);
    u = [u;0]; % zaradi pogoja u(R) = 0, dodamo niclo
end

