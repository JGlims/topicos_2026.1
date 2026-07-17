% =====================================================================
%  Problema 5.1 - Semmlow, "Biosignal and Medical Image Processing", Cap.5
%  ENE0332 - Topicos em Engenharia | Reposicao de faltas
%
%  Enunciado: usar as equacoes de Yule-Walker (Exemplo 5.1) para achar o
%  espectro do sinal do Exemplo 5.1 (quatro senoides em 100, 240, 280 e
%  400 Hz enterradas em ruido, SNR = -12 dB, N = 1024), porem com um
%  modelo de ordem MAIS ALTA para resolver melhor as quatro frequencias.
%  Comparar o espectro AR com o espectro classico de Fourier (pwelch com
%  janela do mesmo tamanho do sinal).
%
%  Obs.: a funcao pyulear implementa exatamente as equacoes normais de
%  Yule-Walker do Exemplo 5.1 (de forma numericamente estavel), por isso
%  e usada aqui como o "metodo Yule-Walker".
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));
randn('state',1); rand('state',1);     % semente fixa (reprodutibilidade)

fs  = 1000;                 % frequencia de amostragem (Hz) - assumida por sig_noise
N   = 1024;                 % comprimento do sinal
SNR = -12;                  % relacao sinal-ruido (dB)
p   = 40;                   % ordem AR alta para resolver as 4 frequencias

x = sig_noise([100 240 280 400], SNR, N);   % gera o sinal de teste

% ----- Espectro AR pelo metodo de Yule-Walker -----
[PS_ar, f_ar] = pyulear(x, p, N, fs);

% ----- Espectro classico de Fourier (pwelch, janela = tamanho do sinal) -----
[PS_ft, f_ft] = pwelch(x, N, [], [], fs);

% ----- Figura -----
figure('visible','off'); set(gcf,'Position',[100 100 900 640]);
subplot(2,1,1);
  plot(f_ar, PS_ar, 'k','LineWidth',1); xlim([0 500]);
  title('Problema 5.1 - AR Yule-Walker (p = 40)');
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
subplot(2,1,2);
  plot(f_ft, PS_ft, 'k','LineWidth',1); xlim([0 500]);
  title('Fourier classico (pwelch, janela = N)');
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on;
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_01.png'), '-dpng','-r120');

% ----- Localiza os picos principais do espectro AR -----
[~,loc] = findpeaks(PS_ar(f_ar<=500), 'MinPeakHeight', 0.3*max(PS_ar(f_ar<=500)));
fpk = round(f_ar(loc)');
printf('5.1 | ordem AR = %d | picos AR (Hz): %s\n', p, mat2str(fpk));
printf('5.1 | frequencias verdadeiras: 100 240 280 400 Hz\n');
