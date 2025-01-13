clear;

n = 2;

k = 1;
M = 0.5;

% matrici
A = [0, 1; -k/M, 0];
B = [0; 1/M];
C = [1, 0];
D = 0;

% FdT
s = tf('s');
G = C * inv(s*eye(n)-A) * B + D;

% poli e zeri
p = pole(G);
z = zero(G);

% show poli e zeri
figure;
pzmap(G);
grid on

% show risposta a gradino nell'intervallo 0:10
figure;
TT = 0:0.1:10;
step(G, TT);