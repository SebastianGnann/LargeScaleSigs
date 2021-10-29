% Hilary McMillan, San Diego State University, 25/10/2021
%
%This script runs the TOSSH (Toolbox for Streamflow Signatures in
%Hydrology) workflows for overland flow and groundwater signatures for
%Critical Zone Observatory sites in Santa Catalina, Intensively Managed
%Landscapes, Luquillo, Shale Hills and Eel River CZOs.
%
%Daily and Hourly data are run separately where available.
%Signature values are output to screen.
%Code shows values for watershed-specific parameters in calls to TOSSH
%workflows.


%% Setting paths and variables

%Whether to display graphical output in various signature calculations.
plot_results = false;

%Path where CZO rain/flow data are stored
basepath = 'C:\User\CZO_Signatures';


%% Santa Catalina CZO
% _MG data are for Marshall Gulch
% _OR data are for Oracle Ridge

%Load daily data for Marshall Gulch
load(fullfile(basepath,'Level 3 data products','SC_MG_day.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_SC_MG_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_SC_MG_daily;
SC_MG_day_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_SC_MG_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_SC_MG_daily;
SC_MG_day_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]

%Load hourly data for Marshall Gulch
load(fullfile(basepath,'Level 3 data products','SC_MG_hr.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_SC_MG_hr = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.17,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_SC_MG_hr;
SC_MG_hr_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_SC_MG_hr = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_SC_MG_hr;
SC_MG_hr_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]


%Load daily data for Oracle Ridge
load(fullfile(basepath,'Level 3 data products','SC_OR_day.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_SC_OR_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_SC_OR_daily;
SC_OR_day_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_SC_OR_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_SC_OR_daily;
SC_OR_day_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]


%Load hourly data for Oracle Ridge
load(fullfile(basepath,'Level 3 data products','SC_OR_hr.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_SC_OR_hr = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.17,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_SC_OR_hr;
SC_OR_hr_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_SC_OR_hr = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_SC_OR_hr;
SC_OR_hr_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]

%% IML (Intensively Managed Landscapes) CZO

%Load daily data for IML CZO
load(fullfile(basepath,'Level 3 data products','IML_day.mat'))
  
%Run Groundwater signature workflow
TOSSH_signatures_IML_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_IML_daily;
IML_day_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_IML_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_IML_daily;
IML_day_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]


%Load hourly data for IML
load(fullfile(basepath,'Level 3 data products','IML_hr.mat'))
  
%Run Groundwater signature workflow
TOSSH_signatures_IML_hr = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_IML_hr;
IML_hr_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_IML_hr = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_IML_hr;
IML_hr_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]



%% Luquillo CZO (Rio Icacos and Rio Mameyes)
% Only daily data is available

%Load daily data for Rio Icacos
load(fullfile(basepath,'Level 3 data products','LUQ_IC_day.mat'))

%Try deleting the nan section to avoid breaking various signatures
pt1 = find(data.t == datetime(2004,9,31));
pt2 = find(data.t == datetime(2007,10,1));
data.t=[data.t(1:pt1);data.t(pt2:end)];
data.P=[data.P(1:pt1);data.P(pt2:end)];
data.Q=[data.Q(1:pt1);data.Q(pt2:end)];
data.PET=[data.PET(1:pt1);data.PET(pt2:end)];
   
%Run Groundwater signature workflow
TOSSH_signatures_LUQ_IC_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_LUQ_IC_daily;
LUQ_IC_daily_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_LUQ_IC_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_LUQ_IC_daily;
LUQ_IC_daily_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]


%Load daily data for Rio Mameyes
load(fullfile(basepath,'Level 3 data products','LUQ_MAM_day.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_LUQ_MAM_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_LUQ_MAM_daily;
LUQ_MAM_daily_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_LUQ_MAM_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_LUQ_MAM_daily;
LUQ_MAM_daily_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]


%% Shale Hills

%Load daily data for Shale Hills
load(fullfile(basepath,'Level 3 data products','SH_day.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_SH_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_SH_daily;
SH_day_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_SH_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_SH_daily;
SH_day_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]

%Load hourly data for Shale Hills
load(fullfile(basepath,'Level 3 data products','SH_hr.mat'))
%Remove cases of negative P
data.P(data.P<0)=0;

%Run Groundwater signature workflow
TOSSH_signatures_SH_hr = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.01,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_SH_hr;
SH_hr_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_SH_hr = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_SH_hr;
SH_hr_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]
   

%% Eel River CZO (Elder and Dry Creeks)

%Load daily data for Elder Creek
load(fullfile(basepath,'Eel_CZO','Proc_Data','EEL_day.mat'))
  
%Run Groundwater signature workflow
TOSSH_signatures_Eel_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_Eel_daily;
Eel_Elder_daily_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_Eel_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_Eel_daily;
Eel_Elder_daily_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]

%Load hourly data for Elder Creek
load(fullfile(basepath,'Eel_CZO','Proc_Data','EEL_hr.mat'))

%Run Groundwater signature workflow
TOSSH_signatures_Eel_hourly = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.1,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_Eel_hourly;
Eel_Elder_hr_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_Eel_hourly = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_Eel_hourly;
Eel_Elder_hr_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]

%Load daily data for Dry Creek
load(fullfile(basepath,'Eel_CZO','Proc_Data','Eel_DryCreek_day.mat'))

%Remove negatives in PET
data.PET(data.PET<=0)=0;
   
%Run Groundwater signature workflow
TOSSH_signatures_Eel_DryCreek_daily = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',median(data.Q,'omitnan')*0.001,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_Eel_DryCreek_daily;
Eel_Dry_daily_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_Eel_DryCreek_daily = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_Eel_DryCreek_daily;
Eel_Dry_daily_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]

%Load hourly data for  Dry Creek
load(fullfile(basepath,'Eel_CZO','Proc_Data','Eel_DryCreek_hr.mat'))

%Remove negatives in PET
data.PET(data.PET<=0)=0;
   
%Run Groundwater signature workflow
TOSSH_signatures_Eel_DryCreek_hourly = calc_McMillan_Groundwater(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1), num2cell(data.PET,1), ...
    'start_water_year',10,'recession_length',2,'n_start',1,...
    'eps',mean(data.Q,'omitnan')*0.05,'plot_results',plot_results);
%Output signature values to screen
so=TOSSH_signatures_Eel_DryCreek_hourly;
Eel_Dry_hr_GW = [so.TotalRR;so.EventRR;so.RR_Seasonality;so.StorageFraction(1);so.StorageFraction(2);so.StorageFraction(3);...
    so.Recession_a_Seasonality;so.AverageStorage;so.RecessionParameters(1);so.RecessionParameters(2);so.RecessionParameters(3);...
    so.MRC_num_segments;so.BFI;so.BaseflowRecessionK;so.First_Recession_Slope;so.Mid_Recession_Slope;...
    so.Spearmans_rho;so.EventRR_TotalRR_ratio;so.VariabilityIndex]

%Run Overland flow signature workflow
TOSSH_OF_signatures_Eel_DryCreek_hourly = calc_McMillan_OverlandFlow(num2cell(data.Q,1), ...
    num2cell(data.t,1), num2cell(data.P,1),'plot_results',plot_results,'max_recessiondays',5);
%Output signature values to screen
so=TOSSH_OF_signatures_Eel_DryCreek_hourly;
Eel_Dry_hr_OF = [so.IE_effect;so.SE_effect;so.IE_thresh_signif;so.SE_thresh_signif;...
    so.IE_thresh;so.SE_thresh;so.SE_slope;so.Storage_thresh_signif;so.Storage_thresh;so.min_Qf_perc]



