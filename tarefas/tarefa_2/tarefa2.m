% Disciplina: Topicos em Engenharia (ENE0332) - 2026.1
% Algoritmo para Tarefa 2: Deteccao de Picos R, RRI e HRV
% Alunos: Joao Gabriel Melo de Lima (241032617) e Gabriel Roberto de Queiroz
% Pacientes 3 (f2y03 e f2o03)

clc; clear; close all;

% Forca o carregamento do pacote de processamento de sinais (Resolve o erro do findpeaks)
pkg load signal;

% --- 1. PARAMETROS GERAIS ---
Fs = 250; % Frequencia de amostragem em Hz
tempo_segundos = 5 * 60; % 5 minutos (trecho sem ectopicos)
amostras = tempo_segundos * Fs; % 75.000 amostras

t = (0:amostras-1) / Fs;

% =========================================================================
% PACIENTE JOVEM (f2y03 - Feminina, 28 anos)
% =========================================================================
fid_j = fopen('f2y03.dat', 'r');
if fid_j == -1
    error('ERRO: Nao achei o arquivo "f2y03.dat". Verifique se o Octave esta na pasta certa!');
end
dados_j = fread(fid_j, [3, amostras], 'int16'); 
fclose(fid_j);

% Demultiplexacao e Ganhos
resp_j = dados_j(1, :) / 1000;
ecg_j  = dados_j(2, :) / 200;
bp_j   = dados_j(3, :) / 1;

% Deteccao de picos R (Aspas simples e threshold levemente menor para garantir)
[pks_j, locs_j] = findpeaks(ecg_j, 'MinPeakHeight', 0.3, 'MinPeakDistance', Fs * 0.4);

% Construcao da serie RRI
tempo_picos_j = t(locs_j);
RRI_j = diff(tempo_picos_j);
tempo_RRI_j = tempo_picos_j(2:end);

% Calculo de Metricas HRV
RRI_ms_j = RRI_j * 1000;
sdnn_j = std(RRI_ms_j);
rmssd_j = sqrt(mean(diff(RRI_ms_j).^2));
pNN50_j = sum(abs(diff(RRI_ms_j)) > 50) / length(RRI_ms_j) * 100;

% =========================================================================
% PACIENTE IDOSO (f2o03 - Feminina, 85 anos)
% =========================================================================
fid_i = fopen('f2o03.dat', 'r');
if fid_i == -1
    error('ERRO: Nao achei o arquivo "f2o03.dat". Verifique se o Octave esta na pasta certa!');
end
dados_i = fread(fid_i, [3, amostras], 'int16'); 
fclose(fid_i);

% Demultiplexacao e Ganhos
resp_i = dados_i(1, :) / 1000;
ecg_i  = dados_i(2, :) / 200;
bp_i   = dados_i(3, :) / 1;

% Deteccao de picos R
[pks_i, locs_i] = findpeaks(ecg_i, 'MinPeakHeight', 0.3, 'MinPeakDistance', Fs * 0.4);

% Construcao da serie RRI
tempo_picos_i = t(locs_i);
RRI_i = diff(tempo_picos_i);
tempo_RRI_i = tempo_picos_i(2:end);

% Calculo de Metricas HRV
RRI_ms_i = RRI_i * 1000;
sdnn_i = std(RRI_ms_i);
rmssd_i = sqrt(mean(diff(RRI_ms_i).^2));
pNN50_i = sum(abs(diff(RRI_ms_i)) > 50) / length(RRI_ms_i) * 100;

% =========================================================================
% IMPRESSAO DOS RESULTADOS NO CONSOLE
% =========================================================================
fprintf('\n=== RESULTADOS HRV (JANELA 5 MINUTOS) ===\n');
fprintf('Paciente JOVEM:\n SDNN: %.2f ms | RMSSD: %.2f ms | pNN50: %.2f%%\n', sdnn_j, rmssd_j, pNN50_j);
fprintf('Paciente IDOSO:\n SDNN: %.2f ms | RMSSD: %.2f ms | pNN50: %.2f%%\n', sdnn_i, rmssd_i, pNN50_i);

% =========================================================================
% PLOTAGEM EXIGIDA PELA TAREFA
% =========================================================================
% Figura 1: Jovem
figure('Name', 'Paciente Jovem - Sinais Corrigidos', 'Position', [100, 100, 800, 600]);
subplot(4,1,1); plot(t, resp_j, 'g'); title('Paciente jovem (feminina, 28 anos) - Sinal de Respiracao'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(end)]);
subplot(4,1,2); plot(t, ecg_j, 'r'); hold on; plot(tempo_picos_j, pks_j, '*k'); title('Paciente jovem (feminina, 28 anos) - Sinal de ECG'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(end)]); hold off;
subplot(4,1,3); plot(t, bp_j, 'm'); title('Paciente jovem (feminina, 28 anos) - Sinal de Pressao Arterial'); xlabel('Tempo (s)'); ylabel('Pressao (mmHg)'); grid on; xlim([0, t(end)]);
subplot(4,1,4); plot(tempo_RRI_j, RRI_j, '-ob'); title('Paciente jovem (feminina, 28 anos) - RRIs'); xlabel('Tempo (s)'); ylabel('RRI (s)'); grid on; xlim([0, t(end)]);
sgtitle('Sinais Corrigidos e Serie RRI - Paciente Jovem');

% Figura 2: Idoso
figure('Name', 'Paciente Idoso - Sinais Corrigidos', 'Position', [150, 150, 800, 600]);
subplot(4,1,1); plot(t, resp_i, 'g'); title('Paciente idoso (feminina, 85 anos) - Sinal de Respiracao'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(end)]);
subplot(4,1,2); plot(t, ecg_i, 'r'); hold on; plot(tempo_picos_i, pks_i, '*k'); title('Paciente idoso (feminina, 85 anos) - Sinal de ECG'); xlabel('Tempo (s)'); ylabel('Amplitude (mV)'); grid on; xlim([0, t(end)]); hold off;
subplot(4,1,3); plot(t, bp_i, 'm'); title('Paciente idoso (feminina, 85 anos) - Sinal de Pressao Arterial'); xlabel('Tempo (s)'); ylabel('Pressao (mmHg)'); grid on; xlim([0, t(end)]);
subplot(4,1,4); plot(tempo_RRI_i, RRI_i, '-ob'); title('Paciente idoso (feminina, 85 anos) - RRIs'); xlabel('Tempo (s)'); ylabel('RRI (s)'); grid on; xlim([0, t(end)]);
sgtitle('Sinais Corrigidos e Serie RRI - Paciente Idoso');