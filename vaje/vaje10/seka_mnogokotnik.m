function seka = seka_mnogokotnik(l,P)
% Doloci, ali premica l seka konveksno ogrinjaco tock P (=mnogokotnik) ali ne.
% Premica l je podana v obliki l = [tocka, smerni_vektor].
% Mnogokotnik P je dolocen s tabelo 2xn oglisc po stolpcih
%0=false; 1=true
    direction=l(:,2);
    point=l(:,1);
    normal=[direction(2);-direction(1)];

    scalar = (P - point)' * normal;
    scalar_sign = sign(scalar);
    if all(scalar_sign == scalar_sign(1))
        seka=false;
    else
        seka=true;
    end
end