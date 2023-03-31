f = @(x) 1-x.^2
f_levo = @(x) f(x);
f_desno = @(x) f(x);
f_zgoraj = @(x) f(x);
f_spodaj = @(x) f(x);

n = 32;
a = 1;
tol = 10^-3;

fn = @(U, t) jacobi(U, t);
milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, fn);


% fn = @(U, t) gauss_seidl(U, t);
% milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, fn);
