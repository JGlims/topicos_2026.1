% ex2_8.m - Detrend e Estacionariedade
clear; clc;

if exist('data_c1.mat', 'file')
    load('data_c1.mat'); 
    % No Semmlow, a variável geralmente se chama 'x' ou 'data'
    % Se não souber o nome, digite 'whos' no console após o load
    sinal = x; 

    % 1. Aplicar detrend
    sinal_estacionario = detrend(sinal);

    % 2. Avaliar média e variância de dois segmentos
    meio = floor(length(sinal_estacionario)/2);
    seg1 = sinal_estacionario(1:meio);
    seg2 = sinal_estacionario(meio+1:end);

    fprintf('--- Exercício 2.8 ---\n');
    fprintf('Segmento 1: Média = %.4f, Variância = %.4f\n', mean(seg1), var(seg1));
    fprintf('Segmento 2: Média = %.4f, Variância = %.4f\n', mean(seg2), var(seg2));
    
    % Plot para visualização
    figure;
    subplot(2,1,1); plot(sinal); title('Sinal Original (Não Estacionário)');
    subplot(2,1,2); plot(sinal_estacionario); title('Sinal após Detrend');
else
    fprintf('ERRO: Baixe o data_c1.mat do site do Semmlow e coloque nesta pasta!\n');
end