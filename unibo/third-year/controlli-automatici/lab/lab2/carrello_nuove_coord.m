clear;

% intervallo temporale
tt = 0:0.1:10;

% stato iniziale
x0 = [0, 1];

% input
per = 0:0.1:5; % periodo 5 secondi
usin = @(t) [sin(t)]; % input primi 5 secondi
uu = [usin(per), zeros(1, length(per) - 1)]; % input

% costanti
cost = 1;
mass = 0.5;

% matrici con coordinate nuove
A = [0, 1; -cost/mass, 0];
B = [0; 1/mass];
C = [1, 0];
D = 0;

% modello con coordinate originali
modello = ss(A, B, C, D);
% sim con coordinate originali
[y, t, x] = lsim(modello, uu, tt, x0);

figure
plot(t, x)
figure
plot(t, y)

% matrici con coordinate nuove
[T_inv, A_hat] = jordan(A);
B_hat = inv(T_inv) * B;
C_hat = C * T_inv;
D_hat = D;

% modello con coordinate nuove
modello_hat = ss(A_hat, B_hat, C_hat, D_hat);
% sim con coordinate nuove
[y_hat, t_hat, x_hat] = lsim(modello_hat, uu, tt, x0);

figure
plot(t_hat, x_hat)
figure
plot(t_hat, y_hat)