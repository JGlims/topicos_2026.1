% prob5_27.m
% Resolução do Problema 5.27 (Semmlow, Cap 5)
% Reposição de Faltas - Tópicos em Engenharia (1/2026)

clear; clc; close all;

disp('Executando Problema 5.27...');

% 1. Carregar os dados
load('multi_observations.mat'); % Carrega a matriz 'x'

fs = 200; % Frequência de amostragem dada (Hz)
p = 5;    % Subespaço de sinal (aproximadamente 2 senoides = 4, usamos 5 para margem de ruído)
nfft = 256; 

% 2. Primeira abordagem: Média dos sinais (vai falhar em achar os picos por conta das fases)
x_mean = mean(x, 1);
[PS_mean, f_mean] = pmusic(x_mean, p, nfft, fs);

% 3. Segunda abordagem: Matriz direta (cálculo de correlação preserva componentes)
[PS_matrix, f_matrix] = pmusic(x, p, nfft, fs);

% 4. Plotagem
figure('Name', 'Problema 5.27 - Senoides não sincronizadas');

plot(f_mean, PS_mean, 'r', 'LineWidth', 1.5);
hold on;
plot(f_matrix, PS_matrix, 'g--', 'LineWidth', 1.5);
title('Espectro MUSIC: Média vs Matriz Direta');
xlabel('Frequência (Hz)'); ylabel('Pseudo-espectro');
legend('Média dos Sinais', 'Matriz Direta');
grid on;

disp('Problema 5.27 concluído.');
disp('Note como o plot verde (Matriz) detecta os picos em 20 Hz e 70 Hz, mas o vermelho (Média) não!');