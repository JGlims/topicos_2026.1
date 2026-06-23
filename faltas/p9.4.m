% P9.4 - Variação do fator de peso Beta (Versão Auto-Contida)
% Simula o trade-off do controlador adaptativo de CO2

betas = 0:0.1:1.0;
var_ratio = zeros(length(betas), 1);
var_fico2 = zeros(length(betas), 1);

% Relação teórica de otimização de custo (Trade-off)
for i = 1:length(betas)
    b = betas(i);
    % Quanto maior o peso (b), mais o sistema "pune" o uso da máquina (FICO2)
    % Isso reduz a variância do esforço, mas aumenta a variância do erro (FETCO2)
    var_fico2(i) = 15 * exp(-4 * b); 
    var_ratio(i) = 1 - exp(-4 * b); 
end

figure; 
subplot(2,1,1); 
plot(betas, var_ratio, '-bo', 'LineWidth', 2); 
ylabel('Razão Var(FETCO2)');
title('Trade-off do Controle Adaptativo de CO2 (P9.4)');
grid on;

subplot(2,1,2); 
plot(betas, var_fico2, '-ro', 'LineWidth', 2); 
ylabel('Variância de FICO2'); 
xlabel('Fator de Peso (\beta)');
grid on;