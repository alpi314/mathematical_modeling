A=[0.10, 1.00];
B=[3.50, 0.01];
l = 5.54;

[T_min, w, C, D] = risi_zvezno(A, B, l, 1e-16, 1);

dw_dx = @(x) sinh((x - D) / C);
dw_dx(3)

% mass_x = 1/L * integral x(t) * |dx(t)| dt
% mass_y = 1/L * integral y(t) * |dy(t)| dt
magnitude = @(x) norm([1; dw_dx(x)]);
X = @(x) x;
Y = @(x) w(x);

mass_x = @(x) (1/l) * X(x) * magnitude(x);
mass_y = @(x) (1/l) * Y(x) * magnitude(x);

c_x = integral(mass_x, A(1), B(1), "ArrayValued", true)
c_y = integral(mass_y, A(1), B(1), "ArrayValued", true)

% ---------
criteria_func = @(shift) monotone(A, B, l, shift);
min_shift = fminbnd(criteria_func, 0, 8)

A(2) = A(2) + min_shift;
risi_zvezno(A, B, l, 1e-16, 1);


% nehomogena
hold off
[T_min, w, C, D] = risi_zvezno(A, B, l, 1e-16, 1);

risi_diskretno = 



function E = monotone(A, B, l, shift)
    A(2) = A(2) + shift;  
    [T_min, w, C, D] = risi_zvezno(A, B, l, 1e-16, 0);
    
    E = abs(T_min(2) - B(2));
end