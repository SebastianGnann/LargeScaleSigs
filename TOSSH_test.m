%% TOSSH signatures applied to CAMELS catchments
%
%   - Internal crash test that calculates all TOSSH signatures for CAMELS US
%
%   Copyright (C) 2020
%   This software is distributed under the GNU Public License Version 3.
%   See <https://www.gnu.org/licenses/gpl-3.0.en.html> for details.

% close all
% clear all
% clc

%% add directories for functions to path

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

if exist('./TOSSH') == 7
    addpath(genpath('./TOSSH')); % TOSSH4
else
    error('...')
end

% fig_path = '.\TOSSH_development\example\results\images';

%% load CAMELS data
if exist('data_CAMELS_struc') % check if data is already loaded
else
    data_CAMELS_struc = load('./CAMELS_Matlab/Data/CAMELS_data.mat');
end
CAMELS_data = data_CAMELS_struc.CAMELS_data;
clear data_CAMELS_struc

%% calculate all TOSSH signatures for CAMELS catchments 

n_CAMELS = length(CAMELS_data.gauge_id);
t_mat = cell(n_CAMELS,1);
Q_mat = cell(n_CAMELS,1);
P_mat = cell(n_CAMELS,1);
PET_mat = cell(n_CAMELS,1);
T_mat = cell(n_CAMELS,1);

for i = 1:n_CAMELS 
    
    if mod(i,100) == 0 % check progress
        fprintf('%.0f/%.0f\n',i,n_CAMELS)
    end
    
    t = datetime(CAMELS_data.Q{i}(:,1),'ConvertFrom','datenum');
    Q = CAMELS_data.Q{i}(:,2);    
    P = CAMELS_data.P{i}(:,2);
    PET = CAMELS_data.PET{i}(:,2);
    T = CAMELS_data.T{i}(:,2);
    
    % get subperiod, here from 1 Oct 1989 to 30 Sep 2009
    indices = 1:length(t); 
    start_ind = indices(t==datetime(1989,10,1));
    % in case time series starts after 1 Oct 1989
    if isempty(start_ind); start_ind = 1; end 
    end_ind = indices(t==datetime(2009,9,30));    
    t = t(start_ind:end_ind);
    Q = Q(start_ind:end_ind);
    P = P(start_ind:end_ind);
    PET = PET(start_ind:end_ind);
    T = T(start_ind:end_ind);
    
    t_mat{i} = t;
    Q_mat{i} = Q;
    P_mat{i} = P;
    PET_mat{i} = PET;
    T_mat{i} = T;
    
end

% tic
% CAMELS_TOSSH_signatures = calc_Addor(Q_mat, t_mat, P_mat);
% CAMELS_TOSSH_signatures = calc_All(Q_mat, t_mat, P_mat, PET_mat, T_mat);
CAMELS_TOSSH_signatures = calc_McMillan_Groundwater(Q_mat, t_mat, P_mat, PET_mat);
% toc

%% plots

plotMapUS(CAMELS_data.gauge_lat,CAMELS_data.gauge_lon,1./CAMELS_TOSSH_signatures.BaseflowRecessionK,...
    'attribute_name','Recession K [days]','ID',CAMELS_data.gauge_id,...
    'colour_scheme','Parula','flip_colour_scheme',false,...
    'c_limits',[0 30],'c_lower_limit_open',false,'c_upper_limit_open',true,...
    'figure_title','(a)','save_figure',false)
% set(gca,'ColorScale','log');

plotMapUS(CAMELS_data.gauge_lat,CAMELS_data.gauge_lon,CAMELS_TOSSH_signatures.RecessionParameters(:,2),...
    'attribute_name','Recession Beta [-]','ID',CAMELS_data.gauge_id,...
    'c_limits',[1 2],'c_upper_limit_open',true,...
    'colour_scheme','Parula','flip_colour_scheme',false,...
    'figure_title','(b)','save_figure',false)

plotMapUS(CAMELS_data.gauge_lat,CAMELS_data.gauge_lon,CAMELS_TOSSH_signatures.EventRR,...
    'attribute_name','Event Runoff Ratio [-]','ID',CAMELS_data.gauge_id,...
    'c_limits',[0 1.0],'c_upper_limit_open',false,...
    'colour_scheme','Parula','flip_colour_scheme',true,...
    'figure_title','(c)','save_figure',false)

plotMapUS(CAMELS_data.gauge_lat,CAMELS_data.gauge_lon,CAMELS_TOSSH_signatures.RR_Seasonality,...
    'attribute_name','xxx','ID',CAMELS_data.gauge_id,...    
    'colour_scheme','Parula','flip_colour_scheme',true,...
    'figure_title','','save_figure',false)
