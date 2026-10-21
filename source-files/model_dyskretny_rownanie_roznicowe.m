%% clean up the workspace, close figures and clear command window
clear all
close all
clc

%% model parameters
k = 0.777;  % system gain
T = 120;   % time constant
tau = 16;  % time delay

Tp = 1;  % sampling time

%% continuous-time transfer function
s = tf('s');
Go = k*exp(-tau*s)/(T*s+1);

%% discrete-time transfer function
God = c2d(Go, Tp, 'zoh');

%% simulation (TODO)
Tsim = 500;
t = 0:1:Tsim+16;
y = zeros(1, Tsim+17);
u = ones(1, Tsim+17);

for i = 1:1:Tsim

    y(i+17) = 0.9917*y(i+16) + 0.006448*u(i);

end
