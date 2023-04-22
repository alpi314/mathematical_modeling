function y = newton(F,JF,x0,delta)
% NEWTON izvaja Newtonovo metodo za resevanje sistema
% nelinearnih enacb, podanega z F in Jacobianom JF.
% Pri  tem je x0 zacetni priblizek.
% Iteracija se konca, ko se zadnja priblizka razlikujeta
% za manj kot delta. 

napaka = Inf;

while napaka > delta
    
    dx = -JF(x0)\F(x0);
    xn = x0 + dx;
    napaka = max(abs(xn-x0));
    x0 = xn;
    
end

y=x0;

end