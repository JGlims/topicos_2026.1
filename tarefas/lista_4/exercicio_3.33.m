% Exercicio 3.33 - Completo e Corrigido para Octave
load('eeg_data.mat'); % Carrega a variavel 'eeg'

fs = 50;
N = length(eeg);

% 1. Espectro SEM calculo de media (Periodograma)
% Tiramos a media (nivel DC) para nao distorcer a visualizacao do espectro
eeg_centered = eeg - mean(eeg);
Pxx_no_avg = (abs(fft(eeg_centered)).^2) / N;
f_no_avg = (0:N-1) * (fs / N);

% 2. Espectro COM calculo de media (Metodo de Welch)
L = 256; % Tamanho do segmento escolhido para suavizacao adequada
noverlap = round(0.99 * L); % 99% de sobreposicao exigida no enunciado

% pwelch no Octave com a janela de Hamming
[Pxx_welch, f_welch] = pwelch(eeg_centered, hamming(L), noverlap, L, fs);

% Trava de seguranca para o Octave:
% Converte para Hertz caso a funcao retorne frequencia normalizada (0 a 0.5)
if max(f_welch) <= 0.5
    f_welch = f_welch * fs; 
end

% Plotagem Comparativa
figure;

% Subplot 1: Periodograma tradicional
subplot(2,1,1);
plot(f_no_avg(1:floor(N/2)), Pxx_no_avg(1:floor(N/2)), 'b');
title('Espectro de Potencia (Sem Media - Periodograma)');
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]); % Nyquist é fs/2 (25 Hz)

% Subplot 2: Metodo de Welch
subplot(2,1,2);
plot(f_welch, Pxx_welch, 'r', 'LineWidth', 1.5);
title(['Espectro de Potencia (Metodo de Welch) - Segmento: ' num2str(L)]);
xlabel('Frequencia (Hz)'); 
ylabel('Potencia');
xlim([0 25]); % Mantem a mesma escala do eixo X para comparacao
grid on;