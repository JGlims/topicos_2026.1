% Exercício 1.5 - Lista 1
% Objetivo: Analisar o efeito da amostragem em um sinal de 100 Hz

f_max = 100; % Frequência máxima do sinal (ex: componente de um ECG)
t = 0:0.0001:0.05; % Tempo "contínuo"
x = sin(2*pi*f_max*t);

% Testando Fs = 150 Hz (Abaixo de Nyquist - deve causar aliasing)
Fs1 = 150;
t1 = 0:1/Fs1:0.05;
x1 = sin(2*pi*f_max*t1);

figure;
subplot(2,1,1);
plot(t,x,'b'); hold on; stem(t1,x1,'r');
title(['Amostragem com Fs = ', num2str(Fs1), ' Hz (Aliasing)']);
legend('Original','Amostrado');

% Testando Fs = 500 Hz (Acima de Nyquist - representação correta)
Fs2 = 500;
t2 = 0:1/Fs2:0.05;
x2 = sin(2*pi*f_max*t2);

subplot(2,1,2);
plot(t,x,'b'); hold on; stem(t2,x2,'g');
title(['Amostragem com Fs = ', num2str(Fs2), ' Hz (Correto)']);
legend('Original','Amostrado');