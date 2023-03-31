function U = jacobi(U,tol)
% JACOBI izvaja Jacobijevo metodo na mrezi U, ki predstavlja
% diskretizacijo kvadrata [-a,a] x [-a,a]. Na vsakem koraku
% iteracije je vsak element izracunan kot povprecje njegovih
% stirih sosedov. Pri tem je U matrika z niclami v notranjosti
% in vrednostmi na robu, dolocenimi z robnimi pogoji.
% Pri Jacobijevi metodi potrebujemo pomozno mrezo.
% tol je toleranca, ki doloca natancnost izracunane resitve.
    draw(U);
    
    prev = U;
    U([2:end-1], [2:end-1]) = (U([1:end-2], [2:end-1]) + U([3:end], [2:end-1]) + U([2:end-1], [1:end-2]) + U([2:end-1], [3:end])) / 4;
    if (norm(U - prev, 2) > tol)        
        U = jacobi(U, tol);
    end
end