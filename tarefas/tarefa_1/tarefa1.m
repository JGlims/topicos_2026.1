% tarefa1_corrigida.m - Lendo arquivos binários nativamente
clc; clear; close all;

Fs = 250; % Frequência de amostragem da base Fantasia
tempo_segundos = 5 * 60; % 5 minutos
amostras = tempo_segundos * Fs;

% Criando vetor de tempo
t = (0:amostras-1) / Fs;

% --- LENDO DADOS DO PACIENTE IDOSO (f2o08) ---
fid_i = fopen('f2o08.dat', 'r');
% Lê 2 linhas (Canais: Resp e ECG) e 'amostras' colunas em formato int16
dados_idoso = fread(fid_i, [2, amostras], 'int16'); 
fclose(fid_i);

% Separando os canais e ajustando ganho (aproximado para visualização)
resp_idoso = dados_idoso(1, :) / 1000; 
ecg_idoso = dados_idoso(2, :) / 200;   

% --- LENDO DADOS DO PACIENTE JOVEM (f2y08) ---
fid_j = fopen('f2y08.dat', 'r');
dados_jovem = fread(fid_j, [2, amostras], 'int16');
fclose(fid_j);

resp_jovem = dados_jovem(1, :) / 1000;
ecg_jovem = dados_jovem(2, :) / 200;

% --- PLOTANDO OS SINAIS ---
figure('Name', 'Tarefa 1 - Tópicos em Engenharia', 'Position', [100, 100, 1000, 600]);

% Paciente Jovem - ECG
subplot(2, 2, 1);
plot(t, ecg_jovem, 'b');
title('Paciente Jovem (f2y08) - ECG');
xlabel('Tempo (s)'); ylabel('Amplitude (mV)');
xlim([0 tempo_segundos]);

% Paciente Jovem - Respiração
subplot(2, 2, 2);
plot(t, resp_jovem, 'r');
title('Paciente Jovem (f2y08) - Respiração');
xlabel('Tempo (s)'); ylabel('Amplitude (u.a.)');
xlim([0 tempo_segundos]);

% Paciente Idoso - ECG
subplot(2, 2, 3);
plot(t, ecg_idoso, 'b');
title('Paciente Idoso (f2o08) - ECG');
xlabel('Tempo (s)'); ylabel('Amplitude (mV)');
xlim([0 tempo_segundos]);

% Paciente Idoso - Respiração
subplot(2, 2, 4);
plot(t, resp_idoso, 'r');
title('Paciente Idoso (f2o08) - Respiração');
xlabel('Tempo (s)'); ylabel('Amplitude (u.a.)');
xlim([0 tempo_segundos]);

% Salvando a imagem para usar no LaTeX
print('grafico_tarefa1.png', '-dpng', '-r300');
disp('Gráfico salvo com sucesso! Pode ir pro Overleaf.');