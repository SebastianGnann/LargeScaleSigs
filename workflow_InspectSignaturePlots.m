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

%% examples of signature aridity relationships that differ between countries
fig = figure('pos',[100 100 900 250]);

colour_mat = [
    169 90 161;
    245 121 58;
    133 192 249;
    15 32 128]./255;
% colour_mat = flip(parula(4));%[brewermap(4,'Spectral')]; %.8*ones(4,1)

subplot(1,3,1); hold on
scatter(attributes.aridity(attributes.country==1 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.TotalRR(attributes.country==1 & attributes.frac_snow<0.3),...
    'markeredgecolor',colour_mat(1,:),'markeredgealpha',1)
scatter(attributes.aridity(attributes.country==4 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.TotalRR(attributes.country==4 & attributes.frac_snow<0.3),...
     'markeredgecolor',colour_mat(4,:),'markeredgealpha',1)
scatter(attributes.aridity(attributes.country==2 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.TotalRR(attributes.country==2 & attributes.frac_snow<0.3),...
     'markeredgecolor',colour_mat(2,:),'markeredgealpha',1) %,'filled','markerfacealpha',0.5
scatter(attributes.aridity(attributes.country==3 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.TotalRR(attributes.country==3 & attributes.frac_snow<0.3),...
     'markeredgecolor',colour_mat(3,:),'markeredgealpha',1)
xlabel('PET/P [-]')
ylabel('TotalRR [-]')
% legend('US','GB','AUS','BR')
set(gca,'xscale','log')
xlim([0.1 10])
ylim([0 1])
title('(a)')
leg = legend('US','BR','GB','AUS','box','off');
leg.Position = [0.89 0.64 0.10 0.27];

subplot(1,3,2); hold on
scatter(attributes.aridity(attributes.country==1 & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==1 & attributes.frac_snow<0.3),...
    'markeredgecolor',colour_mat(1,:),'markeredgealpha',1)
scatter(attributes.aridity(attributes.country==4 & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==4 & attributes.frac_snow<0.3),...
     'markeredgecolor',colour_mat(4,:),'markeredgealpha',1)
scatter(attributes.aridity(attributes.country==2 & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==2 & attributes.frac_snow<0.3),...
     'markeredgecolor',colour_mat(2,:),'markeredgealpha',1) %,'filled','markerfacealpha',0.5
scatter(attributes.aridity(attributes.country==3 & attributes.frac_snow<0.3),...
    CAMELS_signatures_OverlandFlow.IE_effect(attributes.country==3 & attributes.frac_snow<0.3),...
     'markeredgecolor',colour_mat(3,:),'markeredgealpha',1)
xlabel('PET/P [-]')
ylabel('IE_effect [-]','Interpreter','None')
set(gca,'xscale','log')
% set(gca,'yscale','log')
xlim([0.1 10])
ylim([-0.6 0.8])
title('(b)')

subplot(1,3,3); hold on
scatter(attributes.aridity(attributes.country==2 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.BFI(attributes.country==2 & attributes.frac_snow<0.3),...
    'markeredgecolor',colour_mat(2,:),'markeredgealpha',1) %,'filled','markerfacealpha',0.5
scatter(attributes.aridity(attributes.country==3 & attributes.frac_snow<0.3),...
    CAMELS_signatures_Groundwater.BFI(attributes.country==3 & attributes.frac_snow<0.3),...
    'markeredgecolor',colour_mat(3,:),'markeredgealpha',1) %,'filled','markerfacealpha',0.5
xlabel('PET/P [-]')
ylabel('BFI [-]','Interpreter','None')
set(gca,'xscale','log')
xlim([0.1 10])
ylim([0 1])
title('(c)')

saveFig(fig,strcat('aridity_examples'),fig_path,'-dpng')

%% storage fraction and its components
fig = figure('pos',[100 100 900 250]);
subplot(1,3,1)
scatter(CAMELS_signatures_Groundwater.StorageFraction(:,1),...
    CAMELS_signatures_Groundwater.AverageStorage,25,'k')
xlabel('StorageFraction [-]')
ylabel('AverageStorage [mm]')
caxis([0 0.1])
subplot(1,3,2)
scatter(CAMELS_signatures_Groundwater.StorageFraction(:,2),...
    CAMELS_signatures_Groundwater.AverageStorage,25,'k')
xlabel('ActiveStorage [mm]')
caxis([0 0.1])
subplot(1,3,3)
scatter(CAMELS_signatures_Groundwater.StorageFraction(:,3),...
    CAMELS_signatures_Groundwater.AverageStorage,25,'k')
xlabel('TotalStorage [mm]')
caxis([0 0.1])

saveFig(fig,strcat('storage_fraction'),fig_path,'-dpng')


%% example recessions
% show example catchment in Brazil
% plot time series
i = 900;
t = t_mat{i};
P = P_mat{i};
PET = PET_mat{i};
Q = Q_mat{i};

% plot Q and P data
fig1 = figure('Name',num2str(attributes.gauge_id(i)),'NumberTitle','off',...
    'pos',[100 100 500 220],...
    'Renderer','painters'); % OpenGL leads to strange plots

yyaxis left
hold on
p1 = plot(t,Q,'-','color',0*[1 1 1],'linewidth',1.0);
xlabel('Date')
xlim([datetime(1994,09,01) datetime(1997,09,01)])
ylabel('Q [mm/d]')

yyaxis right
p2 = plot(t,movmean(P,1),'-','color',.6*[1 1 1],'linewidth',0.5);
% p3 = plot(t,movmean(PET,1),'-','color',.8*[1 1 1]);
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
xlim([10^-1 10^1]); ylim([10^-3 10^1])
xlabel('Q [mm/day]'); ylabel('dQ/dt [mm/day^2]'); title('')
fig = gcf;
fig.Position = [100 100 250 220]; 

sig_BaseflowRecessionK(Q,t,'eps',0.001*median(Q,'omitnan'),'plot_results',true);
xlabel('Relative time [days]'); ylabel('Flow [mm/day]'); title('')
fig = gcf;
box off
fig.Position = [100 100 500 220]; 
