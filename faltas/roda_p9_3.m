% roda_p9_3.m - Adaptação do LMS e RLS Variante no Tempo
pkg load signal;

N = 500; randn('seed', 42);
u_raw = randn(N, 1); 
u = [u_raw, [0; u_raw(1:end-1)]]; 
y = zeros(N, 1);

% Sistema muda bruscamente em n=250!
for n = 1:N
    if n < 250
        y(n) = 0.5 * u(n, 1) - 0.3 * u(n, 2) + 0.05 * randn();
    else
        y(n) = 0.2 * u(n, 1) + 0.7 * u(n, 2) + 0.05 * randn();
    end
end

% Setando variáveis pro script do Khoo
lambda = 0.98; np = 2; 
disp('--- Resolvendo P9.3: Chamando TVmodel_RLS.m ---');
TVmodel_RLS; 

figure(2);
plot(1:N, theta(:, 1), 'b', 'LineWidth', 1.5); hold on;
plot(1:N, theta(:, 2), 'r', 'LineWidth', 1.5);
line([0 N], [0.5 0.5], 'Color', 'b', 'LineStyle', '--');
line([0 N], [-0.3 -0.3], 'Color', 'r', 'LineStyle', '--');
line([250 N], [0.2 0.2], 'Color', 'b', 'LineStyle', '--');
line([250 N], [0.7 0.7], 'Color', 'r', 'LineStyle', '--');
title('P9.3 - Rastreamento RLS Variante no Tempo');
xlabel('Instante n'); ylabel('Parâmetros');
legend('\theta_1 estimado', '\theta_2 estimado', 'Real'); grid on;