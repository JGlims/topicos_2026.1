% P9.2 - Algoritmo LMS 
function [h_hist, y_hat, e] = lms_algorithm(x, y, M, mu)
    % x: input, y: output medido, M: ordem do filtro, mu: taxa de aprendizado
    N = length(x);
    h = zeros(M, 1); % Inicialização
    h_hist = zeros(M, N); % Para guardar a evolução
    y_hat = zeros(N, 1);
    e = zeros(N, 1);
    
    for n = M:N
        x_vec = x(n:-1:n-M+1); % Vetor de entrada no instante n
        y_hat(n) = h' * x_vec;
        e(n) = y(n) - y_hat(n);
        h = h + 2 * mu * e(n) * x_vec; % Equação de atualização (Fluxograma 9.5)
        h_hist(:, n) = h;
    end
end