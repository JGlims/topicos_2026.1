% Base conceitual para P9.3 - TVmodel_RLS_Laguerre
% V = Respiração; SBP = Pressão Sistólica; RRI = Interv R-R

lambda = 0.98; % Fator de esquecimento
P = eye(2*q) * 100; % Inicialização da matriz de covariância do erro
Theta = zeros(2*q, 1); % Parâmetros das funções de base (c_RCC e c_ABR)

for n = max_delay+1:N
    % v_RCC e v_ABR são as saídas dos filtros de base de Laguerre
    X_n = [v_RCC(:, n); v_ABR(:, n)]; 
    
    % Predição a priori
    e_priori = dRRI(n) - Theta' * X_n;
    
    % Ganho de Kalman
    K = (P * X_n) / (lambda + X_n' * P * X_n);
    
    % Atualização
    Theta = Theta + K * e_priori;
    P = (1/lambda) * (P - K * X_n' * P);
end