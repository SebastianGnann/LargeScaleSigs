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
mydir = 'Signatures_large_scales';
addpath(genpath(mydir));
% figure path
fig_path = 'Signatures_large_scales/results/images';
results_path = 'Signatures_large_scales/results/';

%% load results
% This is only necessary if workflow_CalculateSignatures has not been run.
results_loaded = true;
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

%% examples of signature aridity relationships that differ between countries
fig = figure('pos',[100 100 900 250]);
subplot(1,3,1); hold on
scatter(attributes.aridity(attributes.country==2 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.BFI(attributes.country==2 & attributes.frac_snow<0.3),...
    'blue','filled','markerfacealpha',0.3)
scatter(attributes.aridity(attributes.country==3 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.BFI(attributes.country==3 & attributes.frac_snow<0.3),...
    'red','filled','markerfacealpha',0.3)
xlabel('PET/P [-]')
ylabel('BFI [-]')
legend('GB','AUS')
set(gca,'xscale','log')
xlim([0.1 10])

subplot(1,3,2); hold on
scatter(attributes.aridity(attributes.country==2 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.RR_Seasonality(attributes.country==2 & attributes.frac_snow<0.3),...
    'blue','filled','markerfacealpha',0.3)
scatter(attributes.aridity(attributes.country==4 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.RR_Seasonality(attributes.country==4 & attributes.frac_snow<0.3),...
    'green','filled','markerfacealpha',0.3)
xlabel('PET/P [-]')
ylabel('RR seasonality [-]')
legend('GB','BR')
set(gca,'xscale','log')
xlim([0.1 10])

subplot(1,3,3); hold on
scatter(attributes.aridity(attributes.country==1 & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==1 & attributes.frac_snow<0.3),...
    'magenta','filled','markerfacealpha',0.3)
scatter(attributes.aridity(attributes.country==4 & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==4 & attributes.frac_snow<0.3),...
    'green','filled','markerfacealpha',0.3)
xlabel('PET/P [-]')
ylabel('IE effect [-]')
legend('US','BR')
set(gca,'xscale','log')
xlim([0.1 10])


%% plot signatures
% show example catchment in Brazil
% plot time series
i = 900;
t = t_mat{i};
P = P_mat{i};
PET = PET_mat{i};
Q = Q_mat{i};

% plot Q and P data
fig1 = figure('Name',num2str(attributes.gauge_id(i)),'NumberTitle','off',...
    'pos',[100 100 600 300],...
    'Renderer','painters'); % OpenGL leads to strange plots

yyaxis left
hold on
p1 = plot(t,Q,'-','color',0*[1 1 1],'linewidth',2);
xlabel('Date')
xlim([datetime(1994,04,01) datetime(1999,04,01)])
ylabel('Q [mm/d]')

yyaxis right
p2 = plot(t,movmean(P,1),'-','color',.5*[1 1 1]);
p3 = plot(t,movmean(PET,1),'-','color',.8*[1 1 1]);
ylabel('P [mm/d]')
set(gca,'Ydir','reverse')

ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = .5*[1 1 1];
p1.ZData = ones(size(p1.XData));
p2.ZData = zeros(size(p2.XData));
set(ax, 'SortMethod', 'depth')

% plot signatures (recessions)
sig_RecessionAnalysis(Q,t,'fit_individual',true,'plot_results',true,'eps',0.001*median(Q,'omitnan'));
sig_BaseflowRecessionK(Q,t,'eps',0.001*median(Q,'omitnan'),'plot_results',true);

%% compare IE and SE effect in UK
fig = figure('pos',[100 100 300 250]); hold on
nr = 2;
scatter(attributes.aridity(attributes.country==nr & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.SE_effect(attributes.country==nr & attributes.frac_snow<0.3))
scatter(attributes.aridity(attributes.country==nr & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==nr & attributes.frac_snow<0.3))
xlabel('PET/P [-]'); ylabel('SE/IE Effect [-]')
legend('SE','IE','location','best')
hold on
% scatter(attributes.aridity(attributes.country==1),...
%     CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==1))

%% ##### probably unused plots #####
%% plot signatures
% find 5 catchments per country, arbitrarily picked
ind = [1,101,472,544,667,670,704,732,763,785,789,818,839,860,874,878,910,930,1002,1354];
for j = 1:length(ind)
    
    i = ind(j);
    
    % close previous plots
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

    sig_SeasonalVarRecessions(Q,t,'eps',median(Q,'omitnan')*0.001,'plot_results',true);
    sig_StorageFromBaseflow(Q,t,P,PET,'start_water_year',10,'plot_results',true);
    sig_RecessionAnalysis(Q,t,'fit_individual',true,'plot_results',true,'eps',0.001*median(Q,'omitnan'));
    sig_MRC_SlopeChanges(Q,t,'plot_results',true,'eps',0.001*median(Q,'omitnan'));

    sig_RecessionUniqueness(Q,t,'plot_results',true);

    sig_BFI(Q,t,'method','UKIH','parameters',5,'plot_results',true);
    sig_BaseflowRecessionK(Q,t,'eps',0.001*median(Q,'omitnan'),'plot_results',true);

    % of
    [IE_effect, SE_effect, IE_thresh_signif, IE_thresh, ...
        SE_thresh_signif, SE_thresh, SE_slope, ...
        Storage_thresh, Storage_thresh_signif, min_Qf_perc, ...
        error_flag, error_str, fig_handles] = sig_EventGraphThresholds(Q,t,P,'plot_results',true);

end

%% plot maps
% (attributes.frac_snow<0.3)
plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    CAMELS_signatures_Groundwater.MRC_num_segments,...
    'attribute_name',' ',...
    'ID',attributes.gauge_id,...
    'colour_scheme','YlGnBu','flip_colour_scheme',false,...
    'c_limits',[1 3],'c_log_scale',false,...
    'figure_name',' ','save_figure',false,'figure_path',fig_path)

plotMap_US(attributes.gauge_lat,attributes.gauge_lon,...
    CAMELS_signatures_OverlandFlow.Storage_thresh,...
    'attribute_name','',...
    'ID',attributes.gauge_id,...
    'colour_scheme','YlGnBu','flip_colour_scheme',false,...
    'c_limits',[-0.1 .9],'c_log_scale',false,...
    'figure_name','','save_figure',false,'figure_path',fig_path)

plotMap_Globe(attributes.gauge_lat,attributes.gauge_lon,...
    CAMELS_signatures_OverlandFlow.IE_effect,...
    'attribute_name','',...
    'ID',attributes.gauge_id,...
    'colour_scheme','YlGnBu','flip_colour_scheme',false,...
    'figure_name','','save_figure',false,'figure_path',fig_path)

%% storage fraction and its components
fig = figure('pos',[100 100 900 250]);
subplot(1,3,1)
scatter(CAMELS_signatures_Groundwater.StorageFraction(:,1),...
    CAMELS_signatures_Groundwater.AverageStorage,25)
xlabel('Storage frac. [-]')
ylabel('Storage [mm]')
caxis([0 0.1])
subplot(1,3,2)
scatter(CAMELS_signatures_Groundwater.StorageFraction(:,2),...
    CAMELS_signatures_Groundwater.AverageStorage,25)
xlabel('Active storage [mm]')
caxis([0 0.1])
subplot(1,3,3)
scatter(CAMELS_signatures_Groundwater.StorageFraction(:,3),...
    CAMELS_signatures_Groundwater.AverageStorage,25)
xlabel('Total storage [mm]')
caxis([0 0.1])

