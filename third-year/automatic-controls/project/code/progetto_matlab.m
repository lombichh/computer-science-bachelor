% Progetto controllo di una tavola rotante motorizzata
%
% PARAMETRI DEL SISTEMA
% k       = 1000
% beta    = 0.77
% alpha   = 25°
% J       = 549
% theta_e = 140°
%
% SPECIFICHE
% -) Errore a regime in risposta a un gradino w(t) = 2(t) e d(t) = 1.2(t)
%       inferiore a 0.05
% -) M_f >= 35 gradi
% -) S% <= 20%
% -) Ta,5 <= 0.006 s
% -) Attenuazione di almeno 35dB per d(t)
%       con [omega_d_min, omega_d_MAX] = [0, 0.7]
% -) Attenuazione di almeno 69dB per n(t)
%       con [omega_n_min, omega_n_MAX] = [2*10^5, 5*10^6]

clear all; close all; clc

% Solo per visualizzione, pulsazione minima e massima
omega_plot_min = 1e-2;
omega_plot_max = 1e7;

%% Parametri
k     = 1000;
beta  = 0.77;
alpha = deg2rad(25);
J     = 549;
x_1e  = deg2rad(140);

%% Dinamica del sistema
tau = @(theta) cos(alpha)/(1-(sin(alpha)*cos(theta))^2);

%% Coppia di equilibrio
x_2e = 0;
x_e  = [x_1e; x_2e];
u_e  = (k*x_1e)/tau(x_1e);

%% Funzione di Trasferimento
tau_ddx1e = -(cos(alpha)*(sin(alpha))^2*sin(2*x_1e))/((1-(sin(alpha))^2*(cos(x_1e))^2)^2);

A = [0 1; (1/J)*(u_e*tau_ddx1e-k) -beta/J];
B = [0; tau(x_1e)/J];
C = [1 0];
D = 0;

s  = tf('s');
GG = C*inv(s*eye(2) - A)*B + D;

%% Specifiche

% Ampiezze gradini
WW = 2;
DD = 1.2;

% Errore a regime
e_star = 0.05;

% Attenuazione disturbo sull'uscita
A_d = 35;
omega_d_min = 0;
omega_d_MAX = 0.7;

% Attenuazione disturbo di misura
A_n = 69;
omega_n_min = 2*1e5;
omega_n_MAX = 5*1e6;

% Sovraelongazione massima e tempo d'assestamento al 5%
S_star = 20;

epsilon = 0.05;
T_star = 0.006;

% Margine di fase
Mf_star_esp = 35;

%% Diagramma di Bode della funzione di trasferimento iniziale
figure(1);

% Plot Bode con margini di stabilità
margin(GG, {omega_plot_min, omega_plot_max});

grid on, zoom on;
title("Funzione di trasferimento iniziale");

%% Mappatura specifiche
% Specifica errore
A_e = 20*log10((DD+WW)/e_star);
A_ed = max(A_e, A_d); % L(0, 0.7) >= max(A_e, A_d) ~ 36.13

% Specifica sovraelongazione => Margine di fase
xi_star = abs(log(S_star/100))/sqrt(pi^2 + log(S_star/100)^2);
Mf_star = max(xi_star*100, Mf_star_esp); % Mf_star = max(45.6, 35) ~ 45.6

% Specifica tempo di assestamento => pulsazione critica
omega_c_min = 300/(Mf_star*T_star); % omega_c >= 300/(Mf*T^*) ~ 1097
omega_c_max = omega_n_min; % omega_c <= 2*10^5

% Upper e lower bounds (teoricamento + e - infinito)
mag_low = -400;
mag_up = 150;
phi_low = -270;

% Mappatura specifica su e e d
Bnd_d_x = [omega_plot_min; omega_d_MAX; omega_d_MAX; omega_plot_min]; % eps = il più piccolo numero positivo rappresentabile (con 0 non si vede)
Bnd_d_y = [A_ed; A_ed; mag_low; mag_low];

