function milnica(a,n,f_spodaj,f_zgoraj,f_levo,f_desno,tol,metoda)
% MILNICA izracuna obliko milnice na kvadratu
% [-a,a] x [-a,a], kjer so podane robne vrednosti
% s funkcijami f_i. Pri tem je:
% n+2 je stevilo delilnih tock na eni koordinatni osi
% f_i so stiri funkcije ene spremenljivke, ki dolocajo
% vrednosti na robu.
% tol je toleranca pri iterativni metodi
% metoda je stikalo, ki doloca iterativno metodo:
%’Jacobi’ = Jacobijevo iteracijo
%’Gauss-Seidel’ = Gauss-Seidelovo iteracijo

    % nicelna matrika in korak, ki gre cez celi interval
    U = zeros(n+2, n+2);
    
    interval = linspace(-a, a, n+2);

    for i = 1:n+2
        v = interval(i);

        U(i, 1) = f_levo(v);
        U(i, end) = f_desno(v);
         U(1, i) = f_zgoraj(v);
        U(end, i) = f_spodaj(v);
    end
    
    U = metoda(U, tol);
end