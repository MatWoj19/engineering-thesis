%% clean up the workspace, close figures and clear command window
clear all
close all
clc

%% load experimental data from .mat file
data = load('obiekt_odp_skokowa_30_wektory.mat');
y_exp = data.Y;

%% model parameters
k = 0.777;  % system gain
T = 168;   % time constant
tau = 9;  % time delay

Tp = 1;  % sampling time

%% continuous-time transfer function
s = tf('s');
Go = k*exp(-tau*s)/(T*s+1);  % plant transfer function

Gc = (1-exp(-s*Tp)*Go)/(s+(1-exp(-s*Tp))*Go);  % overall transfer function

%% Nyquist & Bode diagrams
figure;
nyquist(Gc);
title('Charakterystyka Nyquista', 'FontSize', 16);
xlabel('P(\omega)', 'FontSize', 16);
ylabel('Q(\omega)', 'FontSize', 16);
ax = gca;
ax.FontSize = 16;

figure;
bode(Gc);

%% discrete-time transfer function
God = c2d(Go, Tp, 'zoh');

t = 0:1:1199;  % time vector
u_const = 30;  % upper right heater power [%]
u = u_const*ones(size(t));  % input signal

%% simulate discrete model response
y_model_discrete = lsim(God, u, t);
y_model_discrete = y_model_discrete + ones(size(y_model_discrete))*y_exp(1);  % offset the response to match the initial experimental condition

%% plotting results
figure;
hold on
plot(t, y_exp, 'b');  % plot experimental data
plot(t, y_model_discrete, '--r');  % plot discrete model response
legend('obiekt', 'model', 'Location', 'southeast');
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
title('Odpowiedź skokowa obiektu i modelu (wersja dyskretna)');
grid minor;
hold off
