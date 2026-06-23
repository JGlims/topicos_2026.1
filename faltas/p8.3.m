% P8.3 - Estimação de h(n) por Mínimos Quadrados
load('data_fo.mat');
dt = 0.01; N = length(Pao);
p = 50; % Número de pontos da resposta ao impulso

% Construindo a Matriz de Observação U
U = zeros(N, p);
for i = 1:p
    U(i:N, i) = Pao(1:N-i+1);
end
U = U * dt;

% Resolução da equação normal: h = inv(U' * U) * U' * Flow
R_uu = U' * U;
R_uy = U' * Flow;
h = R_uu \ R_uy; % Usamos a barra invertida (solucionador otimizado de sistemas lineares)

% Calculo da banda de erro
e = Flow - U * h;
sigma2 = (e' * e) / (N - 1);
var_h = diag(inv(R_uu)) * sigma2;
std_err = sqrt(var_h);

t_h = (0:p-1)*dt;
figure;
plot(t_h, h, 'k', 'LineWidth', 1.5); hold on;
plot(t_h, h + std_err, 'r--');
plot(t_h, h - std_err, 'r--');
title('Resposta ao Impulso Estimada (P8.3)');
xlabel('Tempo (s)'); ylabel('h(t)');