% =====================================================================
%  Problema 5.14 - o arquivo filter_coeff1.mat contem os coeficientes a e
%  b de um filtro. Assumindo fs = 250 Hz, passa-se ruido gaussiano
%  (N = 2058) pelo filtro e estima-se o espectro de potencia da SAIDA por
%  um modelo AR. Com uma ordem BAIXA (que reduz picos espurios devido ao
%  ruido) determina-se o tipo de filtro e a(s) frequencia(s) de corte.
%  A regiao de passagem aparece como uma serie de picos no modelo AR.
% =====================================================================
pkg load signal
addpath(fileparts(mfilename('fullpath')));
randn('state',20); rand('state',20);

S = load(fullfile(fileparts(mfilename('fullpath')),'filter_coeff1.mat'));
b = S.b; a = S.a; fs = 250; N = 2058; p = 6;   % ordem AR baixa

x = randn(N,1);              % ruido gaussiano branco
y = filter(b, a, x);         % saida do filtro

% Resposta VERDADEIRA do filtro (referencia)
[H,fH] = freqz(b, a, 1024, fs);
magH2 = abs(H).^2;

% Espectro AR da saida (metodo Yule-Walker, ordem baixa)
[PS, f] = pyulear(y, p, 1024, fs);

figure('visible','off'); set(gcf,'Position',[100 100 1000 420]);
subplot(1,2,1);
  plot(fH, magH2, 'k','LineWidth',1);
  title('Resposta verdadeira do filtro |H(f)|^2 (referencia)');
  xlabel('Frequencia (Hz)'); ylabel('|H|^2'); grid on; xlim([0 fs/2]);
subplot(1,2,2);
  plot(f, PS, 'k','LineWidth',1);
  title(sprintf('Espectro AR da saida (pyulear, p=%d)', p));
  xlabel('Frequencia (Hz)'); ylabel('PS'); grid on; xlim([0 fs/2]);
print(gcf, fullfile(fileparts(mfilename('fullpath')),'figuras','prob5_14.png'), '-dpng','-r120');

% Estimativa da frequencia de corte (ponto de meia potencia) pelo AR
hp = max(PS)/2;
acima = PS >= hp;
fc_est = f(find(acima,1,'first'));           % primeiro cruzamento (passa-altas)
printf('5.14 | |H(0)|^2=%.3f  |H(fs/2)|^2=%.3f -> filtro PASSA-ALTAS\n', magH2(1), magH2(end));
printf('5.14 | frequencia de corte estimada (AR, meia-potencia) ~ %.0f Hz\n', fc_est);
