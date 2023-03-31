function draw(U)
    n = size(U, 1);

    V = 1:n;
    surf(V, V, U);
    pause(0.05);
end