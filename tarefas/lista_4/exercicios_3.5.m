% Exercicio 3.5
N = 1024;
fs = 1024; % Frequencia de amostragem
t = linspace(0, 1 - 1/fs, N); % Vetor de tempo de 1 segundo

% A onda tem periodo T=0.5s (f = 2Hz) e varia de -0.5 a 0.5
% O comando sawtooth(2*pi*f*t) cria uma onda de -1 a 1, entao multiplicamos por 0.5
x = 0.5 * sawtooth(2*pi*2*t);

% Transformada de Fourier com escalonamento
X = fft(x) / N;

% Reconstrucao usando os primeiros 24 componentes
x_recon = zeros(1, N);

% Lembrando: X(1) é o componente DC. 
% O primeiro componente harmonico comeca no indice 2.
% A equacao de reconstrucao soma os componentes de k=1 ate 24.
% Precisamos somar a parte positiva (k) e negativa (-k, que fica no final do vetor)
for k = 1:24
    idx_pos = k + 1;
    idx_neg = N - k + 1;
    % Superposicao das senoides complexas
    x_recon = x_recon + X(idx_pos)*exp(1i*2*pi*k*2*t) + X(idx_neg)*exp(-1i*2*pi*k*2*t);
end

% Adiciona o nivel DC (embora seja 0 para essa onda especifica)
x_recon = x_recon + X(1);

% Plotagem
figure;
plot(t, x, 'b', 'LineWidth', 1.5); hold on;
plot(t, real(x_recon), 'r--', 'LineWidth', 1.5); % Usa real() para evitar lixo numerico
xlabel('Time (s)');
ylabel('Amplitude');
title('Onda Dente de Serra Original vs Reconstruida (24 componentes)');
legend('Original', 'Reconstruida');
grid on;