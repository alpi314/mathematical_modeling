function risi(zac,L,M)
% RISI_VER_UV narise sliko veriznice
%
% Vhodni parametri:
% zac = [x_0 x_n+1;y_0 y_n+1], kjer sta (x_0,y_0) in
% (x_n+1, y_n+1) obesisci. 
% L je vrstica, ki doloca dolzine palic.
% M je vrstica, ki doloca mase palic.

W0 = [-0.5;-1.2];
X = diskretna_veriznica(W0, zac(:, 1), zac(:, 2), L, M);

hold on
plot(X(1,:),X(2,:),'LineWidth',3)
plot(X(1,:),X(2,:),'o','MarkerSize', 5,'LineWidth', 5);
hold off

grid on
axis([zac(1,1) zac(1,2) ceil(min(X(2,:))-1) max(zac(2,1),zac(2,2))])
end