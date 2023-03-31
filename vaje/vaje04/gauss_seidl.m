function U = gauss_seidl(U,tol)
% GAUSS_SEIDL izvaja Gauss-Seidlovo metodo direktno
% na mrezi U, ki predstavlja diskretizacijo kvadrata
% [-a,a] x [-a,a]. V vsakem koraku iteracije je vsak element
% izracunan kot povprecje njegovih stirih sosedov.
% Pri tem je U matrika z niclami v notranjosti in
% vrednostmi na robu, dolocenimi z robnimi pogoji.
% tol je toleranca, ki doloca natancnost izracunane resitve.
    n = size(U, 1);
    
    norm_2 = tol +1;
    while norm_2 > tol
        draw(U);

        norm_2 = 0;
        for i = 2:n-1
            for j = 2:n-1
                prev_u_ij = U(i, j);
                U(i, j) = (U(i-1, j) + U(i+1, j) + U(i, j-1) + U(i, j+1)) / 4;
                norm_2 = norm_2 + (prev_u_ij - U(i, j))^2;
            end
        end
    end
end