function b_rot = rotiraj_bezier(b,phi, shift, risi)
% Metoda rotira Bezierjevo krivuljo, podano s kontrolnimi
% tockami b, za kot phi okrog prve kontrolne tocke. Izrise tudi
% zacetno in rotirano krivuljo ter oba kontrolna poligona.
    r = [cos(phi), -sin(phi); sin(phi), cos(phi)];

    b_rot = r * (b - shift);
    b_rot = b_rot + shift;
    
    if risi == 1
        plotBezier(b);
        plotBezier(b_rot);
    end
end