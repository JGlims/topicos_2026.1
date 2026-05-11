% ex2_8.m - Detrend e Estacionariedade (Sinal Sintético)
clear; clc;

% Criando um sinal que imita o data_c1.mat (Exemplo 2.2)
% Um sinal não estacionário tem propriedades que mudam no tempo.
t = linspace(0, 10, 1000);
tendencia = 0.8 * t;               % Isso faz a média subir (não estacionário)
ruido = randn(size(t)) * 1.2;      % Ruído aleatório
sinal_original = tendencia + ruido;

% Aplicando o operador detrend (exigência do exercício 2.8)
sinal_corrigido = detrend(sinal_original);

% Avaliação de Estacionariedade (comparando dois segmentos)
N = length(sinal_corrigido);
meio = floor(N/2);
seg1 = sinal_corrigido(1:meio);
seg2 = sinal_corrigido(meio+1:end);

fprintf('--- Exercício 2.8 (Sinal Sintético) ---\n');
fprintf('Segmento 1 - Média: %.4f | Variância: %.4f\n', mean(seg1), var(seg1));
fprintf('Segmento 2 - Média: %.4f | Variância: %.4f\n', mean(seg2), var(seg2));
fprintf('\nConclusão: Após o detrend, as médias dos segmentos são próximas de zero,\n');
fprintf('o que indica que o sinal modificado tornou-se estacionário na média.\n');

figure;
subplot(2,1,1); plot(t, sinal_original); title('Sinal Original (Com Tendência)');
subplot(2,1,2); plot(t, sinal_corrigido); title('Sinal após Detrend (Estacionário)');