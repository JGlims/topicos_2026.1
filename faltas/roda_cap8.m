% roda_cap8.m - Solução P8.1, P8.2 e P8.3
pkg load control;
global Pao Flow t;
load('data_fo.mat');
dt = 0.01; t = (0:length(Pao)-1)' * dt;

disp('--- Resolvendo P8.2: Estimação via Simplex ---');
chute_inicial = [1.5, 0.01, 0.1]; % R, L, C
[theta_opt, J_min] = fminsearch('fn_rlc', chute_inicial);
fprintf('Parâmetros Estimados: R=%.4f, L=%.4f, C=%.4f | Erro J=%.4f\n\n', ...
        theta_opt(1), theta_opt(2), theta_opt(3), J_min);

disp('--- Resolvendo P8.3: Resposta ao Impulso via Mínimos Quadrados ---');
N = length(Pao); p = 50; U = zeros(N, p);
for i = 1:p
    U(i:N, i) = Pao(1:N-i+1);
end
U = U * dt;
h = (U' * U) \ (U' * Flow); % Solução da Equação Normal
t_h = (0:p-1)*dt;

figure(1);
plot(t_h, h, 'k', 'LineWidth', 2);
title('P8.3 - Resposta ao Impulso Estimada');
xlabel('Tempo (s)'); ylabel('Amplitude h(t)'); grid on;