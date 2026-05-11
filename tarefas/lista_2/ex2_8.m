% ex2_8.m - Estacionariedade e Detrend
clear; clc;

% Carrega o sinal (o arquivo data_c1.mat deve estar na pasta)
try
    load('data_c1.mat'); 
    % Nota: Substitua 'x' pelo nome real da variável dentro do .mat se necessário
    sinal_original = x; 
catch
    error('Arquivo data_c1.mat não encontrado na pasta atual!');
end

% Aplica o operador detrend para remover tendência linear
sinal_modificado = detrend(sinal_original);

% Avaliação de estacionariedade (dividindo em dois segmentos)
N = length(sinal_modificado);
meio = floor(N/2);
seg1 = sinal_modificado(1:meio);
seg2 = sinal_modificado(meio+1:end);

fprintf('--- Exercício 2.8 ---\n');
fprintf('Segmento 1 - Média: %.4f | Variância: %.4f\n', mean(seg1), var(seg1));
fprintf('Segmento 2 - Média: %.4f | Variância: %.4f\n', mean(seg2), var(seg2));
fprintf('Conclusão: Se os valores forem similares, o sinal é estacionário.\n\n');