% P8.2 - Estimação R, L, C
pkg load control;
global Pao Flow t;

load('data_fo.mat'); % O arquivo DEVE estar no diretorio atual
dt = 0.01; t = (0:length(Pao)-1)*dt;

% Chutes iniciais: [R, L, C]
chutes = [1.0, 0.01, 0.1; 
          2.0, 0.02, 0.05; 
          1.5, 0.005, 0.2];

for i = 1:size(chutes, 1)
    theta_init = chutes(i, :);
    [theta_opt, J_min] = fminsearch('fn_rlc', theta_init);
    fprintf('Chute %d: R=%.4f, L=%.4f, C=%.4f | J=%.4f\n', i, theta_opt(1), theta_opt(2), theta_opt(3), J_min);
end