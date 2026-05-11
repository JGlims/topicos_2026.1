% ex2_7.m - Desvio Padrão vs RMS
% IMPORTANTE: Rode o ex2_6.m antes para gerar a variável 'v'!

% Cálculo do Desvio Padrão Populacional (usando '1' para dividir por N, não N-1)
std_v = std(v, 1); 
rms_v = rms(v);

fprintf('\n--- Exercício 2.7 ---\n');
fprintf('Desvio Padrão (N): %.4f\n', std_v);
fprintf('Valor RMS (Ex 2.6): %.4f\n', rms_v);

% Explicação para o relatório:
% Como a média do sinal gerado é zero (ou muito próxima, ex: 10^-17), 
% o desvio padrão se torna matematicamente idêntico ao RMS.