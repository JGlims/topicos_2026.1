% Exercicio 3.33 - Solucao Definitiva
load('eeg_data.mat'); % Carrega a variavel 'eeg'

fs = 50;
N = length(eeg);

% 1. Espectro SEM calculo de media (Periodograma)
eeg_centered = eeg - mean(eeg);
Pxx_no_avg = (abs(fft(eeg_centered)).^2) / N;
f_no_avg = (0:N-1) * (fs / N);

% 2. Espectro COM calculo de media (Metodo de Welch)
L = 256; % Tamanho do segmento
noverlap = round(0.99 * L); 

% Pegamos apenas o Pxx. Ignoramos o vetor de frequencia original do Octave usando "~"
[Pxx_welch, ~] = pwelch(eeg_centered, hamming(L), noverlap, L, fs);

% A SOLUCAO: Criamos nosso proprio eixo X linear cravado em Hz!
% Vai de 0 ate fs/2 (Nyquist), com o mesmo numero de pontos do Pxx_welch
f_welch = linspace(0, fs/2, length(Pxx_welch));

% Plotagem
figure;
subplot(2,1,1);
plot(f_no_avg(1:floor(N/2)), Pxx_no_avg(1:floor(N/2)), 'b');
title('Espectro de Potencia (Sem Media - Periodograma)');
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]); 

subplot(2,1,2);
plot(f_welch, Pxx_welch, 'r', 'LineWidth', 1.5);
title(['Espectro de Potencia (Metodo de Welch) - Segmento: ' num2str(L)]);
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]); 
grid on;