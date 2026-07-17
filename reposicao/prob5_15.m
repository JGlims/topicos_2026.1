% =====================================================================
%  Problema 5.15 - repete o 5.14 usando os coeficientes de filter_coeff2.mat
%  (fs = 250 Hz, ruido gaussiano N = 2058). Este filtro e mais complexo
%  (IIR de ordem 24), entao uma ordem AR MODERADAMENTE baixa funciona
%  melhor. As regioes de passagem sao representadas por multiplos picos.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));
randn('state',21); rand('state',21);

S = load(fullfile(fileparts(mfilename('fullpath')),'filter_coeff2.mat'));
b = S.b; a = S.a; fs = 250; N = 2058; p = 12;   % ordem AR moderada

x = randn(N,1);
y = filter(b, a, x);

[H,fH] = freqz(b, a, 1024, fs);
magH2 = abs(H).^2;
[PS, f] = pyulear(y, p, 1024, fs);

figure('visible','off'); set(gcf,'Position',[100 100 1000 420]);
subplot(1,2,1);
  plot(fH, magH2, 'k','LineWidth',1);
  title('Resposta verdadeira do filtro |H(f)|^2 (referencia)');
  xlabel('Frequencia (Hz)'); ylabel('|H|^2'); grid on; xlim([0 fs/2]);
subplot(1,2,2);
  plot(f, PS, 'k','LineWidth',1);
  title(sprintf('Espectro AR da saida (pyulear, p=%d)', p));
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on; xlim([0 fs/2]);
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_15.png'), '-dpng','-r120');

% Banda de REJEICAO (stopband) da resposta verdadeira: onde |H|^2 < 0.5
stop = fH(magH2 < 0.5);
printf('5.15 | |H(0)|^2=%.3f  |H(fs/2)|^2=%.3f  -> filtro REJEITA-FAIXA (notch)\n', magH2(1), magH2(end));
printf('5.15 | banda de rejeicao (<-3dB) da resposta real: ~%.0f a %.0f Hz\n', min(stop), max(stop));
