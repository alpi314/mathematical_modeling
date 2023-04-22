function X = diskretna_veriznica(w0,obesisceL,obesisceD,L,M)
    % function x = diskrVeriznica(w0,obesisceL,obesisceD,L,M)
    % diskrVeriznica resi problem diskretne veriznice: preko fsolve najde u in v, tako da
    % F(u,v) = [0; 0], nato veriznico narise.
    % Po knjigi Matematicno modeliranje (E. Zakrajsek).
    % vhod:
    % w0 = [u0;v0] zacetna priblizka,
    % obesisceL = [x_0;y_0],
    % obesisceD = [x_n+1;y_n+1],
    % L = dolzine palic (vektor).
    % M = mase palic (vektor).
    %
    % izhod:
    % x je 2x(n+2) tabela koordinat vozlisc.
    
    
    
    % vektor mi-jev 'mi' in vektor delnih vsot 'vsote_mi' (vsote_mi = [0,mi_1,mi_1+mi_2,...]; ukaz cumsum)
    mi = (M(1:end-1) + M(2:end)) / 2;
    vsote_mi = [0, cumsum(mi)];
    
    
    % glej (3.13) in delno vsoto, ki se pojavlja v (3.16),(3.18),(3.19)
    
    
    
    % iskanje nicle F(u,v) = [U(u,v);V(u,v)]
    
    F = @(w) F_uv(w,obesisceL,obesisceD,L,vsote_mi);
    
    % izracunamo x-e
    options = optimoptions('fsolve','Display','none');
    W = fsolve(F, w0, options);
    u = W(1);
    v = W(2);

    by_f_solve = [u v]
    
    % glej (3.16) ter (3.18), (3.19) ter (3.8) in (3.9)
    % NEWTNOVA METODA
    JF = @(W) jacobian(W,L,vsote_mi);
    W = newton(F, JF, w0, 1e-10);
    u=W(1);
    v=W(2);

    by_newton = [u v]

    %
    xi = L./sqrt(1+(v-u*vsote_mi).^2);
    eta = xi.*(v-u*vsote_mi);
    
    % izracun koordinat krajisc
    X=[obesisceL(1)+cumsum(xi);obesisceL(2)+cumsum(eta)];
    X=[obesisceL X];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function z = F_uv(w,obesisceL,obesisceD,L,vsote_mi)
    % function z = F_uv(w,obesisceL,obesisceD,L,vsote_mi)
    % F_uv vrne vrednost namenske vektorske funkcije za diskretno veriznico,
    % z = F(w) = [U(u,v);V(u,v)], z \in R^2, w=(u,v) \in R^2
    % Po knjigi Matematicno modeliranje (E. Zakrajsek).
    %
    % vhodni podatki:
    % w=[u;v], kjer sta u in v parametra funkcije F(w) = F(u,v),
    % obesisceL = levo obesisce [x_0;y_0],
    % obesisceD = desno obesisce [x_n+1;y_n+1],
    % L = dolzine palic (vektor),
    % vsote_mi = [0,mi_1,mi_1+mi_2,...] je vektor delnih vsot mi-jev.
    %
    % izhodni podatki:
    % z = F(w) = [U(u,v);V(u,v)] (glej (3.22) in (3.23)).
    
    u = w(1);
    v = w(2);
    
    % zapisemo vektor xi=[xi_1,...,xi_n+1]
    x_diff = obesisceD(1) - obesisceL(1);
    y_diff = obesisceD(2) - obesisceL(2);
    
    % zapisemo vektor eta=[eta_1,...,eta_n+1] 
    ksi = L ./ sqrt(1 + (v - u*vsote_mi).^2);
    
    eta = ksi .* (v - u*vsote_mi);
    
    
    % vrnemo vektor z = [U(u,v);V(u,v)]
    z = [sum(ksi) - x_diff; sum(eta) - y_diff];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function JF = jacobian(W,L,vsote_mi)
    u = W(1);
    v = W(2);
    
    w = v-u*vsote_mi; % formula (32)
    der = (1+w.^2).^(-3/2);
    
    JF = [sum(L.*w.*vsote_mi.*der), sum(-L.*w.*der);
        sum(-L.*vsote_mi.*der), sum(L.*der)];

end