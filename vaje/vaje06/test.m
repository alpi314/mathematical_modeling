% test: diskretna verizinica
% a)
zac = [0 6;0 1];

L = [2 1 1 1 1 2];

%M = [1 0.5 1 1 0.5 1];
M = [1 0.5 5 1 0.5 1];

fig = figure;
risi_diskretno(zac,L,M);
uiwait(fig);


L = [1 2 1 1.5 1];
M = [2 4 2 1 1];
obesisceL = [1;5];
obesisceD = [4;4];
zac = [obesisceL obesisceD];
[x, y] = risi_diskretno(zac, L, M)