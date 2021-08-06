%% workflow_CalculateSignatures
% 
%   This script shows how to process the CAMELS struct files created with
%   saveCAMELSdata.m; specifically, it shows how to:
%   - load the struct files 
%   - use the time series to calculate some metrics (using the TOSSH toolbox). 
%
%   Note that this script requires sufficient RAM.
%
%   Copyright (C) 2021
%   This software is distributed under the GNU Public License Version 3.
%   See <https://www.gnu.org/licenses/gpl-3.0.en.html> for details.

%% load useful packages 

if (exist('BrewerMap') == 7)
    addpath(genpath('BrewerMap'));
else
    error('BrewerMap toolbox needed. Can be downloaded from https://github.com/DrosteEffect/BrewerMap and should be in a folder named BrewerMap in the same directory.')
end

if (exist('TOSSH') == 7)
    addpath(genpath('TOSSH'));
else
    error('TOSSH toolbox needed. Can be downloaded from https://github.com/TOSSHtoolbox and should be in a folder named TOSSH in the same directory.')
end

%% add paths

% working directory (important so that functions herein are called)
mydir = 'Signatures_large_scales';
addpath(genpath(mydir));

% figure path
fig_path = 'Signatures_large_scales/results/images';
results_path = 'Signatures_large_scales/results/';

%% load catchment data

CAMELS_US_data = load('CAMELS_Matlab/Data/CAMELS_US_data.mat');
CAMELS_GB_data = load('CAMELS_Matlab/Data/CAMELS_GB_data.mat');
CAMELS_AUS_data = load('CAMELS_Matlab/Data/CAMELS_AUS_data.mat');
CAMELS_BR_data = load('CAMELS_Matlab/Data/CAMELS_BR_data.mat');
% CAMELS_CL_data = load('CAMELS_Matlab/Data/CAMELS_CL_data.mat');

%% Calculate signatures using TOSSH
% We first merge the different CAMELS datasets and remove catchments that 
% do not meet our quality criteria (e.g. because of human impacts). We also 
% extract a few common attributes, such as aridity or mean precipitation.
% Note that the start of the water year differs for some of the countries. 
[t_mat, Q_mat, P_mat, PET_mat, attributes] = combineDataCAMELS(...
    CAMELS_US_data, CAMELS_GB_data, CAMELS_AUS_data, CAMELS_BR_data);

% We can use the calculation functions to calculate various signatures.
% Because the start of the water year differs in some of the countries, we
% split up the groundwater signature calculations by country. We can then 
% calculate the McMillan groundwater set.
% This might take a while...
isUS = (attributes.country == 1); % US (start 1 October)
CAMELS_signatures_Groundwater_US = calc_McMillan_Groundwater(...
    Q_mat(isUS), t_mat(isUS), P_mat(isUS), PET_mat(isUS), 'start_water_year', 10);
isGB = (attributes.country == 2); % GB (start 1 October)
CAMELS_signatures_Groundwater_GB = calc_McMillan_Groundwater(...
    Q_mat(isGB), t_mat(isGB), P_mat(isGB), PET_mat(isGB), 'start_water_year', 10);
isAUS = (attributes.country == 3); % AUS (start 1 April)
CAMELS_signatures_Groundwater_AUS = calc_McMillan_Groundwater(...
    Q_mat(isAUS), t_mat(isAUS), P_mat(isAUS), PET_mat(isAUS), 'start_water_year', 4);
isBR = (attributes.country == 4); % BR (start 1 September)
CAMELS_signatures_Groundwater_BR = calc_McMillan_Groundwater(...
    Q_mat(isBR), t_mat(isBR), P_mat(isBR), PET_mat(isBR), 'start_water_year', 9);
% We can now combine all groundwater signatures.
CAMELS_signatures_Groundwater = CatStructFields(1,...
    CAMELS_signatures_Groundwater_US,CAMELS_signatures_Groundwater_GB,...
    CAMELS_signatures_Groundwater_AUS,CAMELS_signatures_Groundwater_BR);

% We then calculate the McMillan overland flow set. 
% This might take a while...
CAMELS_signatures_OverlandFlow = calc_McMillan_OverlandFlow(...
    Q_mat, t_mat, P_mat, PET_mat);

% We can save the results as mat files which can be easily loaded. 
save(strcat(results_path,'CAMELS_signatures_Groundwater.mat'),...
    '-struct','CAMELS_signatures_Groundwater')
save(strcat(results_path,'CAMELS_signatures_OverlandFlow.mat'),...
    '-struct','CAMELS_signatures_OverlandFlow')

% Alternatively, we can save the results as txt file.
% writetable(struct2table(CAMELS_US_signatures_Groundwater),...
%     strcat(results_path,'CAMELS_US_signatures_Groundwater.txt'))
% writetable(struct2table(CAMELS_US_signatures_Groundwater),...
%     strcat(results_path,'CAMELS_US_signatures_OverlandFlow.txt'))
