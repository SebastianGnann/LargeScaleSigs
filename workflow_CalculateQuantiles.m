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

%% Return inverse percentile value for a given signature
% GW
% We enter the list of signature values from a catchment (here calculated
% externally).
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

% We use a function that returns as the corresponding inverse percentiles.
CZO_groundwater_quantile_mat = ...
    calcInvQuantileGW(Groundwater_matrix,attributes,Groundwater_CZO);
round(CZO_groundwater_quantile_mat(:,1).*100)

%%
% OF
% We enter the list of signature values from a catchment (here calculated
% externally).
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

% We use a function that returns as the corresponding inverse percentiles.
CZO_overland_flow_quantile_mat = ...
    calcInvQuantileOF(OverlandFlow_matrix,attributes,OverlandFlow_CZO);
round(CZO_overland_flow_quantile_mat(:,1).*100)
