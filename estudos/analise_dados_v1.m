% analise_dados_v1.m - Tratando NaNs e Estatística Básica
% Simulando dados ruidosos de biossinais [cite: 1783]

sinal_ruidoso = [3.2, NaN, 2.8, 4.0, NaN, 3.5, 3.1];
fprintf('Sinal original com NaNs: %s\n', mat2str(sinal_ruidoso));

% Removendo valores inválidos (Pruning) [cite: 1794, 1820]
sinal_limpo = sinal_ruidoso(~isnan(sinal_ruidoso));

media = mean(sinal_limpo); % [cite: 1860]
desvio = std(sinal_limpo);

fprintf('Sinal limpo: %s\n', mat2str(sinal_limpo));
fprintf('Média: %.2f | Desvio Padrão: %.2f\n', media, desvio);