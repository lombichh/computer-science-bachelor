close all; clear all; clc

g = 9.81;
l = 0.6;
b = 0.25;
M = 0.5;

u = @(t) 2;

f_tilde = @(t, x) [x(2);
    -(g/l)*sin(x(1)) - (b/(M*l^2))*x(2) + (1/M*l^2) * u(t)];

int = [0 10];

x0 = [deg2rad(30); 0];

[time, traj] = ode45(f_tilde, int, x0);

figure
plot(time, traj);
title('Traiettoria di stato del pendolo')
xlim(int)
xlabel('tempo [s]')
ylabel('stato')
legend('angolo', 'velocità angolare')
grid on; zoom on; box on;