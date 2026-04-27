% Disciplina: Topicos em Engenharia (ENE0332) - 2026.1
% Algoritmo para Tarefa 2: Deteccao de Picos, RRI e HRV (VERSAO FLAT - A PROVA DE FALHAS)
% Alunos: Joao Gabriel Melo de Lima e Gabriel Roberto de Queiroz

clc; clear; close all;

% --- 1. PARAMETROS GERAIS ---
Fs = 250; 
tempo_segundos = 5 * 60; 
amostras_desejadas = tempo_segundos * Fs; 
t = (0:amostras_desejadas-1) / Fs;

disp('Iniciando processamento...');

% =========================================================================
% PACIENTE JOVEM (f2y03)
% =========================================================================
disp('Lendo Paciente Jovem...');
fid_j = fopen('f2y03.dat', 'r');
if fid_j == -1
    error('ERRO FATAL: Nao achei o f2y03.dat. O Octave esta na pasta certa?');
end
dados_raw_j = fread(fid_j, inf, 'int16');
fclose(fid_j);

% Ajuste seguro de matriz
amostras_disp_j = floor(length(dados_raw_j) / 3);
amostras_j = min(amostras_desejadas, amostras_disp_j);
dados_j = reshape(dados_raw_j(1:3*amostras_j), 3, amostras_j);

resp_j = dados_j(1, :) / 1000;
ecg_j  = dados_j(2, :) / 200;
bp_j   = dados_j(3, :) / 1;

% Deteccao Nativa de Picos (Jovem)
threshold_j = mean(ecg_j) + 1.5 * std(ecg_j); 
min_dist = round(Fs * 0.4); 
locs_j = []; pks_j = [];

for i = 2:(length(ecg_j)-1)
    if ecg_j(i) > threshold_j && ecg_j(i) >= ecg_j(i-1) && ecg_j(i) > ecg_j(i+1)
        if isempty(locs_j) || (i - locs_j(end)) >= min_dist
            locs_j(end+1) = i;
            pks_j(end+1) = ecg_j(i);
        elseif ecg_j(i) > pks_j(end)
            locs_j(end) = i;
            pks_j(end) = ecg_j(i);
        end
    end
end

% Construcao da serie RRI (Jovem)
tempo_picos_j = t(locs_j);
RRI_j = diff(tempo_picos_j);
tempo_RRI_j = tempo_picos_j(2:end);

RRI_ms_j = RRI_j * 1000;
sdnn_j = std(RRI_ms_j);
rmssd_j = sqrt(mean(diff(RRI_ms_j).^2));
pNN50_j = sum(abs(diff(RRI_ms_j)) > 50) / length(RRI_ms_j) * 100;

% =========================================================================
% PACIENTE IDOSO (f2o03)
% =========================================================================
disp('Lendo Paciente Idoso...');
fid_i = fopen('f2o03.dat', 'r');
if fid_i == -1
    error('ERRO FATAL: Nao achei o f2o03.dat. O Octave esta na pasta certa?');
end
dados_raw_i = fread(fid_i, inf, 'int16');
fclose(fid_i);

% Ajuste seguro de matriz
amostras_disp_i = floor(length(dados_raw_i) / 3);
amostras_i = min(amostras_desejadas, amostras_disp_i);
dados_i = reshape(dados_raw_i(1:3*amostras_i), 3, amostras_i);

resp_i = dados_i(1, :) / 1000;
ecg_i  = dados_i(2, :) / 200;
bp_i   = dados_i(3, :) / 1;

% Deteccao Nativa de Picos (Idoso)
threshold_i = mean(ecg_i) + 1.5 * std(ecg_i); 
locs_i = []; pks_i = [];

for i = 2:(length(ecg_i)-1)
    if ecg_i(i) > threshold_i && ecg_i(i) >= ecg_i(i-1) && ecg_i(i) > ecg_i(i+1)
        if isempty(locs_i) || (i - locs_i(end)) >= min_dist
            locs_i(end+1) = i;
            pks_i(end+1) = ecg_i(i);
        elseif ecg_i(i) > pks_i(end)
            locs_i(end) = i;
            pks_i(end) = ecg_i(i);
        end
    end
