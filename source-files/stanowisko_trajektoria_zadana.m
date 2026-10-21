%% Clean up the workspace, close figures and clear command window
clear all
close all
clc

%% Prerequisites
addpath('D:\SerialCommunication');  % Add a path to the functions
initSerialControl COM3  % Initialise COM port

%% Initial Parameters  
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
setpoint = [a b c d b c d a b d a c a2 b2 c2 d2 b2 c2 a3 b3 c3 d3];
FRU = 30;  % Upper right fan power [%]
Tp = 1;    % Sampling time [s]
SSE_window = 1200;
MAE_window = 1200;
TI_window = 1200;

%% PID Parameters
Kp = 6;    % Proportional gain
Ti = 120;  % Integral time constant
Td = 5;    % Derivative time constant

%% Initial Values
e1 = 0;  % Error in t time
e2 = 0;  % Error in t+1 time
integral_e = 0;
%u = 0.0000001;
% u = ones(1, length(setpoint)+17);
i = 0;  % Counter for 'while' loop

%% Control Loop
while(i < length(setpoint))
    i = i + 1;  % Increment counter
    
    %% Obtaining Measurements
    y = readMeasurements(3);  % Read temperature from TR sensor
    Y(i) = y;
    t(i) = Tp*(i-1);

    %% error calculation
    e1 = e2;
    e2 = setpoint(i) - y;

    %% PID calculations
    P = Kp * e2;
    I = Kp * (integral_e/Ti);
    D = Kp * ((e2 - e1)/Tp * Td);

    u_temp = P + I + D;  % calculate control signal before applying anti-windup

    %% anti-windup
    if u_temp > 100
        u = 100;
    elseif u_temp < 0
        u = 0;
    else
        u = u_temp;
    end

    %% accumulate integral only if control signal is within limits
    if u == u_temp
        integral_e = integral_e + e2 * Tp;
    end

    U(i) = u;
    
    %% Sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... Send for these elements
                 [ 0, FRU, 0, 0, 0, u]);  % New corresponding control values

    %% SSE Error Calculation
    E(i) = setpoint(i) - y;

    if i < SSE_window
        SSE = sum(E.^2);
    else
        E_window = E(i-(SSE_window-1):i);
        SSE = sum(E_window.^2);
    end    

    SSE_plot(i) = SSE;

    %% MAE Error Calculation
    if i < MAE_window
        MAE(i) = sum(abs(E))/i;
    else
        E_window = E(i-(MAE_window-1):i);
        MAE(i) = sum(abs(E_window))/MAE_window;
    end

    %% Travel Index Calculation
    if i < TI_window
        TI_u(i) = sum(abs(U-mean(U)))/i;
        TI_y(i) = sum(abs(Y-mean(Y)))/i;
    else
        U_window = U(i-(TI_window-1):i);
        TI_u(i) = sum(abs(U_window-mean(U_window)))/TI_window;
        Y_window = Y(i-(TI_window-1):i);
        TI_y(i) = sum(abs(Y_window-mean(Y_window)))/TI_window;
    end
  
    %% Plotting the Signals
    drawnow;
    subplot(3,2,1);
    plot(t, U, 'b-', 'LineWidth', 0.7);
    title('Przebieg sygnału sterującego');
    xlabel('Czas [s]');
    ylabel('Wykorzystanie mocy grzałki [%]');
    grid on

    subplot(3,2,2);
    plot(t, Y, 'b-', 'LineWidth', 0.7);
    hold on;
    plot(t, setpoint(1:length(t)), 'r--', 'LineWidth', 0.7); 
    title('Przebieg sygnału wyjściowego');
    xlabel('Czas [s]');
    ylabel('Temperatura [°C]');
    legend('output', 'setpoint');
    grid on
    hold off;

    subplot(3,2,3);
    plot(t, SSE_plot, 'b-', 'LineWidth', 0.7);
    title(['Wartość błędu SSE dla okna przesuwnego t = ', num2str(SSE_window), ' [s]']);
    xlabel('Czas [s]');
    ylabel('Błąd SSE');
    grid on

    subplot(3,2,4);
    plot(t, MAE, 'b-', 'LineWidth', 0.7);
    title(['Wartość błędu MAE dla okna przesuwnego t = ', num2str(MAE_window), ' [s]']);
    xlabel('Czas [s]');
    ylabel('Błąd MAE');
    grid on

    subplot(3,2,5);
    plot(t, TI_u, 'b-', 'LineWidth', 0.7);
    title(['Travel index dla sygnału sterującego dla okna przesuwnego t = ', num2str(TI_window), ' [s]']);
    xlabel('Czas [s]');
    ylabel('Travel index');
    grid on

    subplot(3,2,6);
    plot(t, TI_y, 'b-', 'LineWidth', 0.7)
    title(['Travel index dla sygnału wyjściowego dla okna przesuwnego t = ', num2str(TI_window), ' [s]']);
    xlabel('Czas [s]');
    ylabel('Travel index');
    grid on

    pause(Tp);  % Wait for new iteration  
end
