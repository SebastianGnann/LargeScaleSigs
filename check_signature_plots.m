%% workflow_InspectSignaturePlots
%
%   This script shows how to analyse signatures calculated with the TOSSH
%   toolbox results:
%   - we inspect plots to see whether the signature calculations are
%   meaningful.

%% load useful packages
% ...
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

if (exist('CAMELS_Matlab') == 7)
    addpath(genpath('CAMELS_Matlab'));
else
    error('Code for plotting maps needed. Can be downloaded from https://github.com/SebastianGnann/CAMELS_Matlab and should be in a folder named CAMELS_Matlab in the same directory.')
end

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

%% plot signatures
% 5 catchments per country, arbitrarily picked
ind = [1,101,472,544,667,670,704,732,763,785,789,818,839,860,874,878,910,930,1002,1200];
for j = 1:length(ind)
    
    i = ind(j);
    
    % close previous plots
    % add breakpoint here to go through plots catchment by catchment
    close all
    
    % extract catchment data
    t = t_mat{i};
    P = P_mat{i};
    PET = PET_mat{i};
    Q = Q_mat{i};
    ID = attributes.gauge_id(i)
    
    % only signatures where plots are useful/exist
    % gw
    sig_EventRR(Q,t,P,'plot_results',true);
    sig_StorageFraction(Q,t,P,PET,'plot_results',true);

    sig_SeasonalVarRecessions(Q,t,'plot_results',true);
    sig_StorageFromBaseflow(Q,t,P,PET,'start_water_year',10,'plot_results',true);
    sig_RecessionAnalysis(Q,t,'fit_individual',true,'plot_results',true);
    sig_MRC_SlopeChanges(Q,t,'plot_results',true);

    sig_RecessionUniqueness(Q,t,'plot_results',true);

    sig_BFI(Q,t,'plot_results',true);
    sig_BaseflowRecessionK(Q,t,'plot_results',true);

    % of
    [IE_effect, SE_effect, IE_thresh_signif, IE_thresh, ...
        SE_thresh_signif, SE_thresh, SE_slope, ...
        Storage_thresh, Storage_thresh_signif, min_Qf_perc, ...
        error_flag, error_str, fig_handles] = sig_EventGraphThresholds(Q,t,P,'plot_results',true);

end

