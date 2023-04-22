function risi(R,u)

n = length(u);
num_angle = 360;
r = linspace(0,R,n);
th = linspace(0,2*pi,num_angle);
[r2d,th2d] = ndgrid(r,th);

% x in y v polarnih koordinatah
xFun = @(r,th) r.*cos(th);
yFun = @(r,th) r.*sin(th);

% x,y,z koordinate na mrezah
x2d = xFun(r2d,th2d);
y2d = yFun(r2d,th2d);
z2d = repmat(u,1,num_angle); % funkcija neodvisna od kota --> kopija stolpcev!

% narisemo funkcijo
figure
surf(x2d,y2d,z2d)
shading interp % izbrisemo crte
% axis off;
end
