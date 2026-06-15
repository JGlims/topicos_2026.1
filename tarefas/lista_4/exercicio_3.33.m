% Exercicio 3.33
load('eeg_data.mat'); % Carrega 'eeg'

fs = 50;
N = length(eeg);

% 1. Espectro SEM calculo de media (Periodograma convencional)
% Removemos a media (DC) para nao ofuscar o grafico
eeg_centered = eeg - mean(eeg);
Pxx_no_avg = (abs(fft(eeg_centered)).^2) / N;
f_no_avg = (0:N-1) * (fs / N);

% 2. Espectro COM calculo de media usando pwelch
% A questao pede 99% de sobreposicao.
% Ajuste o L (segment length) para achar o compromisso ideal entre
% reducao de ruido e retencao de picos de interesse (ex: ritmos Alpha/Beta).
% Um valor entre 200 e 500 costuma funcionar bem para esse fs=50.
L = 250; % Tamanho do segmento (Experimente mudar esse valor!)
noverlap = round(0.99 * L); 

[Pxx_welch, f_welch] = pwelch(eeg_centered, hamming(L), noverlap, L, fs);

% Plotagem
figure;
subplot(2,1,1);
plot(f_no_avg(1:floor(N/2)), Pxx_no_avg(1:floor(N/2)));
title('Espectro de Potencia (Sem Media - Periodograma)');
xlabel('Frequencia (Hz)'); ylabel('Potencia');

subplot(2,1,2);
plot(f_welch, Pxx_welch, 'r', 'LineWidth', 1.5);
title(['Espectro de Potencia (Metodo de Welch) - Tamanho do Segmento: ' num2str(L)]);
xlabel('Frequencia (Hz)'); ylabel('Potencia');