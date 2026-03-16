function [y_quant, erro] = quantizacao_sinal(y, n_bits)
    % Função para simular quantização de um sinal
    % n_bits: Resolução do conversor
    
    V_max = max(y);
    V_min = min(y);
    L = 2^n_bits; % Níveis de quantização
    
    % Cálculo do intervalo de quantização (q)
    q = (V_max - V_min) / (L - 1);
    
    % Processo de quantização: normaliza, arredonda e desnormaliza
    y_quant = round((y - V_min) / q) * q + V_min;
    
    % O erro de quantização é a diferença entre o original e o quantizado
    erro = y - y_quant;
end