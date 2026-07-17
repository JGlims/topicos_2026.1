% =====================================================================
%  Problema 5.8 - o arquivo ar_compare.mat contem um sinal x com duas
%  senoides em 300 e 340 Hz mais ruido (fs = 1 kHz). Comparar a
%  capacidade dos metodos AR e de Fourier de identificar corretamente as
%  senoides, variando a ordem do modelo AR: p = 9, 15, 23 e 32. O metodo
%  de Fourier usa pwelch com janela do tamanho do sinal. Em cada ordem o
%  espectro AR e plotado ao lado do de Fourier.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

S = load(fullfile(fileparts(mfilename('fullpath')),'ar_compare.mat'));
x = S.x; fs = 1000; N = length(x);
orders = [9 15 23 32];

[PS_ft,f_ft] = pwelch(x, N, [], [], fs);   % Fourier (igual para todas as ordens)

figure('visible','off'); set(gcf,'Position',[100 100 1000 950]);
for k = 1:4
  [PS_ar,f_ar] = pmcov(x, orders(k), N, fs);
  subplot(4,2,2*k-1);
    plot(f_ar,PS_ar,'k','LineWidth',1); xlim([200 450]);
    title(sprintf('AR pmcov (p = %d)', orders(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  subplot(4,2,2*k);
    plot(f_ft,PS_ft,'k','LineWidth',1); xlim([200 450]);
    title('Fourier (pwelch, janela = N)');
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
  [~,la]=findpeaks(PS_ar(f_ar<=500),'MinPeakHeight',0.3*max(PS_ar(f_ar<=500)));
  printf('5.8 | p=%2d | picos AR: %s  (reais: 300 340)\n', orders(k), mat2str(round(f_ar(la)')));
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_08.png'), '-dpng','-r120');
