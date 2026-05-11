% ex2_7.m - Desvio Padrão vs RMS
% (Execute o ex2_6.m antes ou mantenha as variáveis no workspace)

desvio_padrao = std(v);

fprintf('--- Exercício 2.7 ---\n');
fprintf('Desvio Padrão (std): %.4f\n', desvio_padrao);
fprintf('RMS (do Ex 2.6): %.4f\n', rms_manual);

% Explicação teórica:
% O RMS é igual ao desvio padrão quando a média do sinal é zero.
% Como a onda gerada é simétrica em relação ao eixo X, a média é zero.