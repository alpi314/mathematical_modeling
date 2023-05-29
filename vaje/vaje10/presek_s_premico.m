function intersections = presek_s_premico(b,l,tol)
% Poisce presek ravninske Bezierjeve krivulje 
% s premico l podano s tocko P in smernim vektorjem s.
% Presek se izracuna preko kontrolnega poligona krivulje b, subdivizije sub_demo in metode seka_mnogokotnik.
% 
% Tp je tabela tock presecisc (ce ni presecisca, vrne prazno matriko)
% b je tabela 2x(n+1) kontrolnih tock po stolpcih
% l = [P,s]
% tol je natancnost, do katere isce presecisce.

    % ideja je grajenje subdivizij krivulj (kot bisekcija)
    % preveimo ce premica seka konveksno ogrinjaco podpornih tocko, če ne
    % potem gotovo ne seka krivulje
    % če pa seka potem delimo naprej dokler ne dossežemo dovolj majhnega
    % lika

    if seka_mnogokotnik(l,b)
        if premer(b) < tol
            intersections = mean(b,2);
        else
            [left, right] = sub_demo(b,1/2,0);

            left_intersections = presek_s_premico(left, l, tol);
            right_intersections = presek_s_premico(right, l, tol);

            intersections = [left_intersections, right_intersections];
        end
    else
        intersections = [];
    end
end

function max_distance = premer(coord_pairs)
    % Calculate the distance between each pair
    distances = sqrt(diff(coord_pairs(1,:)).^2 + diff(coord_pairs(2,:)).^2);
    
    % Find the maximum distance
    max_distance = max(distances);
end