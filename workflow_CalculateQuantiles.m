%% workflow_AnalyseSignatures
%
%   This script shows how to calculate inverse quantiles of CZO signature 
%   values given the CAMELS signatures. If the CZO signature value is the 
%   median of the CAMELS values, then it would return 0.5, and so on...

%% add paths
% working directory (important so that functions herein are called)
mydir = 'LargeScaleSigs';
addpath(genpath(mydir));
% figure path
fig_path = 'LargeScaleSigs/results/images';
results_path = 'LargeScaleSigs/results/';

%% load results
% This is only necessary if workflow_CalculateSignatures has not been run.
results_loaded = false;
if ~results_loaded
    %% load catchment data
    CAMELS_US_data = load('CAMELS_Matlab/Data/CAMELS_US_data.mat');
    CAMELS_GB_data = load('CAMELS_Matlab/Data/CAMELS_GB_data.mat');
    CAMELS_AUS_data = load('CAMELS_Matlab/Data/CAMELS_AUS_data.mat');
    CAMELS_BR_data = load('CAMELS_Matlab/Data/CAMELS_BR_data.mat');
    % CAMELS_CL_data = load('CAMELS_Matlab/Data/CAMELS_CL_data.mat');
    
    %% calculate signatures using TOSSH
    % We first merge the different CAMELS datasets and remove catchments that
    % do not meet our quality criteria (e.g. because of human impacts). We also
    % extract a few common attributes, such as aridity or mean precipitation.
    % Note that the start of the water year differs for some of the countries.
    [t_mat, Q_mat, P_mat, PET_mat, attributes] = combineDataCAMELS(...
        CAMELS_US_data, CAMELS_GB_data, CAMELS_AUS_data, CAMELS_BR_data);
    
    %% load signature results
    % We load the results calculated with the other script.
    CAMELS_signatures_Groundwater = ...
        load(strcat(results_path,'CAMELS_signatures_Groundwater.mat'));
    CAMELS_signatures_OverlandFlow = ...
        load(strcat(results_path,'CAMELS_signatures_OverlandFlow.mat'));
end

%% calculate and plot correlation matrices
% correlation matrix groundwater
% We create a matrix with all groundwater signatures, calculate their
% correlation with each other, and plot the results.

Groundwater_matrix = [...
    CAMELS_signatures_Groundwater.TotalRR,...
    CAMELS_signatures_Groundwater.EventRR,...
    CAMELS_signatures_Groundwater.RR_Seasonality,...
    CAMELS_signatures_Groundwater.StorageFraction(:,1),...
    CAMELS_signatures_Groundwater.StorageFraction(:,2),...
    CAMELS_signatures_Groundwater.StorageFraction(:,3),...
    CAMELS_signatures_Groundwater.Recession_a_Seasonality,...
    CAMELS_signatures_Groundwater.AverageStorage,...
    CAMELS_signatures_Groundwater.RecessionParameters(:,1),...
    CAMELS_signatures_Groundwater.RecessionParameters(:,2),...
    CAMELS_signatures_Groundwater.RecessionParameters(:,3),...
    CAMELS_signatures_Groundwater.MRC_num_segments,...
    CAMELS_signatures_Groundwater.BFI,...
    CAMELS_signatures_Groundwater.BaseflowRecessionK,...
    CAMELS_signatures_Groundwater.First_Recession_Slope,...
    CAMELS_signatures_Groundwater.Mid_Recession_Slope,...
    CAMELS_signatures_Groundwater.Spearmans_rho,...
    CAMELS_signatures_Groundwater.EventRR_TotalRR_ratio,...
    CAMELS_signatures_Groundwater.VariabilityIndex,...
    ];

% correlation matrix overland flow
% We create a matrix with all overland flow signatures, calculate their
% correlation with each other, and plot the results.
OverlandFlow_matrix = [...
    CAMELS_signatures_OverlandFlow.IE_effect,...
    CAMELS_signatures_OverlandFlow.SE_effect,...
    CAMELS_signatures_OverlandFlow.IE_thresh_signif,...
    CAMELS_signatures_OverlandFlow.SE_thresh_signif,...
    CAMELS_signatures_OverlandFlow.IE_thresh,...
    CAMELS_signatures_OverlandFlow.SE_thresh,...
    CAMELS_signatures_OverlandFlow.SE_slope,...
    CAMELS_signatures_OverlandFlow.Storage_thresh_signif,...
    CAMELS_signatures_OverlandFlow.Storage_thresh,...
    CAMELS_signatures_OverlandFlow.min_Qf_perc,...
    ];

%% return quantile value for a given signature
% groundwater
Groundwater_CZO = [
0.2055763398
0.05468242978
0.4895156699
1
198.3367262
198.3367262
2.37719152
69.64140726
3327.24419
2.823322784
5.828609788
1
0.3870299146
0.1732142447
0.3977612044
NaN
-0.05937790584
0.2659957359
0.1940034396 ];

CZO_groundwater_quantile_mat = ...
    calcInvQuantileGW(Groundwater_matrix,attributes,Groundwater_CZO);
round(CZO_groundwater_quantile_mat(:,1).*100)

%%
% overland flow
OverlandFlow_CZO = [
0.462
0.4676
0.0005
0
17.7292
22.8249
0.8947
0
50.9056
0];
CZO_overland_flow_quantile_mat = ...
    calcInvQuantileOF(OverlandFlow_matrix,attributes,OverlandFlow_CZO);
round(CZO_overland_flow_quantile_mat(:,1).*100)
