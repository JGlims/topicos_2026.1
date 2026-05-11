% ex2_14.m - Teorema Central do Limite
clear; clc;

N = 10000;
dados = rand(4, N);
medias = mean(dados);

figure;
hist(medias, 50);
title('Distribuição das Médias (n=4)');
xlabel('Valores das Médias'); ylabel('Frequência');

% Comentário para o relatório:
% "Apesar do sinal original (rand) ser uniforme, a distribuição da média 
% de 4 amostras já apresenta o formato de sino característico da Gaussiana."