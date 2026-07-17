% =====================================================================
%  Problema 5.3 - resolucao de duas senoides proximas (200 e 230 Hz) em
%  ruido, com N = 256 pontos. Determinar a MELHOR ordem do modelo AR para
%  distinguir os dois picos com o minimo de picos espurios, usando o
%  metodo de BURG (pburg). Comparar com o espectro de Fourier (pwelch).
%  Repetir para SNR = -8 dB e SNR = -14 dB.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

fs = 1000; N = 256;
freqs = [200 230];
p = 25;                 % melhor ordem encontrada (varredura abaixo)

% ---- Varredura de ordem em SNR = -8 dB para justificar a escolha de p ----
randn('state',4); rand('state',4);
xscan = sig_noise(freqs, -8, N);
printf('5.3 | varredura de ordem (Burg), SNR=-8 dB:\n');
for pp = [8 11 15 20 25 30]
  [P,f] = pburg(xscan, pp, N, fs);
  [~,loc] = findpeaks(P(f<=500),'MinPeakHeight',0.3*max(P(f<=500)));
  printf('       p=%2d -> picos: %s\n', pp, mat2str(round(f(loc)')));
end

figure('visible','off'); set(gcf,'Position',[100 100 1000 700]);
SNRs = [-8 -14]; seeds = [4 4];
for k = 1:2
  randn('state',seeds(k)); rand('state',seeds(k));
  x = sig_noise(freqs, SNRs(k), N);
  [PS_ar,f_ar] = pburg(x, p, N, fs);
  [PS_ft,f_ft] = pwelch(x, N, [], [], fs);
  subplot(2,2,2*k-1);
    plot(f_ar,PS_ar,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('AR Burg (p=%d), SNR = %d dB', p, SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  subplot(2,2,2*k);
    plot(f_ft,PS_ft,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('Fourier (pwelch), SNR = %d dB', SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  [~,loc]=findpeaks(PS_ar(f_ar<=500),'MinPeakHeight',0.3*max(PS_ar(f_ar<=500)));
  printf('5.3 | SNR=%d dB | picos AR Burg (p=%d): %s  (reais: 200 230)\n', SNRs(k), p, mat2str(round(f_ar(loc)')));
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_03.png'), '-dpng','-r120');
