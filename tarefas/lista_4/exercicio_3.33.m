% Exercicio 3.33 - Versao Blindada (Octave)
pkg load signal % Forcamos o load do pacote por precaucao

load('eeg_data.mat'); % Carrega a variavel 'eeg'

fs = 50;
N = length(eeg);

% FORCA a ser vetor coluna. Incompatibilidade de dimensoes 
% e a maior causadora de falhas no pwelch do Octave.
eeg_col = eeg(:); 
eeg_centered = eeg_col - mean(eeg_col);

% 1. Espectro SEM calculo de media (Periodograma)
Pxx_no_avg = (abs(fft(eeg_centered)).^2) / N;
f_no_avg = (0:N-1)' * (fs / N);

% 2. Espectro COM calculo de media (Metodo de Welch)
L = 256; 
% Passar 'L' faz o Octave gerar a janela Hamming do tamanho certo sozinho.
% Passar '0.99' indica a fracao de sobreposicao.
[Pxx_welch, f_welch] = pwelch(eeg_centered, L, 0.99, L, fs);

% Plotagem Comparativa
figure;

subplot(2,1,1);
plot(f_no_avg(1:floor(N/2)), Pxx_no_avg(1:floor(N/2)), 'b');
title('Espectro de Potencia (Sem Media - Periodograma)');
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]); % Forca a visualizacao apenas ate Nyquist (fs/2)

subplot(2,1,2);
plot(f_welch, Pxx_welch, 'r', 'LineWidth', 1.5);
title(['Espectro de Potencia (Metodo de Welch) - Segmento: ' num2str(L)]);
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]);
grid on;