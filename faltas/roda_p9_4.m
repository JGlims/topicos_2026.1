% roda_p9_4.m - Loop automatizado para o acs_co2.m
betas_test = [0, 0.1, 0.3, 0.5, 0.8, 1.0];
var_fetco2 = zeros(length(betas_test), 1);
var_fico2 = zeros(length(betas_test), 1);

% Parâmetros fixos para não quebrar o script original
alpha = 1; 
lambda = 0.98; 

disp('--- Resolvendo P9.4: Simulando Controle de CO2 ---');
for i = 1:length(betas_test)
    beta = betas_test(i); 
    
    acs_co2; % Roda o script oficial com o nome corrigido em minúsculas
    
    fase_adaptativa = (N/2 + 1):N;
    var_fetco2(i) = var(DFetCO2(fase_adaptativa));
    var_fico2(i) = var(DFICO2(fase_adaptativa));
end

figure(3);
subplot(2,1,1);
plot(betas_test, var_fetco2, '-bo', 'LineWidth', 2);
ylabel('Var(F_{ETCO2})'); title('P9.4 - Trade-off do Controle Adaptativo'); grid on;
subplot(2,1,2);
plot(betas_test, var_fico2, '-ro', 'LineWidth', 2);
ylabel('Var(F_{ICO2})'); xlabel('Fator de Peso \beta'); grid on;