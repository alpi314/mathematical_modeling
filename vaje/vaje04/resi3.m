function x = resi3(a,b,c,y)
    n = length(y);
    
    for i = 1:(n-1)
        b(i+1) = b(i+1) - (a(i)/b(i))*c(i);
        y(i+1) = y(i+1) - (a(i)/b(i))*y(i);
    end
    
    x = zeros(n,1);
    x(n) = y(n)/b(n);
    
    for i = (n-1):-1:1
        x(i) = 1/b(i)*(y(i)-c(i)*x(i+1));
    end

end

