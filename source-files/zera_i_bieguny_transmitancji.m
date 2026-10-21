%% clean up the workspace, close figures and clear command window
clear all
close all
clc

s = tf('s');
G = (-209.79*s^3+4.662*s^2+8.97435*s+0.0777)/(1302.21*s^3+349.662*s^2+8.97435*s+0.0777);

figure;
pzmap(G);
title('Bieguny i zera transmitancji badanego układu','FontSize',16);
xlabel('Re(s)','FontSize',16);
ylabel('Im(s)','FontSize',16);
ax = gca;
ax.FontSize = 16;
