% =====================================================================
%  Problema 5.4 - efeito do COMPRIMENTO do sinal sobre a deteccao de
%  senoides de banda estreita. Repete o Problema 5.1 (100/240/280/400 Hz)
%  com um segmento CURTO (N = 64), primeiro com SNR alto (0 dB) e depois
%  com SNR = -5 dB, notando a forte degradacao com o segmento curto.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

fs = 1000; N = 64;
freqs = [100 240 280 400];
p = 14;                 % ordem AR (limitada pelo N curto)

figure('visible','off'); set(gcf,'Position',[100 100 1000 700]);
SNRs = [0 -5]; seeds = [1 1];
for k = 1:2
  randn('state',seeds(k)); rand('state',seeds(k));
  x = sig_noise(freqs, SNRs(k), N);
  [PS_ar,f_ar] = pyulear(x, p, N, fs);
  [PS_ft,f_ft] = pwelch(x, N, [], [], fs);
  subplot(2,2,2*k-1);
    plot(f_ar,PS_ar,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('AR Yule-Walker (p=%d), N=64, SNR=%d dB', p, SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  subplot(2,2,2*k);
    plot(f_ft,PS_ft,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('Fourier (pwelch), N=64, SNR=%d dB', SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  [~,loc]=findpeaks(PS_ar(f_ar<=500),'MinPeakHeight',0.3*max(PS_ar(f_ar<=500)));
  printf('5.4 | N=64 SNR=%d dB | picos AR: %s  (reais: 100 240 280 400)\n', SNRs(k), mat2str(round(f_ar(loc)')));
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_04.png'), '-dpng','-r120');
