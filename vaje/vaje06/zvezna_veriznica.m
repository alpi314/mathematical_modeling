function z = zvezna_veriznica(T1,T2,l,z_prev,tol)
% function z = zvVeriznica_iteracijskaFun(T1,T2,l,z0,tol)
% Iteracijska funkcija zvVeriznica_iteracijskaFun resi enacbo z=asinh(ro*z)
% za zvezno veriznico.
% 
% Vhod
% T1=[a;A]:    levo obesisce
% T2=[b;B]:    desno obesisce
% L:           dolzina veriznice
% z0:          zacetni priblizek
% tol:         toleranca pri ustavitvi iteracije
%
% Izhod
% z:        numericna resitev enacbe z=asinh(ro*z)
%
    p = sqrt(l^2 - (T2(2) - T1(2))^2) / (T2(1) - T1(1)); % sqrt(l^2 - (B - A)^2) / (b - a)
    while true
        z = asinh(p * z_prev);
        if norm(z - z_prev, 2) < tol
            break
        end
        z_prev = z;
    end
end