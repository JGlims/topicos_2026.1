% exercicio_1_6.m - Teste da Eq 1.6 de Semmlow
clc; clear; close all;

f = 4;          % 4 Hz
Ts = 0.002;     % 0.002 s
t = 0:Ts:(1000*Ts - Ts); % 1000 pontos
y = sin(2 * pi * f * t);

bits_list = [4, 8, 12, 16];
fprintf('--- Resultados Exercicio 1.6 ---\n');

figure('Name', 'Erro de Quantização - 1.6');

for ii = 1:length(bits_list)
    n = bits_list(ii);
    [y_q, erro] = quantizacao_sinal(y, n);
    
    % Amplitude teórica do erro (q)
    q = (max(y) - min(y)) / (2^n - 1);
    
    % Amplitude medida do erro (Diferença entre Max e Min)
    amp_erro = max(erro) - min(erro);
    
    % Exibição com 4 casas decimais conforme solicitado
    fprintf('Bits: %2d | q Teórico: %.4f | Amp Erro Medida: %.4f\n', ...
            n, q, amp_erro);
            
    subplot(4, 1, ii);
    plot(t(1:200), erro(1:200)); % Mostra apenas o início para ver detalhes
    title(['Sinal de Erro - ', num2str(n), ' bits']);
    grid on;
end

% Discussão: Note que a amplitude do erro medida é aproximadamente igual a q.
% Isso valida a Eq. 1.6, mostrando que o erro de quantização fica 
% confinado em uma faixa proporcional à resolução do conversor.