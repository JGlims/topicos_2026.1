% resolucao_p9_3.m - Preparando a cama para o TVmodel_RLS.m
clear; clc; close all;

% 1. Gerando os dados de entrada e saída (u e y) exigidos pelo TVmodel_RLS
N = 500;
randn('seed', 42);
u_raw = randn(N, 1); % Entrada u(n)
u = [u_raw, [0; u_raw(1:end-1)]]; % Matriz u com atraso (N x 2)
y = zeros(N, 1);

% Sistema variante no tempo: no instante 250, o corpo muda!
for n = 1:N
    if n < 250
        y(n) = 0.5 * u(n, 1) - 0.3 * u(n, 2) + 0.05 * randn();
    else
        y(n) = 0.2 * u(n, 1) + 0.7 * u(n, 2) + 0.05 * randn();
    end
end

% 2. Setando as variáveis que o script do Khoo exigia via teclado
lambda = 0.98;
np = 2; % Número de parâmetros a estimar

% 3. Chamando o script do livro
TVmodel_RLS; 

% 4. Plotando o resultado maravilhoso
figure;
plot(1:N, theta(:, 1), 'b', 'LineWidth', 1.5); hold on;
plot(1:N, theta(:, 2), 'r', 'LineWidth', 1.5);
line([0 N], [0.5 0.5], 'Color', 'b', 'LineStyle', '--');
line([0 N], [-0.3 -0.3], 'Color', 'r', 'LineStyle', '--');
line([250 N], [0.2 0.2], 'Color', 'b', 'LineStyle', '--');
line([250 N], [0.7 0.7], 'Color', 'r', 'LineStyle', '--');
title('Rastreamento RLS Variante no Tempo (P9.3)');
xlabel('Instante n'); ylabel('Parâmetros Estimados');
legend('\theta_1 estimado', '\theta_2 estimado', 'Real');
grid on;