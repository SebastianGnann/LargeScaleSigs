%% workflow_InspectSignaturePlots
%
%   This script shows how to plot maps for different signatures.

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

%% Plot maps
%% Aridity
chosen_attribute = attributes.aridity;
c_limits = [0 2];
% chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'PET/P [-]';
colour_scheme = 'RdBu';
flip_colour_scheme = true;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'c_upper_limit_open',true,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

% from Wlostowski et al. (2021) paper
CZO_aridity = [1002/1036, 1254/1636, mean([1889/594, 1854/546]), mean([1335/3953, 1135/5313]), 1263/926];
%CZO_aridity = [0.98, 0.81, mean([3.49, 3.46]), mean([0.30, 0.22]), 1.40];
CZO_lat = [40.66, 39.73, mean([32.43, 32.45]), mean([18.33, 18.28]), 40.31];
CZO_lon = [-77.91, -123.64, mean([-110.76, -110.74]), mean([-65.75, -65.79]), -88.32];
CZO_lat(4) = 27;
CZO_lon(4) = -65.5; % fake coordinates to add it to map
% SH EC (MG OR) (MAM IC) US
scatterm(CZO_lat, CZO_lon, 100, CZO_aridity,'filled', 'markeredgecolor', 'k')

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% EventRR
chosen_attribute = CAMELS_signatures_Groundwater.EventRR;
c_limits = [0 0.75];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'EventRR [-]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% BaseflowRecessionK
chosen_attribute = CAMELS_signatures_Groundwater.BaseflowRecessionK;
c_limits = [0.0 0.5];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'BaseflowRecessionK [1/d]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% AverageStorage
chosen_attribute = CAMELS_signatures_Groundwater.AverageStorage;
c_limits = [0 500];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'AverageStorage [mm]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% Recession_b
chosen_attribute = CAMELS_signatures_Groundwater.RecessionParameters(:,2);
c_limits = [1 5];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'RecessionParameters b [-]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% IE_effect
chosen_attribute = CAMELS_signatures_OverlandFlow.IE_effect;
c_limits = [-.4 .6];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'IE_ effect [-]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% SE_effect
chosen_attribute = CAMELS_signatures_OverlandFlow.SE_effect;
c_limits = [0.5 1];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'SE_ effect [-]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% IE_thresh
chosen_attribute = CAMELS_signatures_OverlandFlow.IE_thresh;
c_limits = [0 30];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'IE_ thresh [mm/d]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

%% SE_thresh
chosen_attribute = CAMELS_signatures_OverlandFlow.SE_thresh;
c_limits = [0 50];
chosen_attribute(attributes.frac_snow>0.3) = NaN;

attribute_name = 'SE_ thresh [mm]';
colour_scheme = 'YlGnBu';
flip_colour_scheme = false;
c_log_scale = false;

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_GB(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_AUS(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_BR(attributes.gauge_lat,attributes.gauge_lon,...
    chosen_attribute,...
    'attribute_name',attribute_name,...
    'ID',attributes.gauge_id,...
    'colour_scheme',colour_scheme,'flip_colour_scheme',flip_colour_scheme,...
    'c_limits',c_limits,'c_log_scale',c_log_scale,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)
