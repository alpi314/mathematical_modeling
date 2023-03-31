f_levo = @(x) zeros(size(x));
f_desno = @(x) 1-x.^2;
f_zgoraj = @(x) 1-x.^2;
f_spodaj = @(x) x.^2-1;

n = 32;
a = 1;
tol = 10^-3;

% fn = @(U, t) jacobi(U, t);
% milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, fn);


fn = @(U, t) gauss_seidl(U, t);
milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, fn);
