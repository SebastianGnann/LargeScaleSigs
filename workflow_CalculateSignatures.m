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
% CAMELS_CL_data = load('CAMELS_Matlab/Data/CAMELS_CL_data.mat');
CAMELS_BR_data = load('CAMELS_Matlab/Data/CAMELS_BR_data.mat');
CAMELS_AUS_data = load('CAMELS_Matlab/Data/CAMELS_AUS_data.mat');

%% Calculate signatures using TOSSH
% We first merge the different CAMELS datasets and remove catchments that 
% do not meet our quality criteria. We also extract a few common
% attributes, such as aridity.
t_mat, Q_mat, P_mat, PET_mat, attributes = combineDataCAMELS(...
    CAMELS_US_data, CAMELS_GB_data, CAMELS_AUS_data, CAMELS_BR_data);

% We can now use the calculation functions to calculate various signatures.
% McMillan groundwater set - note that this may take a few minutes
CAMELS_signatures_Groundwater = ...
    calc_McMillan_Groundwater(Q_mat, t_mat, P_mat, PET_mat);
% McMillan overland flow set - note that this may take a few minutes
CAMELS_signatures_OverlandFlow = ...
    calc_McMillan_OverlandFlow(Q_mat, t_mat, P_mat, PET_mat);

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
