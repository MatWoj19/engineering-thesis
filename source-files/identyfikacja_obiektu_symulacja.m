%% clean up the workspace, close figures and clear command window
clear all
close all
clc

%% prerequisites
addpath('D:\SerialCommunication');  % add a path to the functions
initSerialControl COM3  % initialise com port

%% initial parameters
sim_time = 1200;  % simulation time [s]
HR = 30;   % power of the right heater [%]
FRU = 30;  % power of the upper right fan [%] (constant)
Tp = 1;    % sampling time [s]
i = 0;     % 'while' loop counter

%% pre-allocate arrays for efficiency
Y = zeros(1, sim_time);  % temperature array (output)
U = zeros(1, sim_time);  % control signal array (input)
t = zeros(1, sim_time);  % time

while(i < sim_time)
    
    i = i + 1;  % increment the counter

    %% obtaining measurements
    y = readMeasurements(3);  % read temperature from TR sensor
    
    %% store time, input and output values
    t(i) = Tp*(i-1);
    U(i) = HR;
    Y(i) = y;
                 
    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 0, FRU, 0, 0, 0, HR]);  % new corresponding control values   

    %% plotting the signals
    drawnow;
    subplot(2,1,1)
    plot(t(1:i), U(1:i));
    title("Przebieg sygnału wejściowego");
    xlabel("Czas [s]");
    ylabel("Wykorzystanie mocy grzałki [%]");
    
    subplot(2,1,2)
    plot(t(1:i), Y(1:i));
    title("Przebieg sygnału wyjściowego");
    xlabel("Czas [s]");
    ylabel("Temperatura [°C]");

    %% synchronising with the control process
    pause(Tp);
end

%% save Y and t vectors to .mat file (adjust the name if needed)
save('obiekt_odp_skokowa_30_wektory.mat', 'Y', 't');
