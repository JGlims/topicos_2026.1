% =====================================================================
%  Problema 5.6 - complementa o 5.5: efeito do SNR sobre a resolucao
%  espectral com metodos AR. Mesmas tres senoides (240, 260, 350 Hz),
%  porem com comprimento FIXO N = 256. Metodo da covariancia modificada
%  (pmcov) com ordem 35, varrendo SNR = -6, -10, -12 e -14 dB. Objetivo:
%  achar o SNR minimo que garante a identificacao dos tres sinais.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

fs = 1000; p = 35; N = 256; freqs = [240 260 350];
SNRs = [-6 -10 -12 -14];

figure('visible','off'); set(gcf,'Position',[100 100 1000 720]);
for k = 1:4
  randn('state',6); rand('state',6);
  x = sig_noise(freqs, SNRs(k), N);
  [PS,f] = pmcov(x, p, 1024, fs);
  subplot(2,2,k);
    plot(f,PS,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('pmcov (p=35), N=256, SNR = %d dB', SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  [~,loc] = findpeaks(PS(f<=500),'MinPeakHeight',0.3*max(PS(f<=500)));
  printf('5.6 | SNR=%4d dB | picos: %s  (reais: 240 260 350)\n', SNRs(k), mat2str(round(f(loc)')));
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_06.png'), '-dpng','-r120');
