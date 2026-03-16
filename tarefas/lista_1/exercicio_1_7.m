% exercicio_1_7.m - Ruído de Quantização
clc; clear; close all;

t = linspace(0, 1, 1000);
y = sin(2 * pi * 5 * t); % Onda de 5Hz
bits_vec = [4, 8, 10, 12];

fprintf('--- Analise de Ruido (RMS) - 1.7 ---\n');

for n = bits_vec
    [y_q, erro] = quantizacao_sinal(y, n);
    
    % Ruído Simulado (RMS do erro)
    ruido_simulado = sqrt(mean(erro.^2));
    
    % Ruído Teórico (q / sqrt(12))
    q = (max(y) - min(y)) / (2^n - 1);
    ruido_teorico = q / sqrt(12);
    
    fprintf('Bits: %2d | Teorico: %.6f | Simulado: %.6f\n', ...
            n, ruido_teorico, ruido_simulado);
end

% Interpretação: A pequena diferença entre o teórico e o simulado ocorre
% porque a fórmula teórica assume que o erro tem distribuição uniforme,
% o que é uma aproximação estatística muito boa para altas resoluções.