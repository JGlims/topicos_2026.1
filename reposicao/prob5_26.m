% prob5_26.m
% Resolução do Problema 5.26 (Semmlow, Cap 5)
% Reposição de Faltas - Tópicos em Engenharia (1/2026)

% Seu .octaverc já faz o clc e clear, mas é sempre bom garantir no script
clear; clc; close all;

disp('Executando Problema 5.26...');

% 1. Carregar os dados
load('ver.mat'); % Carrega a matriz 'ver' (100 observações x N amostras)

fs = 100; % Frequência de amostragem (Hz)
p = 12;   % Dimensão do subespaço de sinal (escolhido entre 9 e 15 conforme enunciado)
nfft = 256; % Tamanho da FFT

% 2. Primeira abordagem: pmusic com a Média dos sinais
ver_mean = mean(ver, 1); 
[PS_mean, f_mean] = pmusic(ver_mean, p, nfft, fs);

% 3. Segunda abordagem: pmusic com a Matriz direta
[PS_matrix, f_matrix] = pmusic(ver, p, nfft, fs);

% 4. Plotagem
figure('Name', 'Problema 5.26 - Visual-Evoked Response');

% Gráfico 1: Sinal Médio no Tempo
t = (0:length(ver_mean)-1) / fs; 
subplot(2, 1, 1);
plot(t, ver_mean, 'b', 'LineWidth', 1.5);
title('Sinal Médio (Visual-Evoked Response)');
xlabel('Tempo (s)'); ylabel('Amplitude');
grid on;

% Gráfico 2: Comparação dos Espectros (focando em baixas frequências)
subplot(2, 1, 2);
plot(f_mean, PS_mean, 'r', 'LineWidth', 1.5);
hold on;
plot(f_matrix, PS_matrix, 'g--', 'LineWidth', 1.5);
title('Espectro MUSIC - Média vs Matriz de Sinais');
xlabel('Frequência (Hz)'); ylabel('Pseudo-espectro');
legend('Média dos Sinais', 'Matriz Direta');
xlim([0 20]); % Restringindo às primeiras 20 componentes de baixa frequência
grid on;

disp('Problema 5.26 concluído. Verifique a figura gerada.');