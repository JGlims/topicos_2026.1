% exercicio_1_5.m - Lista 1 Semmlow
clc; clear;

f = 2; % Frequência de 2 Hz
T_total = 1; % Duração de 1 segundo
Ts_list = [0.05, 0.01, 0.001]; % Intervalos de amostragem solicitados

figure('Name', 'Exercicio 1.5 - Amostragem');

for ii = 1:length(Ts_list)
    Ts = Ts_list(ii);
    t = 0:Ts:T_total;
    y = sin(2 * pi * f * t);
    
    subplot(3, 1, ii);
    plot(t, y, 'b-', 'LineWidth', 1); % Linha contínua
    hold on;
    plot(t, y, 'ro', 'MarkerSize', 4); % Pontos individuais
    
    title(['Intervalo de Amostragem Ts = ', num2str(Ts), ' s']);
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    grid on;
end

% Interpretação Acadêmica: 
% Observa-se que com Ts = 0.05s, temos apenas 10 pontos por ciclo (20 no total).
% A curva parece "facetada". Com Ts = 0.001s, a reconstrução visual é contínua.
% O Capítulo 3 detalhará que, para evitar perda de informação (Aliasing), 
% a frequência de amostragem fs deve ser > 2 * f_max (Teorema de Nyquist).