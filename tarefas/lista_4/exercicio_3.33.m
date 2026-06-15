% Exercicio 3.33 - Adaptado para limitacoes do Octave
pkg load signal 

load('eeg_data.mat'); % Carrega a variavel 'eeg'

fs = 50;
N = length(eeg);

% Forca para vetor coluna e remove o DC
eeg_col = eeg(:); 
eeg_centered = eeg_col - mean(eeg_col);

% 1. Espectro SEM calculo de media (Periodograma)
Pxx_no_avg = (abs(fft(eeg_centered)).^2) / N;
f_no_avg = (0:N-1)' * (fs / N);

% 2. Espectro COM calculo de media (Metodo de Welch)
L = 256; % Tamanho do segmento
% LIMITACAO DO OCTAVE: O pacote signal trava com overlaps > 0.95.
% Usaremos 0.95 (95%) no lugar dos 0.99 (99%) pedidos na questao.
noverlap = 0.95; 

[Pxx_welch, f_welch] = pwelch(eeg_centered, hamming(L), noverlap, L, fs);

% Plotagem Comparativa
figure;

subplot(2,1,1);
plot(f_no_avg(1:floor(N/2)), Pxx_no_avg(1:floor(N/2)), 'b');
title('Espectro de Potencia (Sem Media - Periodograma)');
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]); % Frequencia de Nyquist

subplot(2,1,2);
plot(f_welch, Pxx_welch, 'r', 'LineWidth', 1.5);
title(['Espectro de Potencia (Welch) - Segmento: ' num2str(L) ' (95% overlap)']);
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]);
grid on;