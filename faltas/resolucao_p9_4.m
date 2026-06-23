% resolucao_p9_4.m - Loop automatizado para o acs_CO2.m
clear; clc; close all;

betas_test = [0, 0.1, 0.3, 0.5, 0.8, 1.0];
var_fetco2 = zeros(length(betas_test), 1);
var_fico2 = zeros(length(betas_test), 1);

% Fixando os outros parâmetros pedidos pelo modelo
alpha = 1; 
lambda = 0.98;

for i = 1:length(betas_test)
    beta = betas_test(i); % Injeta o beta atual
    
    % Executa o script do livro silenciosamente
    acs_CO2; 
    
    % As saídas DFetCO2 e DFICO2 ficam no workspace após o script rodar
    % Pegamos apenas a segunda metade (fase adaptativa, N/2+1 até N)
    fase_adaptativa = (N/2 + 1):N;
    var_fetco2(i) = var(DFetCO2(fase_adaptativa));
    var_fico2(i) = var(DFICO2(fase_adaptativa));
end

% Plot do Gráfico Real do Trade-off
figure;
subplot(2,1,1);
plot(betas_test, var_fetco2, '-bo', 'LineWidth', 2);
ylabel('Variância de F_{ETCO2}');
title('Trade-off do Controle Adaptativo (P9.4)');
grid on;

subplot(2,1,2);
plot(betas_test, var_fico2, '-ro', 'LineWidth', 2);
ylabel('Variância de F_{ICO2}');
xlabel('Fator de Peso \beta');
grid on;