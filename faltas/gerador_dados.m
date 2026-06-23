% gerador_dados.m
% Script para sintetizar a base de dados "data_fo.mat" do livro do Khoo
pkg load control;

% 1. Parâmetros reais do "paciente" (R, L, C)
R_true = 1.5; 
L_true = 0.01; 
C_true = 0.1;

dt = 0.01; 
t = (0:dt:25)'; % Vetor de tempo (25 segundos em coluna)
N = length(t);

% 2. Sinal de Pressão nas Vias Aéreas (Pao) - Ruído Branco
randn('seed', 42); % Seed fixa para reprodutibilidade
Pao = randn(N, 1);

% 3. Modelo Espaço de Estados (Mecânica Respiratória)
A = [0 1; -1/(L_true*C_true) -R_true/L_true];
B = [0; 1/L_true];
C_mat = [0 1]; % Queremos o fluxo de saída
D_mat = 0;

sys = ss(A, B, C_mat, D_mat);

% 4. Simulação do Fluxo com adição de ruído de medição
Flow = lsim(sys, Pao, t);
Flow = Flow + 0.02 * randn(N, 1);

% 5. Salva o arquivo no diretório atual para as listas P8.2 e P8.3 usarem
save('-mat', 'data_fo.mat', 'Pao', 'Flow', 't');
disp('>> SUCESSO: O arquivo data_fo.mat foi gerado na sua pasta local!');