% exercicio_1_8_9.m - Simulação de Aliasing
clc; clear;

% Sinal Original: 5 Hz amostrado em alta resolução (1000 pontos)
t_orig = linspace(0, 1, 1000);
f_sinal = 5;
y_orig = sin(2 * pi * f_sinal * t_orig);

% 1.8 Amostragem em 7 Hz (Ts = 1/7)
fs1 = 7;
ts1 = 0:1/fs1:1;
y_amostrado1 = sin(2 * pi * f_sinal * ts1);

% 1.9 Amostragem em 9 Hz (Ts = 1/9)
fs2 = 9;
ts2 = 0:1/fs2:1;
y_amostrado2 = sin(2 * pi * f_sinal * ts2);

figure('Name', 'Aliasing: 5Hz amostrado em 7Hz e 9Hz');

% Plot 7Hz
subplot(2,1,1);
plot(t_orig, y_orig, 'k--'); hold on;
plot(ts1, y_amostrado1, 'ro', 'MarkerFaceColor', 'r');
% Sinal de Aliasing esperado: |7 - 5| = 2 Hz
y_alias1 = sin(2 * pi * 2 * t_orig + pi); % Defasado em 180 (pi rad)
plot(t_orig, y_alias1, 'r', 'LineWidth', 1.5);
title('Amostragem 7Hz (Aliasing de 2Hz observado)');
legend('Original 5Hz', 'Amostras', 'Sinal Aparente 2Hz');

% Plot 9Hz
subplot(2,1,2);
plot(t_orig, y_orig, 'k--'); hold on;
plot(ts2, y_amostrado2, 'go', 'MarkerFaceColor', 'g');
% Sinal de Aliasing esperado: |9 - 5| = 4 Hz
y_alias2 = sin(2 * pi * 4 * t_orig + pi);
plot(t_orig, y_alias2, 'g', 'LineWidth', 1.5);
title('Amostragem 9Hz (Aliasing de 4Hz observado)');
legend('Original 5Hz', 'Amostras', 'Sinal Aparente 4Hz');