function [Pxx, f] = pmcov(x, p, nfft, fs)
% PMCOV  Estimativa de densidade espectral de potencia pelo metodo AR de
%        COVARIANCIA MODIFICADA (forward-backward least squares).
%
%   [Pxx, f] = pmcov(x, p, nfft, fs)
%
%   Reimplementacao compativel com a funcao pmcov da Signal Processing
%   Toolbox do MATLAB, necessaria porque o pacote "signal" do Octave nao
%   fornece pmcov/pcov. O metodo estima os coeficientes AR minimizando a
%   soma dos erros de predicao para frente (forward) e para tras (backward),
%   que e exatamente o metodo da covariancia modificada (Marple/Kay).
%
%   Entradas:
%     x    - vetor do sinal
%     p    - ordem do modelo AR
%     nfft - numero de pontos da FFT (resolucao em frequencia)
%     fs   - frequencia de amostragem (Hz)
%
%   Saidas:
%     Pxx  - densidade espectral de potencia (unilateral)
%     f    - vetor de frequencias (Hz), de 0 a fs/2
%
%   Referencia: Semmlow & Griffel, "Biosignal and Medical Image
%   Processing", 3a ed., Cap. 5 (metodos parametricos AR).

  x = x(:);                 % garante vetor coluna
  N = length(x);
  if nargin < 3 || isempty(nfft), nfft = 256; end
  if nargin < 4 || isempty(fs),   fs   = 1;   end

  % ----- Monta as equacoes de predicao forward e backward -----
  % Numero de equacoes de cada tipo
  Ne = N - p;

  % Matriz de dados (forward + backward) e vetor alvo
  Phi = zeros(2*Ne, p);
  y   = zeros(2*Ne, 1);

  % Equacoes forward:  x(n) ~ sum_{k=1..p} c_k x(n-k),  n = p+1..N
  for i = 1:Ne
    n = p + i;
    Phi(i, :) = x(n-1:-1:n-p).';   % [x(n-1) x(n-2) ... x(n-p)]
    y(i)      = x(n);
  end

  % Equacoes backward: x(n) ~ sum_{k=1..p} c_k x(n+k),  n = 1..N-p
  for i = 1:Ne
    n = i;
    Phi(Ne+i, :) = x(n+1:n+p).';   % [x(n+1) x(n+2) ... x(n+p)]
    y(Ne+i)      = x(n);
  end

  % ----- Solucao por minimos quadrados -----
  c = Phi \ y;                     % coeficientes preditores
  a = [1; -c];                     % polinomio AR: A(z) = 1 - sum c_k z^-k

  % Variancia do ruido de excitacao (erro medio quadratico forward-backward)
  res = y - Phi*c;
  e   = (res' * res) / length(res);

  % ----- Densidade espectral de potencia a partir dos coeficientes AR -----
  A = fft(a, nfft);
  Pxx_full = e ./ (fs * abs(A).^2);    % PSD bilateral

  % Converte para unilateral (0 .. fs/2)
  Nhalf = floor(nfft/2) + 1;
  Pxx = Pxx_full(1:Nhalf);
  if rem(nfft,2)                        % nfft impar: nao dobrar o ultimo bin
    Pxx(2:end)     = 2*Pxx(2:end);
  else                                  % nfft par: nao dobrar DC nem Nyquist
    Pxx(2:end-1)   = 2*Pxx(2:end-1);
  end

  f = (0:Nhalf-1).' * (fs/nfft);
end
