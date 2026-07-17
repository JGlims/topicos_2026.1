% =====================================================================
%  Problema 5.5 - efeito do COMPRIMENTO do sinal sobre a resolucao
%  espectral com metodos AR. Tres senoides: duas proximas (240 e 260 Hz)
%  e uma distante (350 Hz), com SNR = -8 dB. Usa o metodo da COVARIANCIA
%  MODIFICADA (pmcov) com ordem 35, varrendo comprimentos N = 64, 128,
%  256 e 512. Objetivo: achar o comprimento minimo que garante a
%  identificacao dos tres sinais.
%
%  (pmcov nao existe no pacote signal do Octave; usamos a implementacao
%   propria pmcov.m - metodo forward-backward de covariancia modificada.)
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

fs = 1000; p = 35; freqs = [240 260 350]; SNR = -8;
Ns = [64 128 256 512];

figure('visible','off'); set(gcf,'Position',[100 100 1000 720]);
for k = 1:4
  randn('state',3); rand('state',3);          % mesma semente -> comparacao justa
  x = sig_noise(freqs, SNR, Ns(k));
  [PS,f] = pmcov(x, p, 1024, fs);
  subplot(2,2,k);
    plot(f,PS,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('pmcov (p=35), N = %d', Ns(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  [~,loc] = findpeaks(PS(f<=500),'MinPeakHeight',0.3*max(PS(f<=500)));
  printf('5.5 | N=%3d | picos: %s  (reais: 240 260 350)\n', Ns(k), mat2str(round(f(loc)')));
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_05.png'), '-dpng','-r120');
