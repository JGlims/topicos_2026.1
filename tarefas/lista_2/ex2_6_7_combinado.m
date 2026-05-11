% ex2_6_7_combinado.m - RMS e Desvio Padrão
clear; clc;
pkg load signal;

% --- Exercício 2.6 ---
A = 1.0; T = 0.5; N = 1000;
t = linspace(0, T, N); 
v = A * sawtooth(2 * pi * (1/T) * t, 0.5); % Geração da onda

rms_manual = sqrt(sum(v.^2) / N);
rms_func = rms(v);

fprintf('--- Exercício 2.6 ---\n');
fprintf('RMS Manual: %.4f | RMS Função: %.4f\n', rms_manual, rms_func);

% --- Exercício 2.7 ---
% Usamos std(v, 1) para usar N no denominador (estatística populacional)
desvio_padrao = std(v, 1); 

fprintf('\n--- Exercício 2.7 ---\n');
fprintf('Desvio Padrão (STD): %.4f\n', desvio_padrao);
fprintf('Comparação: RMS e STD são iguais porque a média do sinal é zero.\n');

figure; plot(t, v); title('Onda Gerada - Ex 2.6'); grid on;