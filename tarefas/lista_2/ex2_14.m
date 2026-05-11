% ex2_14.m - Teorema Central do Limite
clear; clc;

% Gera 10.000 colunas, cada uma com 4 números aleatórios uniformes
dados_brutos = rand(4, 10000);

% Calcula a média de cada conjunto de 4 números
medias = mean(dados_brutos);

% Plota o histograma
figure;
hist(medias, 50);
title('Histograma de Médias (n=4) - Teorema Central do Limite');
xlabel('Valor da Média');
ylabel('Frequência');

% Observação: Mesmo o ruído original sendo uniforme, a distribuição das
% médias se aproxima de uma Gaussiana (sino).