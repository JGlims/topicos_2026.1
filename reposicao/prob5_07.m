% =====================================================================
%  Problema 5.7 - compara o metodo AR com o metodo classico de Fourier
%  para detectar duas senoides proximas (240 e 280 Hz) em varios niveis
%  de ruido: SNR = -5, -12, -16 e -20 dB (N = 1024). O espectro AR usa a
%  covariancia modificada (pmcov) com ordem 25; o de Fourier usa pwelch
%  com janela do tamanho do sinal. Em cada nivel de SNR o espectro AR e
%  plotado ACIMA do de Fourier para facilitar a comparacao.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

fs = 1000; N = 1024; p = 25; freqs = [240 280];
SNRs = [-5 -12 -16 -20];

figure('visible','off'); set(gcf,'Position',[100 100 1000 950]);
for k = 1:4
  randn('state',7+k); rand('state',7+k);
  x = sig_noise(freqs, SNRs(k), N);
  [PS_ar,f_ar] = pmcov(x, p, N, fs);
  [PS_ft,f_ft] = pwelch(x, N, [], [], fs);
  subplot(4,2,2*k-1);
    plot(f_ar,PS_ar,'k','LineWidth',1); xlim([100 400]);
    title(sprintf('AR pmcov (p=25), SNR = %d dB', SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  subplot(4,2,2*k);
    plot(f_ft,PS_ft,'k','LineWidth',1); xlim([100 400]);
    title(sprintf('Fourier (pwelch), SNR = %d dB', SNRs(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  [~,la]=findpeaks(PS_ar(f_ar<=500),'MinPeakHeight',0.3*max(PS_ar(f_ar<=500)));
  printf('5.7 | SNR=%4d dB | picos AR: %s  (reais: 240 280)\n', SNRs(k), mat2str(round(f_ar(la)')));
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_07.png'), '-dpng','-r120');
