% Exercicio 3.11
load('pulses.mat'); % Carrega x1, x2, x3

fs = 500;
N = length(x1);
t = (0:N-1) / fs;

% 1. Plotar no dominio do tempo
figure;
subplot(3,1,1); plot(t, x1); title('Sinal x1 (Sem atraso)'); xlabel('Tempo (s)');
subplot(3,1,2); plot(t, x2); title('Sinal x2 (100 ms de atraso)'); xlabel('Tempo (s)');
subplot(3,1,3); plot(t, x3); title('Sinal x3 (200 ms de atraso)'); xlabel('Tempo (s)');

% Transformadas (Escalonadas)
X1 = fft(x1) / N;
X2 = fft(x2) / N;
X3 = fft(x3) / N;

f = (0:N-1) * (fs / N);

% 2. Espectro de Amplitude (Superpostos)
figure;
plot(f, abs(X1), 'b', f, abs(X2), 'r--', f, abs(X3), 'g:');
title('Espectro de Magnitude (Superpostos)');
xlabel('Frequencia (Hz)'); ylabel('Magnitude');
xlim([0 fs/2]); % Plota ate a frequencia de Nyquist
legend('x1', 'x2', 'x3');
% Nota: Voce vera apenas uma linha pois eles sao identicos!

% 3. Espectro de Fase (Primeiros 20 pontos + DC)
% Vamos converter radianos para graus e usar a rotina unwrap
fase1 = unwrap(angle(X1)) * (180/pi);
fase2 = unwrap(angle(X2)) * (180/pi);
fase3 = unwrap(angle(X3)) * (180/pi);

pts = 1:21; % DC + 20 pontos

figure;
stem(f(pts), fase1(pts), 'b', 'filled'); hold on;
stem(f(pts), fase2(pts), 'r', 'filled');
stem(f(pts), fase3(pts), 'g', 'filled');
title('Espectro de Fase (DC + 20 Harmonicas)');
xlabel('Frequencia (Hz)'); ylabel('Fase (Graus)');
legend('x1', 'x2', 'x3');
grid on;