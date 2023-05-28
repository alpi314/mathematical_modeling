function b_shifted = premakni_bezier(b,s, risi)
% Metoda translira Bezierjevo krivuljo, podano s kontrolnimi
% tockami b, za vektor s. Izrise tudi zacetno in translirano krivuljo
% ter oba kontrolna poligona. 
    b_shifted = b + s;
    
    if risi
        plotBezier(b);
        plotBezier(b_shifted);
    end
end