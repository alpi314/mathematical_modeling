function rotiraj_bezier(b,phi)
% Metoda rotira Bezierjevo krivuljo, podano s kontrolnimi
% tockami b, za kot phi okrog prve kontrolne tocke. Izrise tudi
% zacetno in rotirano krivuljo ter oba kontrolna poligona.
    r = [cos(phi), -sin(phi); sin(phi), cos(phi)];

    plotBezier(b);
    plotBezier(b * r);

end