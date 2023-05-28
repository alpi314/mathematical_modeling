function premakni_bezier(b,s)
% Metoda translira Bezierjevo krivuljo, podano s kontrolnimi
% tockami b, za vektor s. Izrise tudi zacetno in translirano krivuljo
% ter oba kontrolna poligona. 
    plotBezier(b);
    plotBezier(b + s');
end