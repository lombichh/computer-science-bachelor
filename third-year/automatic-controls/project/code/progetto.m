% Progetto controllo di una tavola rotante motorizzata
%
% PARAMETRI DEL SISTEMA
%
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

% solo per visualizzione, pulsazione minima e massima
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
tau_ddx1e = (cos(alpha)*(sin(alpha))^2*sin(2*x_1e))/((1-(sin(alpha))^2*(cos(x_1e))^2)^2);

A = [0 1; (1/J)*(-u_e*tau_ddx1e-k) -beta/J];
B = [0; tau(x_1e)/J];
C = [1 0];
D = 0;

s  = tf('s');
GG = C*inv(s*eye(2) - A)*B + D;

%% Specifiche

% ampiezze gradini
WW = 2;
DD = 1.2;

% errore a regime
e_star = 0.05;

% attenuazione disturbo sull'uscita
A_d = 35;
omega_d_min = 0;
omega_d_MAX = 0.7;

% attenuazione disturbo di misura
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
% Specifica sovraelongazione => Margine di fase
xi_star = abs(log(S_star/100))/sqrt(pi^2 + log(S_star/100)^2);
Mf_star = max(xi_star*100, Mf_star_esp); % Mf_star = max(45.6, 35) ~ 45.6

% Specifica tempo di assestamento => pulsazione critica
omega_c_min = 300/(Mf_star*T_star); % omega_c >= 300/(Mf*T^*) ~ 1097
omega_c_max = omega_n_min; % omega_c <= 2*10^5

% upper e lower bounds (teoricamento + e - infinito)
mag_low = -400;
mag_up = 150;
phi_low = -270;

% Mappatura specifica su d
Bnd_d_x = [eps; omega_d_MAX; omega_d_MAX; eps]; % eps = il più piccolo numero positivo rappresentabile (con 0 non si vede)
Bnd_d_y = [A_d; A_d; mag_low; mag_low];

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

%% Design del regolatore statico - proporzionale senza poli nell'origine

% valore minimo prescritto per L(0)
mu_s_error = (DD+WW)/e_star;
mu_s_dist  = 10^(A_d/20);

% guadagno minimo del regolatore ottenuto come L(0)/G(0)
G_0 = abs(evalfr(GG, 0));
G_omega_d_MAX = abs(evalfr(GG, j*omega_d_MAX));

RR_s = max(mu_s_error/G_0, mu_s_dist/G_omega_d_MAX); % RR_s = max(106223, 78392) ~ 106463

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
legend_args = ["\omega_c", "A_n", "A_d", "G(j\omega)", "M_f"];
legend(legend_args);

%% Design del regolatore dinamico - rete ritardatrice
omega_c_star = 2000; % omega_c_star = 2000

mag_omega_c_star = abs(evalfr(GG_e, j*omega_c_star));
arg_omega_c_star = rad2deg(angle(evalfr(GG_e, j*omega_c_star)));

M_star = 1/mag_omega_c_star;
phi_star = Mf_star - 180 - arg_omega_c_star;

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
title("Funzione d'anello con regolatore completo");

% Specifiche su fase
patch(Bnd_Mf_x, Bnd_Mf_y, 'm', 'FaceAlpha', 0.2, 'EdgeAlpha', 0);

% Legenda colori
legend(legend_args);