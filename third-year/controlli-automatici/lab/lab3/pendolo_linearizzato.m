close all; clear all; clc;

% parametri fisici del sistema
mm = 0.5;   % kg
ll = 0.6; % metri
gg = 9.81;  % m/s^2
bb = 0.25;  % coefficiente d'attrito (b)

% condizione iniziale del pendolo
theta_init     = 1/6*pi; % 
theta_dot_init = 0.0; % 

% vettore delle condizioni iniziali
x0 = [theta_init; theta_dot_init];

% intervallo di tempo
interv = 0:0.1:15; % da 0 a 15 secondi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Definire coppia di equilibrio x_e u_e %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_e = [pi/3; 0];
u_e = mm*gg*ll*sin(x_e(1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Definire matrici  A, B del sistema linearizzato intorno al punto di equilibrio %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [0, 1; -gg/ll*cos(x_e(1)), -bb/(mm*ll^2)];
B = [0; 1/(mm*ll^2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Progettare matrice K (scegliendo a piacere gli autovalori di A+BK) %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = [-1, -2];
K = place(A, B, p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Dichiarare funzione anonima per il controllore e includerla in dyn %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

uu = @(x) u_e - K * (x - x_e);

dyn = @(t,x) [x(2);-gg/ll*sin(x(1)) - bb*x(2)/(mm*ll^2) + uu(x)/(mm*ll^2)];

% risolviamo l'equazione differenziale
[time, traj] = ode45(dyn, interv, x0);

%% Animation

xx=traj';
pivotPoint = [2,2];
radius = .1; %of the bob

position = pivotPoint - (ll*...
                     [-sin(xx(1,1)) cos(xx(1,1))]);
 
rectHandle = rectangle('Position',[(position - radius/2) radius radius],...
                          'Curvature',[1,1],'FaceColor','r'); %Pendulum bob

lineHandle = line([pivotPoint(1) position(1)],...
    [pivotPoint(2) position(2)], 'LineWidth',2); %pendulum rod
axis equal
%Run simulation, all calculations are performed in cylindrical coordinates
for tt=1:length(interv)
    
    grid on
 
    position = pivotPoint - (ll*...
                     [-sin(xx(1,tt)) cos(xx(1,tt))]);
 
    %Update figure with new position info
    set(rectHandle,'Position',[(position - radius/2) radius radius]);
    set(lineHandle,'XData',[pivotPoint(1) position(1)],'YData',...
        [pivotPoint(2) position(2)]);
    axesHandle = gca;
xlim(axesHandle, [(pivotPoint(1) - ll - radius ) ...
                            (pivotPoint(1) + ll + radius )] );
ylim(axesHandle, [(pivotPoint(2) - ll - radius) ...
                            (pivotPoint(2) +ll + radius)] );
 drawnow; %Forces MATLAB to render the pendulum
 if tt==1
     pause(0.5)
 else
    pause(0.05) 
 end
end