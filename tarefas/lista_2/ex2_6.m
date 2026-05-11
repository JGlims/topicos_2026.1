% ex2_6.m - Geração de onda e cálculo de RMS
clear; clc;
pkg load signal; % Garante o carregamento para o sawtooth

% Parâmetros do problema
A = 1.0;            % Amplitude (V)
T = 0.5;            % Período (s)
N = 1000;           % Total de pontos por período
t = linspace(0, T, N); 

% Geração da onda triangular (sawtooth com largura de 0.5)
v = A * sawtooth(2 * pi * (1/T) * t, 0.5);

% Plot para conferência
figure;
plot(t, v, 'LineWidth', 1.5);
title('Forma de Onda (Ex 2.6)');
xlabel('Time (s)'); ylabel('v(t)');
grid on;

% Cálculo RMS via Equação 2.13 (Manual)
% RMS = sqrt( (1/N) * sum(v^2) )
rms_manual = sqrt(sum(v.^2) / N);

% Cálculo RMS via função do Octave/Matlab
rms_func = rms(v);

fprintf('--- Exercício 2.6 ---\n');
fprintf('Valor RMS (Equação 2.13): %.4f\n', rms_manual);
fprintf('Valor RMS (Função rms): %.4f\n', rms_func);
fprintf('Similaridade: A diferença é de %.2e (erro de precisão numérica).\n\n', abs(rms_manual - rms_func));