end

% Construcao da serie RRI (Idoso)
tempo_picos_i = t(locs_i);
RRI_i = diff(tempo_picos_i);
tempo_RRI_i = tempo_picos_i(2:end);

RRI_ms_i = RRI_i * 1000;
sdnn_i = std(RRI_ms_i);
rmssd_i = sqrt(mean(diff(RRI_ms_i).^2));
pNN50_i = sum(abs(diff(RRI_ms_i)) > 50) / length(RRI_ms_i) * 100;

% =========================================================================
% IMPRESSAO DOS RESULTADOS NO CONSOLE
% =========================================================================
fprintf('\n=========================================\n');
fprintf('=== RESULTADOS HRV (JANELA 5 MINUTOS) ===\n');
fprintf('=========================================\n');
fprintf('Paciente JOVEM:\n SDNN: %.2f ms | RMSSD: %.2f ms | pNN50: %.2f%%\n', sdnn_j, rmssd_j, pNN50_j);
fprintf('Paciente IDOSO:\n SDNN: %.2f ms | RMSSD: %.2f ms | pNN50: %.2f%%\n', sdnn_i, rmssd_i, pNN50_i);
fprintf('=========================================\n');

% =========================================================================
% PLOTAGEM DOS GRAFICOS
% =========================================================================
disp('Gerando graficos...');

% Figura 1: Jovem
figure('Name', 'Paciente Jovem', 'Position', [50, 50, 800, 600]);
subplot(4,1,1); plot(t(1:amostras_j), resp_j, 'g'); title('Paciente jovem (28 anos) - Respiracao'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(amostras_j)]);
subplot(4,1,2); plot(t(1:amostras_j), ecg_j, 'r'); hold on; plot(t(locs_j), pks_j, '*k'); title('Paciente jovem (28 anos) - ECG'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(amostras_j)]); hold off;
subplot(4,1,3); plot(t(1:amostras_j), bp_j, 'm'); title('Paciente jovem (28 anos) - Pressao Arterial'); xlabel('Tempo (s)'); ylabel('Pressao (mmHg)'); grid on; xlim([0, t(amostras_j)]);
subplot(4,1,4); plot(tempo_RRI_j, RRI_j, '-ob'); title('Paciente jovem (28 anos) - RRIs'); xlabel('Tempo (s)'); ylabel('RRI (s)'); grid on; xlim([0, t(amostras_j)]);
if exist('sgtitle') == 5, sgtitle('Sinais Corrigidos e RRI - Jovem'); end

% Figura 2: Idoso
figure('Name', 'Paciente Idoso', 'Position', [900, 50, 800, 600]);
subplot(4,1,1); plot(t(1:amostras_i), resp_i, 'g'); title('Paciente idoso (85 anos) - Respiracao'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(amostras_i)]);
subplot(4,1,2); plot(t(1:amostras_i), ecg_i, 'r'); hold on; plot(t(locs_i), pks_i, '*k'); title('Paciente idoso (85 anos) - ECG'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(amostras_i)]); hold off;
subplot(4,1,3); plot(t(1:amostras_i), bp_i, 'm'); title('Paciente idoso (85 anos) - Pressao Arterial'); xlabel('Tempo (s)'); ylabel('Pressao (mmHg)'); grid on; xlim([0, t(amostras_i)]);
subplot(4,1,4); plot(tempo_RRI_i, RRI_i, '-ob'); title('Paciente idoso (85 anos) - RRIs'); xlabel('Tempo (s)'); ylabel('RRI (s)'); grid on; xlim([0, t(amostras_i)]);
if exist('sgtitle') == 5, sgtitle('Sinais Corrigidos e RRI - Idoso'); end

disp('Concluido com sucesso!');