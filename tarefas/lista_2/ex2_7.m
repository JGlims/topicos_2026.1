% ex2_7.m - Desvio Padrão vs RMS
% (Certifique-se de rodar o ex2_6.m antes para ter a variável 'v')

rms_valor = rms(v);
std_amostral = std(v);    % Usa N-1
std_populacional = std(v, 1); % Usa N

fprintf('--- Exercício 2.7 ---\n');
fprintf('RMS original: %.4f\n', rms_valor);
fprintf('STD (N-1): %.4f\n', std_amostral);
fprintf('STD (N): %.4f\n', std_populacional);

% Conclusão para o relatório:
% "A discrepância ocorre porque a função std usa N-1. Ao usar std(v, 1),
% o valor se iguala ao RMS, já que a média do sinal é praticamente zero."