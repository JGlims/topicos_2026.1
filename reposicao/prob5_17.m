% =====================================================================
%  Problema 5.17 - o arquivo spectral_analysis6.mat contem um sinal x com
%  UM unico componente de banda larga (fs = 1 kHz), frequencia central de
%  250 Hz e largura de banda de 300 Hz. Compara-se o espectro AR com
%  ordens p = 3, 16, 32 e 64.
%
%  Observacao esperada: a ordem mais baixa localiza bem a frequencia
%  central, mas representa a parte plana da banda como uma serie de picos;
%  ordens maiores tem mais picos e representam melhor a regiao plana.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

S = load(fullfile(fileparts(mfilename('fullpath')),'spectral_analysis6.mat'));
x = S.x(:); fs = 1000; N = length(x);
orders = [3 16 32 64];

figure('visible','off'); set(gcf,'Position',[100 100 1000 720]);
for k = 1:4
  [PS,f] = pyulear(x, orders(k), 1024, fs);
  subplot(2,2,k);
    plot(f,PS,'k','LineWidth',1); xlim([0 500]);
    title(sprintf('AR pyulear (p = %d)', orders(k)));
    xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
end
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_17.png'), '-dpng','-r120');
printf('5.17 | componente de banda larga centrado em ~250 Hz (BW ~300 Hz)\n');
