% =====================================================================
%  Problema 5.2 - efeito do nivel de ruido sobre a estimativa espectral.
%  Repete o Problema 5.1 (senoides em 100/240/280/400 Hz, N = 1024) porem
%  com SNR = -18 dB. Espera-se que, em geral, NAO seja possivel resolver
%  as quatro frequencias (rodar varias vezes revela a variabilidade dos
%  dados ruidosos). Compara AR (Yule-Walker) x Fourier.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));
randn('state',10); rand('state',10);

fs  = 1000; N = 1024; SNR = -18; p = 40;
x = sig_noise([100 240 280 400], SNR, N);

[PS_ar, f_ar] = pyulear(x, p, N, fs);
[PS_ft, f_ft] = pwelch(x, N, [], [], fs);

figure('visible','off'); set(gcf,'Position',[100 100 900 640]);
subplot(2,1,1);
  plot(f_ar, PS_ar, 'k','LineWidth',1); xlim([0 500]);
  title('Problema 5.2 - AR Yule-Walker (p = 40), SNR = -18 dB');
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
subplot(2,1,2);
  plot(f_ft, PS_ft, 'k','LineWidth',1); xlim([0 500]);
  title('Fourier classico (pwelch), SNR = -18 dB');
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_02.png'), '-dpng','-r120');

[~,loc] = findpeaks(PS_ar(f_ar<=500), 'MinPeakHeight', 0.3*max(PS_ar(f_ar<=500)));
fpk = round(f_ar(loc)');
printf('5.2 | SNR=-18 dB | picos AR (Hz): %s  (freq. reais: 100 240 280 400)\n', mat2str(fpk));
