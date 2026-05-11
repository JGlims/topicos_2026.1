% ex2_20.m - Ortogonalidade
clear; clc;

% Parâmetros
f = 1.5;    % Frequência (Hz)
Tt = 3;     % Tempo total (s)
Ts = 0.01;  % Passo de amostragem (s)
t = 0:Ts:Tt;

% Sinais
s1 = sin(2 * pi * f * t);
s2 = cos(2 * pi * f * t);

% Produto interno (soma do produto ponto a ponto)
resultado = sum(s1 .* s2);

fprintf('--- Exercício 2.20 ---\n');
fprintf('Resultado do produto interno: %.2e\n', resultado);

if abs(resultado) < 1e-10
    disp('Os sinais são ortogonais (produto interno aproximadamente zero).');
else
    disp('Os sinais não são estritamente ortogonais neste intervalo.');
end