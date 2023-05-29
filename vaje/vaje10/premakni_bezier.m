function b_shifted = premakni_bezier(b,s, risi)
% Metoda translira Bezierjevo krivuljo, podano s kontrolnimi
% tockami b, za vektor s. Izrise tudi zacetno in translirano krivuljo
% ter oba kontrolna poligona. 
    b_shifted = b + s; % samo premaknemo za s, s mora bit [x; y]
    
    if risi
        plotBezier(b);
        plotBezier(b_shifted);
    end
end