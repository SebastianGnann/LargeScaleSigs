%% test

if exist('./BrewerMap') == 7
    addpath(genpath('./BrewerMap'));
else
    error('BrewerMap toolbox needed. Can be downloaded from https://github.com/DrosteEffect/BrewerMap and should be in a folder named BrewerMap in the same directory.')
end

if exist('./CAMELS_Matlab') == 7
    addpath(genpath('./CAMELS_Matlab')); % CAMELS data
else
    error('CAMELS data processing repository needed. Can be downloaded from https://github.com/SebastianGnann/CAMELS_Matlab and should be in a folder named CAMELS_Matlab in the same directory.')
end

% figure path
% fig_path = '.\Baseflow_signatures\Images';

%% load catchment data
if exist('data_CAMELS_struc') % check if data is already loaded
else
    data_CAMELS_US_struc = load('./CAMELS_Matlab/Data/CAMELS_data.mat');
end
CAMELS_US_data = data_CAMELS_US_struc.CAMELS_data;
clear data_CAMELS_US_struc

if exist('data_CAMELS_GB_struc') % check if data is already loaded
else
    data_CAMELS_GB_struc = load('./CAMELS_Matlab/Data/CAMELS_GB_data.mat');
end
CAMELS_GB_data = data_CAMELS_GB_struc.CAMELS_GB_data;
clear data_CAMELS_GB_struc

if exist('data_CAMELS_CL_struc') % check if data is already loaded
else
    data_CAMELS_CL_struc = load('./CAMELS_Matlab/Data/CAMELS_CL_data.mat');
end
CAMELS_CL_data = data_CAMELS_CL_struc.CAMELS_CL_data;
clear data_CAMELS_CL_struc

if exist('data_CAMELS_BR_struc') % check if data is already loaded
else
    data_CAMELS_BR_struc = load('./CAMELS_Matlab/Data/CAMELS_BR_data.mat');
end
CAMELS_BR_data = data_CAMELS_BR_struc.CAMELS_BR_data;
clear data_CAMELS_BR_struc

if exist('data_CAMELS_AUS_struc') % check if data is already loaded
else
    data_CAMELS_AU_struc = load('./CAMELS_Matlab/Data/CAMELS_AUS_data.mat');
end
CAMELS_AU_data = data_CAMELS_AU_struc.CAMELS_AUS_data;
clear data_CAMELS_AUS_struc

%% clean up data

isOKUS = true(length(CAMELS_US_data.gauge_id),1);
% isOKUS(CAMELS_US_data.frac_snow>0.2) = false;

isOKGB = true(length(CAMELS_GB_data.gauge_id),1);
% isOKGB(CAMELS_GB_data.frac_snow>0.2) = false;
isOKGB(~CAMELS_GB_data.isBenchmark) = false;

isOKCL = true(length(CAMELS_CL_data.gauge_id),1);
% isOKCL(CAMELS_CL_data.interv_degree>1) = false;
% isOKCL(CAMELS_CL_data.frac_snow_mswep>0.2) = false;
% isOKCL(CAMELS_CL_data.lc_glacier>1) = false;

isOKBR = true(length(CAMELS_BR_data.gauge_id),1);
% isOKBR(CAMELS_BR_data.frac_snow>0.2) = false;
% isOKBR(CAMELS_BR_data.degree_of_regulation>1) = false;

isOKAU = true(length(CAMELS_AU_data.station_id),1);
% isOKAU(CAMELS_AU_data.frac_snow>0.2) = false;


%% new signatures

%% to do

% - clean up data loading
% - maps
% - scatter plots


%%
figure; hold on
scatter(CAMELS_US_data.aridity(isOKUS),CAMELS_US_data.runoff_ratio(isOKUS),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_GB_data.aridity(isOKGB),CAMELS_GB_data.runoff_ratio(isOKGB),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_CL_data.aridity_mswep(isOKCL),CAMELS_CL_data.runoff_ratio_mswep(isOKCL),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_BR_data.aridity(isOKBR),CAMELS_BR_data.runoff_ratio(isOKBR),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_AU_data.aridity(isOKAU),CAMELS_AU_data.runoff_ratio(isOKAU),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
legend('US','GB','CL','BR','AU')
xlabel('PET/P'); ylabel('Q/P')
xlim([.1 10]); ylim([0 1])
set(gca,'xscale','log')

figure; hold on
scatter(CAMELS_US_data.aridity(isOKUS),CAMELS_US_data.baseflow_index(isOKUS).*CAMELS_US_data.runoff_ratio(isOKUS),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_GB_data.aridity(isOKGB),CAMELS_GB_data.baseflow_index(isOKGB).*CAMELS_GB_data.runoff_ratio(isOKGB),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_CL_data.aridity_mswep(isOKCL),CAMELS_CL_data.baseflow_index(isOKCL).*CAMELS_CL_data.runoff_ratio_mswep(isOKCL),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_BR_data.aridity(isOKBR),CAMELS_BR_data.baseflow_index(isOKBR).*CAMELS_BR_data.runoff_ratio(isOKBR),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
scatter(CAMELS_AU_data.aridity(isOKAU),CAMELS_AU_data.baseflow_index(isOKAU).*CAMELS_AU_data.runoff_ratio(isOKAU),25,'filled','markerfacealpha',.25,'markerfacecolor','k')
legend('US','GB','CL','BR','AU')
xlabel('PET/P'); ylabel('Qb/P')
xlim([.1 10]); ylim([0 1])
set(gca,'xscale','log')
