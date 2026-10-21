a = load('dane_2.mat');
b = load('dane_3.mat');
c = load('dane_4.mat');

% a = load('dane_sym_1.mat');
% b = load('dane_sym_2.mat');
% c = load('dane_sym_3.mat');

% b = load('dane_2.mat');
% a = load('dane_5.mat');
% c = load('dane_6.mat');

% b = load('dane_okno_normalne.mat');
% a = load('dane_okno_krotkie.mat');
% c = load('dane_okno_dlugie.mat');

figure;
T1 = a.t;
SSE1 = a.U;
plot(T1, SSE1, 'b-', 'LineWidth', 1.1);
hold on
title('Przebieg sygnału sterującego');
xlabel('Czas [s]');
ylabel("Wykorzystanie mocy grzałki [%]");
grid on

T2 = b.t;
SSE2 = b.U;
plot(T2, SSE2, 'g-', 'LineWidth', 1.1);
title('Przebieg sygnału sterującego');
xlabel('Czas [s]');
ylabel("Wykorzystanie mocy grzałki [%]");
grid on

T3 = c.t;
SSE3 = c.U;
plot(T3, SSE3, 'r-', 'LineWidth', 1.1);
title('Przebieg sygnału sterującego');
xlabel('Czas [s]');
ylabel("Wykorzystanie mocy grzałki [%]");
grid on
hold off

legend('regulator normalny', 'regulator agresywny', 'regulator łagodny');

% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)

figure;
T1 = a.t;
SSE1 = a.Y;
plot(T1, SSE1, 'b-', 'LineWidth', 1.1);
hold on
title('Przebieg sygnału procesowego');
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
grid on

T2 = b.t;
SSE2 = b.Y;
plot(T2, SSE2, 'g-', 'LineWidth', 1.1);
title('Przebieg sygnału procesowego');
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
grid on

T3 = c.t;
SSE3 = c.Y;
plot(T3, SSE3, 'r-', 'LineWidth', 1.1);
title('Przebieg sygnału procesowego');
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
grid on
hold off

legend('regulator normalny', 'regulator agresywny', 'regulator łagodny');

% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)

figure;
T1 = a.t;
SSE1 = a.SSE_plot;
window1 = a.SSE_window;
plot(T1, SSE1, 'b-', 'LineWidth', 1.1);
hold on
% title(['Wartość błędu SSE dla okna przesuwnego t = ', num2str(window1), ' [s]']);
title('Wartość błędu SSE regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Błąd SSE');
grid on

T2 = b.t;
SSE2 = b.SSE_plot;
window2 = b.SSE_window;
plot(T2, SSE2, 'g-', 'LineWidth', 1.1);
% title(['Wartość błędu SSE dla okna przesuwnego t = ', num2str(window2), ' [s]']);
title('Wartość błędu SSE regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Błąd SSE');
grid on

T3 = c.t;
SSE3 = c.SSE_plot;
window3 = c.SSE_window;
plot(T3, SSE3, 'r-', 'LineWidth', 1.1);
% title(['Wartość błędu SSE dla okna przesuwnego t = ', num2str(window3), ' [s]']);
title('Wartość błędu SSE regulatora normalnego dla różnych okien przesuwnych');

xlabel('Czas [s]');
ylabel('Błąd SSE');
grid on
hold off

% legend('regulator normalny', 'regulator agresywny', 'regulator łagodny');
legend('okno krótkie', 'okno średnie', 'okno długie');

% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)

figure;
T1 = a.t;
SSE1 = a.MAE;
window1 = a.MAE_window;
plot(T1, SSE1, 'b-', 'LineWidth', 1.1);
hold on
% title(['Wartość błędu MAE dla okna przesuwnego t = ', num2str(window1), ' [s]']);
title('Wartość błędu MAE regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Błąd MAE');
grid on

T2 = b.t;
SSE2 = b.MAE;
window2 = b.MAE_window;
plot(T2, SSE2, 'g-', 'LineWidth', 1.1);
% title(['Wartość błędu MAE dla okna przesuwnego t = ', num2str(window2), ' [s]']);
title('Wartość błędu MAE regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Błąd MAE');
grid on

T3 = c.t;
SSE3 = c.MAE;
window3 = c.MAE_window;
plot(T3, SSE3, 'r-', 'LineWidth', 1.1);
% title(['Wartość błędu MAE dla okna przesuwnego t = ', num2str(window3), ' [s]']);
title('Wartość błędu MAE regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Błąd MAE');
grid on
hold off

% legend('regulator normalny', 'regulator agresywny', 'regulator łagodny');
legend('okno krótkie', 'okno średnie', 'okno długie');

% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)

figure;
T1 = a.t;
SSE1 = a.TI_u;
window1 = a.TI_window;
plot(T1, SSE1, 'b-', 'LineWidth', 1.1);
hold on
% title(['Travel index dla sygnału sterującego dla okna przesuwnego t = ', num2str(window1), ' [s]']);
title('Travel index dla sygnału sterującego regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Travel index');
grid on

T2 = b.t;
SSE2 = b.TI_u;
window2 = b.TI_window;
plot(T2, SSE2, 'g-', 'LineWidth', 1.1);
% title(['Travel index dla sygnału sterującego dla okna przesuwnego t = ', num2str(window2), ' [s]']);
title('Travel index dla sygnału sterującego regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Travel index');
grid on

T3 = c.t;
SSE3 = c.TI_u;
window3 = c.TI_window;
plot(T3, SSE3, 'r-', 'LineWidth', 1.1);
% title(['Travel index dla sygnału sterującego dla okna przesuwnego t = ', num2str(window3), ' [s]']);
title('Travel index dla sygnału sterującego regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Travel index');
grid on
hold off

% legend('regulator normalny', 'regulator agresywny', 'regulator łagodny');
legend('okno krótkie', 'okno średnie', 'okno długie');

% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)

figure;
T1 = a.t;
SSE1 = a.TI_y;
window1 = a.TI_window;
plot(T1, SSE1, 'b-', 'LineWidth', 1.1);
hold on
% title(['Travel index dla sygnału procesowego dla okna przesuwnego t = ', num2str(window1), ' [s]']);
title('Travel index dla sygnału procesowego regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Travel index');
grid on

T2 = b.t;
SSE2 = b.TI_y;
window2 = b.TI_window;
plot(T2, SSE2, 'g-', 'LineWidth', 1.1);
% title(['Travel index dla sygnału procesowego dla okna przesuwnego t = ', num2str(window2), ' [s]']);
title('Travel index dla sygnału procesowego regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Travel index');
grid on

T3 = c.t;
SSE3 = c.TI_y;
window3 = c.TI_window;
plot(T3, SSE3, 'r-', 'LineWidth', 1.1);
% title(['Travel index dla sygnału procesowego dla okna przesuwnego t = ', num2str(window3), ' [s]']);
title('Travel index dla sygnału procesowego regulatora normalnego dla różnych okien przesuwnych');
xlabel('Czas [s]');
ylabel('Travel index');
grid on
hold off

% legend('regulator normalny', 'regulator agresywny', 'regulator łagodny');
legend('okno krótkie', 'okno średnie', 'okno długie');


% Zwiększenie czcionki osi X i Y
ax = gca; % Pobranie aktualnych osi
ax.FontSize = 16; % Ustawienie czcionki dla osi (możesz zmienić wartość)

% Zwiększenie czcionki legendy
legend_handle = legend; % Pobranie uchwytu do legendy
legend_handle.FontSize = 16; % Ustawienie czcionki dla legendy (możesz zmienić wartość)
