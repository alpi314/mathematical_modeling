R = 1;
n = 20;

f = @(x) vector_function(x); % tako moramo definirati konstatno funkcijo, da deluje z vektorji
[r, u] = povesi(f, R, n);

ddu_r10 = ddu_value(r, u, 10)


% plasc
plasc = 0;
for i=1:length(u)-1
    plasc = plasc + sqrt((u(i+1)-u(i))^2+(r(i+1)-r(i))^2)*2*pi*((r(i+1)+r(i))/2);
end
plasc

% tocna resitev
solution_f = @(r) 0.25 .* (r.^2 - 1);
minimal_n(f, R, solution_f)

function y = vector_function(x)
    y = ones(size(x));
end

function v = ddu_value(r, u, i)
    % pazimo, v navodilu so indeksi od 0 do n + 1, vendar matlab zacne z
    % indeksom 1, zato v indeksih vektorjev pristejemo 1 !
    h = r(i + 1) / i;
    v = (u(i + 2) - 2 * u(i + 1) + u(i)) / (h^2);
end

function e = error_function(f, R, n, solution_f)
    [r, u] = povesi(f, R, n);
    solution = solution_f(r');
    e = abs(u - solution);
end

function n = minimal_n(f, R, solution_f)
    for n = 100:10000
        e = error_function(f, R, n, solution_f);
        if all(e <= 1e-6)
            break
        end
    end
end

