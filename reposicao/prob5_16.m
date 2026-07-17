% =====================================================================
%  Problema 5.16 - o arquivo spectral_analysis5.mat contem um sinal x com
%  DOIS componentes de banda larga (fs = 1 kHz), com frequencias centrais
%  em 150 e 350 Hz e largura de banda de 100 Hz cada. Compara-se o
%  espectro produzido pelos metodos AR (p = 4..8, aqui p = 6) e de Welch.
%  Repete-se truncando o sinal para N = 126 pontos. Para o Welch usa-se
%  janela de 256 (sinal longo) ou do tamanho do sinal (N = 126).
%
%  Observacao esperada: o Welch mostra melhor as LARGURAS de banda (ao
%  menos no sinal longo), enquanto o AR mostra melhor as frequencias
%  CENTRAIS, principalmente no sinal curto.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));

S = load(fullfile(fileparts(mfilename('fullpath')),'spectral_analysis5.mat'));
x = S.x(:); fs = 1000; p = 6;
xshort = x(1:126);

figure('visible','off'); set(gcf,'Position',[100 100 1000 720]);

% ----- Sinal completo -----
[PSar,f1]  = pyulear(x, p, 1024, fs);
[PSw, f2]  = pwelch(x, 256, [], [], fs);
subplot(2,2,1); plot(f1,PSar,'k','LineWidth',1); xlim([0 500]);
  title(sprintf('AR pyulear (p=%d) - sinal completo (N=%d)', p, numel(x)));
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
subplot(2,2,2); plot(f2,PSw,'k','LineWidth',1); xlim([0 500]);
  title('Welch (janela 256) - sinal completo');
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;

% ----- Sinal truncado N = 126 -----
[PSar2,f3] = pyulear(xshort, p, 1024, fs);
[PSw2, f4] = pwelch(xshort, 126, [], [], fs);
subplot(2,2,3); plot(f3,PSar2,'k','LineWidth',1); xlim([0 500]);
  title(sprintf('AR pyulear (p=%d) - N = 126', p));
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
subplot(2,2,4); plot(f4,PSw2,'k','LineWidth',1); xlim([0 500]);
  title('Welch (janela 126) - N = 126');
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;

print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_16.png'), '-dpng','-r120');
printf('5.16 | componentes de banda larga centrados em ~150 e ~350 Hz (BW ~100 Hz)\n');
