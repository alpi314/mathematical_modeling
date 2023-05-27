function [t, h, v] = padalec_ode23s(start_condtion, end_time, n, parametri, naloga)
    
    d_Y = @(t, Y) differencial(t, Y, parametri, naloga, start_condtion);
    interval = linspace(0,end_time,n);
    [t, res] = ode23s(d_Y, interval, start_condtion);

    % visine in hitrosti padalca
    h = res(:,1);
    v = res(:,2);
end

function d_Y = differencial(t, Y, parametri, naloga, start_condtion)
    m = parametri(1);
    c = parametri(2);
    S = parametri(3);
    r = parametri(4);
    g0 = parametri(5);
    
    
    switch naloga
        case 1
            ro = @(h) 1.225;
            g = @(h) g0;
        case 3
            ro = @(h) 1.225;
            g = @(h) g0 * (r / (r + h))^2;
        case 4
            A = aproksimacija();
            ro = @(y)  A(1) + A(2)*((y-40000)/40000).^(2) + A(3)*((y-40000)/40000).^(4);
            g = @(y) 9.81*((6371*1000)/(6371*1000+y))^2;
        case 5
            A = aproksimacija();
            ro = @(y)  A(1) + A(2)*((y-40000)/40000).^(2) + A(3)*((y-40000)/40000).^(4);
     
            g = @(y) 9.81*((6371*1000)/(6371*1000+y))^2 - pospesek_vrvices(y, m);   
    end
    
    dd_y = @(t, Y) -g(Y(1))-(1/2*ro(Y(1))*c*S)/m*abs(Y(2)).*Y(2);
    d_Y = [Y(2); dd_y(t, Y)];
end

function f = pospesek_vrvices(y, m)
    k = 47;
    rope_length = 50;

    if y > rope_length
        f = 0;
    else
        f = k*(rope_length-y)/m;
    end
end

function args = aproksimacija()

    h = [0 2000 4000 6000 8000 10000 15000 20000 25000 30000 40000]';
    y = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996]';
    
    f1 = @(h) ones(size(h));
    f2 = @(h) ((h - 40000)/40000).^2;
    f3 = @(h) ((h - 40000)/40000).^4;
    
    A = [f1(h) f2(h) f3(h)];
    args = A\y;

end
