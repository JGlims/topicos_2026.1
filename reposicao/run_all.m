% =====================================================================
%  run_all.m - executa todos os problemas da reposicao e regenera as
%  figuras na pasta 'figuras'. Basta abrir esta pasta no Octave (ou
%  MATLAB) e rodar este arquivo.
%
%  ENE0332 - Topicos em Engenharia | Joao G. Melo Lima - 241032617
% =====================================================================
clc; close all;
here = fileparts(mfilename('fullpath'));
addpath(here);
if ~exist(fullfile(here,'figuras'),'dir'); mkdir(fullfile(here,'figuras')); end

probs = {'prob5_01','prob5_02','prob5_03','prob5_04', ...
         'prob5_05','prob5_06','prob5_07','prob5_08', ...
         'prob5_14','prob5_15','prob5_16','prob5_17'};

for i = 1:numel(probs)
  printf('\n========== Executando %s ==========\n', probs{i});
  run(fullfile(here, [probs{i} '.m']));
end
printf('\nConcluido. Figuras salvas em: %s\n', fullfile(here,'figuras'));