% Mappatura specifica su n
Bnd_n_x = [omega_n_min; omega_n_MAX; omega_n_MAX; omega_n_min];
Bnd_n_y = [-A_n; -A_n; mag_up; mag_up];

% Mappatura specifica su tempo di assestamento => pulsazione critica
Bnd_Ta_x = [omega_plot_min; omega_c_min; omega_c_min; omega_plot_min];
Bnd_Ta_y = [0; 0; mag_low; mag_low];

% Mappatura specifica sovraelongazione => Margine di fase
Bnd_Mf_x = [omega_c_min; omega_c_max; omega_c_max; omega_c_min];
Bnd_Mf_y = [Mf_star - 180; Mf_star - 180; phi_low; phi_low];

%% Diagramma di Bode della funzione di trasferimento iniziale con specifiche
figure(2);
hold on;

% Mappatura specifiche su ampiezza
patch(Bnd_d_x, Bnd_d_y, 'r', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);
patch(Bnd_n_x, Bnd_n_y, 'g', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);
patch(Bnd_Ta_x, Bnd_Ta_y, 'b', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Plot Bode con margini di stabilità
margin(GG, {omega_plot_min, omega_plot_max});
grid on, zoom on;
title("Funzione di trasferimento iniziale con specifiche");

% Mappatura specifiche su fase
patch(Bnd_Mf_x, Bnd_Mf_y, 'm', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Legenda colori
legend_args = ["\omega_c", "A_n", "A_{e,d}", "L(j\omega)", "M_f"];
legend(legend_args);

%% Design del regolatore statico - proporzionale senza poli nell'origine

% Valore minimo prescritto per L(0), quello per e_star già calcolato
l_o_error = 10^(A_e/20);
l_o_dist  = 10^(A_d/20);

% Guadagno minimo del regolatore ottenuto come L(0)/G(0)
G_0 = abs(evalfr(GG, 0));
G_omega_d_MAX = abs(evalfr(GG, j*omega_d_MAX));

RR_s = max(l_o_error/G_0, l_o_dist/G_omega_d_MAX); % RR_s = max(106223, 78392) ~ 106463

% Sistema esteso
GG_e = RR_s*GG;

%% Diagramma di Bode di Ge (sistema con regolatore statico)
figure(3);
hold on;

% Mappatura specifiche su ampiezza
patch(Bnd_d_x, Bnd_d_y, 'r', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);
patch(Bnd_n_x, Bnd_n_y, 'g', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);
patch(Bnd_Ta_x, Bnd_Ta_y, 'b', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Plot Bode con margini di stabilità
margin(GG_e, {omega_plot_min, omega_plot_max});
grid on; zoom on;
title("Sistema con regolatore statico");

% Mappatura specifiche su fase
patch(Bnd_Mf_x, Bnd_Mf_y, 'm', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Legenda colori
legend(legend_args);

%% Design del regolatore dinamico - rete ritardatrice
omega_c_star = 2000; % omega_c_star = 2000

mag_omega_c_star = abs(evalfr(GG_e, j*omega_c_star));
arg_omega_c_star = rad2deg(angle(evalfr(GG_e, j*omega_c_star)));

M_star = 1/mag_omega_c_star;
phi_star = Mf_star - 180 + 5 - arg_omega_c_star; % + 5 gradi per margine di sicurezza

tau = (M_star - cos(phi_star*pi/180))/(omega_c_star*sin(phi_star*pi/180));
alpha_tau = (cos(phi_star*pi/180) - 1/M_star)/(omega_c_star*sin(phi_star*pi/180));
alpha = alpha_tau/tau;

if min(tau, alpha) < 0
    fprintf('Errore: parametri rete anticipatrice negativi');
    return;
end

RR_d = (1+tau*s)/(1+alpha*tau*s);

RR = RR_s*RR_d;

LL = RR*GG; % funzione d'anello

%% Diagramma di Bode di LL (sistema con regolatore dinamico)
figure(4);
hold on;

% Specifiche su ampiezza
patch(Bnd_d_x, Bnd_d_y, 'r', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);
patch(Bnd_n_x, Bnd_n_y, 'g', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);
patch(Bnd_Ta_x, Bnd_Ta_y, 'b', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Plot Bode con margini di stabilità
margin(LL, {omega_plot_min, omega_plot_max});
grid on; zoom on;
title("Sistema con regolatore completo");

% Specifiche su fase
patch(Bnd_Mf_x, Bnd_Mf_y, 'm', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Legenda colori
legend(legend_args);

%% Test del sistema linearizzato
% Funzione di sensitività complementare
FF = LL/(1+LL);
% Funzione di sensitività
SS = 1/(1+LL);

% Test risposta al gradino
figure(5);
hold on;

T_simulation = 4*T_star;
tt = 0:1e-6:T_simulation;

WW_test = 2;
DD_test = 0.2;
omega_d_test = 0.1;
NN_test = 0.2;
omega_n_test = 2*10^5;

dd_test = DD_test*sin(omega_d_test*tt) + DD_test*sin(omega_d_test*2*tt) + DD_test*sin(omega_d_test*3*tt) + DD_test*sin(omega_d_test*4*tt);
y_d_test = lsim(SS, dd_test, tt);
nn_test = NN_test*sin(omega_n_test*tt) + NN_test*sin(omega_n_test*2*tt) + NN_test*sin(omega_n_test*3*tt) + NN_test*sin(omega_n_test*4*tt);
y_n_test = lsim(-FF, nn_test, tt);
step_test = WW_test * (tt >= T_star); % Gradino ritardato a t = 0.006 secondi
[y_w_test, ~] = lsim(FF, step_test, tt);

yy_test = y_w_test + y_d_test + y_n_test;

plot(tt, step_test, 'r');
plot(tt, yy_test, 'b');
grid on, zoom on;
title("Risposta al gradino del sistema linearizzato con disturbo e rumore");

LV = WW*evalfr(FF, 0);

% Vincolo sovraelongazione
patch([0, T_simulation, T_simulation, 0], [LV*(1+S_star/100), LV*(1+S_star/100), LV*2, LV*2], 'r', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Vincolo tempo di assestamento al 5%
patch([2*T_star, T_simulation, T_simulation, 2*T_star], [LV*(1-0.05), LV*(1-0.05), 0, 0],'g','FaceAlpha', 0.2,'EdgeAlpha', 0.5);
patch([2*T_star, T_simulation, T_simulation, 2*T_star], [LV*(1+0.05), LV*(1+0.05), LV*2, LV*2], 'g', 'FaceAlpha', 0.2,'EdgeAlpha', 0.5);

ylim([0, LV*2]);

legend('Gradino', 'Risposta al gradino', 'Vincolo sovraelongazione', 'Vincolo tempo di assestamento');

% Test solo disturbo sull'uscita
figure(6);
hold on;

tt = 0:9e-1:5e2;

dd_single_test = DD_test*sin(omega_d_test*tt) + DD_test*sin(omega_d_test*2*tt) + DD_test*sin(omega_d_test*3*tt) + DD_test*sin(omega_d_test*4*tt);
y_d_single_test = lsim(SS, dd_single_test, tt);

plot(tt, dd_single_test, 'r');
plot(tt, y_d_single_test, 'b');
grid on, zoom on;
title("Risposta al disturbo sull'uscita del sistema linearizzato");
legend('d(t)','y_d(t)')

% Test solo rumore di misura
figure(7);
hold on;

tt = 0:1e-8:3e-4;

nn_single_test = NN_test*sin(omega_n_test*tt) + NN_test*sin(omega_n_test*2*tt) + NN_test*sin(omega_n_test*3*tt) + NN_test*sin(omega_n_test*4*tt);
y_n_single_test = lsim(-FF, nn_single_test, tt);

plot(tt, nn_single_test, 'r');
plot(tt, y_n_single_test, 'b');
grid on, zoom on;
title("Risposta al rumore di misura del sistema linearizzato");
legend('n(t)','y_n(t)')

%% Test del sistema non lineare
open("progetto_simulink.slx") % Apre il progetto simulink