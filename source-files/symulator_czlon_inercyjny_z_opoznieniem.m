%% clean up the workspace, close figures and clear command window
clear all
close all
clc

%% initial parameters
setpoint = 40;  % desired temperature [°C]
FRU = 30;       % upper right fan power [%]
Tp = 1;         % sampling time [s]
SSE_window = 1200;
MAE_window = 1200;
TI_window = 1200;

%% initial values
e1 = 0;  % error in t time
e2 = 0;  % error in t+1 time
integral_e = 0;

%% PID parameters
Kp = 6;    % proportional gain
Ti = 120;  % integral time constant
Td = 5;    % derivative time constant

% Kp = 10;    % proportional gain
% Ti = 30;  % integral time constant
% Td = 8;    % derivative time constant

% Kp = 4;    % proportional gain
% Ti = 130;  % integral time constant
% Td = 3;    % derivative time constant

%% setpoint signal  
a = 35*ones(1,60*5);
b = 40*ones(1,60*5);
c = 30*ones(1,60*5);
d = 45*ones(1,60*5);
a2 = 35*ones(1,60*10);
b2 = 40*ones(1,60*10);
c2 = 30*ones(1,60*10);
d2 = 45*ones(1,60*10);
a3 = 35*ones(1,60*15);
b3 = 40*ones(1,60*15);
c3 = 30*ones(1,60*15);
d3 = 45*ones(1,60*15);
setpoint = [a b c d b c d a b d a c a2 b2 c2 d2 b2 c2 a3 b3 c3 d3];  % zrobic dla 3h: 1h - co 5min, 2h - co 10 min, 3h - co 15 min

%% simulation
Tsim = length(setpoint);  % simulation time
t = 0:1:Tsim+16;
y = zeros(1, Tsim+17);
y_p = zeros(1, Tsim+17);
u = ones(1, Tsim+17);

for i = 1:1:Tsim

    %% update temperature based on the previous value and control signal
    y(i+17) = 0.9917*y(i+16) + 0.006448*u(i);
    y_p(i) = y(i) + 26;

    %% error calculation
    e1 = e2;
    e2 = setpoint(i) - y_p(i);

    %% PID calculations
    P = Kp * e2;
    I = Kp * (integral_e/Ti);
    D = Kp * ((e2 - e1)/Tp * Td);

    u_temp = P + I + D;  % calculate control signal before applying anti-windup

    %% anti-windup
    if u_temp > 100
        u(i+1) = 100;
    elseif u_temp < 0
        u(i+1) = 0;
    else
        u(i+1) = u_temp;
    end
    
    %% accumulate integral only if control signal is within limits
    if u_temp <= 100 && u_temp >= 0
        integral_e = integral_e + e2 * Tp;
    end
  
    %% store values for plotting
    E(i) = e1;
    U(i) = u(i);
    Y(i) = y_p(i);
       
    %% SSE Error Calculation
    if i < SSE_window
        % SSE = sum(E.^2);
        SSE = 0;
    else
        E_window = E(i-(SSE_window-1):i);
        SSE = sum(E_window.^2);
    end

    SSE_plot(i) = SSE;

    %% MAE Error Calculation
    if i < MAE_window
        %MAE(i) = sum(abs(E))/MAE_window;
        MAE(i) = 0;
    else
        E_window = E(i-(MAE_window-1):i);
        MAE(i) = sum(abs(E_window))/MAE_window;
    end

    %% Travel Index Calculation
    if i < TI_window
        %TI_u(i) = sum(abs(U-mean(U)))/i;
        %TI_y(i) = sum(abs(Y-mean(Y)))/i;
        TI_u(i) = 0;
        TI_y(i) = 0;
    else
        U_window = U(i-(TI_window-1):i);
        TI_u(i) = sum(abs(U_window-mean(U_window)))/TI_window;
        Y_window = Y(i-(TI_window-1):i);
        TI_y(i) = sum(abs(Y_window-mean(Y_window)))/TI_window;
    end
end

t = t(1:Tsim);
u = u(1:Tsim);
y = y(1:Tsim);

%% plotting the signals
figure;
subplot(2,1,1)
plot(t, U, 'b-', 'LineWidth', 0.7);
xlim([0, max(t)]);
ylim([-5, 105]);
title('Przebieg sygnału sterującego');
xlabel('Czas [s]');
ylabel("Wykorzystanie mocy grzałki [%]");
grid on

subplot(2,1,2)
plot(t, Y, 'b-', 'LineWidth', 0.7);
hold on;
plot(t, setpoint, 'm--', 'LineWidth', 1.1);
xlim([0, max(t)]);
ylim([25, 50]);
title('Przebieg sygnału procesowego');
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
legend('Sygnał wyjściowy', 'Wartość zadana');
grid on
hold off;

% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)

figure;
subplot(2,1,1)
plot(t, SSE_plot, 'b-', 'LineWidth', 0.7);
xlim([0, max(t)]);
title(['Wartość błędu SSE dla okna przesuwnego t = ', num2str(SSE_window), ' [s]']);
xlabel('Czas [s]');
ylabel('Błąd SSE');
grid on

subplot(2,1,2)
plot(t, MAE, 'b-', 'LineWidth', 0.7);
xlim([0, max(t)]);
title(['Wartość błędu MAE dla okna przesuwnego t = ', num2str(MAE_window), ' [s]']);
xlabel('Czas [s]');
ylabel('Błąd MAE');
grid on
 
figure;
subplot(2,1,1)
plot(t, TI_u, 'b-', 'LineWidth', 0.7);
xlim([0, max(t)]);
title(['Travel index dla sygnału sterującego dla okna przesuwnego t = ', num2str(TI_window), ' [s]']);
xlabel('Czas [s]');
ylabel('Travel index');
grid on

subplot(2,1,2)
plot(t, TI_y, 'b-', 'LineWidth', 0.7);
xlim([0, max(t)]);
title(['Travel index dla sygnału wyjściowego dla okna przesuwnego t = ', num2str(TI_window), ' [s]']);
xlabel('Czas [s]');
ylabel('Travel index');
grid on
