clear;

cost = 1;
mass = 0.5;

% matrici
A = [0, 1; -cost/mass, 0];
B = [0; 1/mass];
C = [1, 0];
D = 0;

% modello
modello = ss(A, B, C, D);

tt = 0:0.1:10; % intervallo temporale

x0 = [0, 1]; % stato iniziale

% input
per = 0:0.1:5; % periodo 5 secondi
usin = @(t) [sin(t)]; % input primi 5 secondi
uu = [usin(per), zeros(1, length(per) - 1)]; % input

[y, t, x] = lsim(modello, uu, tt, x0); % sim

figure
plot(t, x)