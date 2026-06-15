% Exercicio 3.13
load('ECG_1min.mat'); % Carrega variavel ecg

fs = 250;
N = length(ecg);
f = (0:N-1) * (fs / N);

% Transformada de Fourier
X_ecg = fft(ecg) / N;
mag_ecg = abs(X_ecg);
phase_ecg = unwrap(angle(X_ecg));

% Filtrando limitacao ate 20 Hz e removendo o nivel DC (indice 1)
% Encontramos o indice correspondente a 20 Hz
idx_20Hz = find(f <= 20, 1, 'last');
f_plot = f(2:idx_20Hz);
mag_plot = mag_ecg(2:idx_20Hz);
phase_plot = phase_ecg(2:idx_20Hz);

% 1. Plot Magnitude e Fase ate 20 Hz
figure;
subplot(2,1,1);
plot(f_plot, mag_plot);
title('Espectro de Magnitude do ECG (Sem DC, ate 20Hz)');
xlabel('Frequencia (Hz)'); ylabel('Magnitude');

subplot(2,1,2);
plot(f_plot, phase_plot);
title('Espectro de Fase Unwrapped');
xlabel('Frequencia (Hz)'); ylabel('Fase (radianos)');

% 2. Encontrar FC a partir do pico
[max_mag, idx_max_local] = max(mag_plot);
fmax = f_plot(idx_max_local); % Frequencia fundamental em Hz

% Calculos fisiologicos
RR_interval = 1 / fmax; % Intervalo entre picos R (segundos)
HR_bpm = fmax * 60;     % Frequencia cardiaca em bpm

fprintf('Frequencia do pico maximo (fmax): %.4f Hz\n', fmax);
fprintf('Intervalo R-R medio estimado: %.4f s\n', RR_interval);
fprintf('Frequencia Cardiaca media estimada: %.2f bpm\n', HR_bpm);