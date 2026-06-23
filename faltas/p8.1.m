% P8.1 - Analise de Sensibilidade
pkg load control;

% Valores nominais
R_nom = 1.5; L_nom = 0.01; C_nom = 0.1;
dt = 0.01; t = 0:dt:25; N = length(t);

% Input: ruido branco (pseudorandomico)
randn('seed', 42); % Para reprodutibilidade
Pao = randn(N, 1); 

% Espaço de Estados do modelo RLC (x1 = Volume, x2 = Fluxo)
A_nom = [0 1; -1/(L_nom*C_nom) -R_nom/L_nom];
B_nom = [0; 1/L_nom];
C_mat = [0 1]; D_mat = 0; % Queremos observar o fluxo (x2)
sys_nom = ss(A_nom, B_nom, C_mat, D_mat);
y_nom = lsim(sys_nom, Pao, t);

variations = -0.5:0.1:0.5; % -50% a +50%
J_R = zeros(size(variations)); J_L = J_R; J_C = J_R;

for i = 1:length(variations)
    % Variando apenas R
    R_var = R_nom * (1 + variations(i));
    sys_R = ss([0 1; -1/(L_nom*C_nom) -R_var/L_nom], B_nom, C_mat, D_mat);
    J_R(i) = sum((y_nom - lsim(sys_R, Pao, t)).^2);
    
    % Variando apenas L
    L_var = L_nom * (1 + variations(i));
    sys_L = ss([0 1; -1/(L_var*C_nom) -R_nom/L_var], [0; 1/L_var], C_mat, D_mat);
    J_L(i) = sum((y_nom - lsim(sys_L, Pao, t)).^2);
    
    % Variando apenas C
    C_var = C_nom * (1 + variations(i));
    sys_C = ss([0 1; -1/(L_nom*C_var) -R_nom/L_nom], B_nom, C_mat, D_mat);
    J_C(i) = sum((y_nom - lsim(sys_C, Pao, t)).^2);
end

figure;
plot(variations*100, J_R, '-o', variations*100, J_L, '-^', variations*100, J_C, '-s');
xlabel('% de Mudança no parâmetro nominal');
ylabel('Mudança em J');
legend('R', 'L', 'C');
title('Análise de Sensibilidade - P8.1');