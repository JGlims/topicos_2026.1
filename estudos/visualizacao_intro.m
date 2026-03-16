% visualizacao_intro.m - Dominando o Plot
clc; clear; % Seu alias customizado para limpar tudo
close all;

t = 0:0.1:10; % Vetor de tempo (amostragem) [cite: 969]
sinal_seno = sin(t);
sinal_cosseno = cos(t);

figure(1);
plot(t, sinal_seno, 'b', 'LineWidth', 2); % Seno em azul [cite: 1062, 1095]
hold on; % Não apaga o anterior [cite: 1053, 1134]
plot(t, sinal_cosseno, 'r--', 'LineWidth', 2); % Cosseno tracejado vermelho
grid on;
title('Sinais Trigonométricos - Cap 2'); [cite: 1063]
xlabel('Tempo (s)'); [cite: 1967]
ylabel('Amplitude');
legend('Seno', 'Cosseno');

% Exemplo de Subplots (muito usado em Bioengenharia) [cite: 1451]
figure(2);
subplot(2,1,1);
bar(t(1:20), sinal_seno(1:20)); % Versão em barras [cite: 1067]
title('Seno (Barras)');
subplot(2,1,2);
stem(t(1:20), sinal_seno(1:20)); % Versão discreta (Octave/Signal)
title('Seno (Discreto/Stem)');
