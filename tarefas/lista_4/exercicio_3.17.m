% Exercicio 3.17
load('short.mat'); % Assumindo que carrega variavel 'x' (sinal curto)

% Para garantir, se a variavel for diferente, ajuste o nome 'x'
% Vamos assumir que a variavel de sinal dentro de short.mat seja x.
N_orig = length(x);
N_pad = 256;

X_orig = abs(fft(x)) / N_orig;
X_pad = abs(fft(x, N_pad)) / N_orig; % Mantem a escala original p/ comparar corretamente

% Eixos de frequencia normalizados entre 0 e 1 (ja que nao temos fs)
f_orig = (0:N_orig-1) / N_orig;
f_pad = (0:N_pad-1) / N_pad;

figure;
stem(f_orig, X_orig, 'b', 'filled'); hold on;
plot(f_pad, X_pad, 'r', 'LineWidth', 1.5);
title('Espectro de Magnitude: Sem e Com Zero-Padding');
xlabel('Frequencia Normalizada');
ylabel('Magnitude');
legend('Original (32 pts)', 'Zero-padded (256 pts)');
grid on;