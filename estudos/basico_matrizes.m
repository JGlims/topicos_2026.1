% basico_matrizes.m - Explorando o "Matrix Laboratory"
% Foco: Operações elemento-a-elemento vs Álgebra Linear

% 1. Criação e Indexação [cite: 434, 845]
A = [1 2 3 4; 5 6 7 8; 10 20 30 40; 50 60 70 80];
primeira_linha = A(1, :); % O ':' pega todas as colunas [cite: 859]
sub_matriz = A(2:3, 2:3); 

% 2. O temido Operador Ponto [cite: 718, 737, 757]
% Multiplicação matricial (Álgebra Linear)
B = [1 2; 3 4];
C = B * B; 

% Multiplicação elemento-a-elemento (Processamento de Sinais)
% Essencial para aplicar ganhos ou janelamento em sinais
D = B .* B; 

fprintf('Matriz A original:\n'); disp(A);
fprintf('Resultado de B * B (Matricial):\n'); disp(C);
fprintf('Resultado de B .* B (Elemento-a-elemento):\n'); disp(D);

% 3. Buscando dados específicos [cite: 870, 923]
indices = find(A > 20); % Onde o sinal passa de um limiar
fprintf('Índices onde A > 20: %s\n', mat2str(indices));