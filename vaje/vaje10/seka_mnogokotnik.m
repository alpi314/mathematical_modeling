function seka = seka_mnogokotnik(l,P)
% Doloci, ali premica l seka konveksno ogrinjaco tock P (=mnogokotnik) ali ne.
% Premica l je podana v obliki l = [tocka, smerni_vektor].
% Mnogokotnik P je dolocen s tabelo 2xn oglisc po stolpcih
%0=false; 1=true
    direction=l(:,2);
    point=l(:,1);
    normal=[direction(2);-direction(1)];

    % ker mnozimo V1 = (P - point), V2 = normal v tem vrstnem redu
    % si predstavljamo x-os vzdolž V1
    % norme nas niti ne zanimajo važen je zgolj kot
    % če bo kakšen predznak drugačen pomeni da bo vektor premice šel med
    % dvema točkama (na sliki je to hitro intuitivno)

    scalar = (P - point)' * normal;
    scalar_sign = sign(scalar);
    if all(scalar_sign == scalar_sign(1))
        seka=false; % vsi predznaki so enaki, torej ne seka
    else
        seka=true; % obstaja par točk na drugi strani direciton vektorja
    end
end