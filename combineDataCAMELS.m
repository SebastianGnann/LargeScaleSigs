function [t_mat, Q_mat, P_mat, PET_mat, attributes] = combineDataCAMELS(...
    CAMELS_US_data, CAMELS_GB_data, CAMELS_AUS_data, CAMELS_BR_data)
%prepareDataCAMELS Combines the different CAMELS datasets.
%
%   INPUT
%   CAMELS_data_xx: CAMELS data struct file
%
%   OUTPUT
%   t_mat: time cell
%   ...
%
%   Copyright (C) 2021
%   This software is distributed under the GNU Public License Version 3.
%   See <https://www.gnu.org/licenses/gpl-3.0.en.html> for details.

% To use TOSSH calculation functions, we need to create cell arrays
% containing the time series. We use cell arrays since some time series
% might have different lengths. While the length of each row in the cell
% array can vary, the cell arrays containing the t, Q, P, and PET data need
% to have exactly the same dimensions. 

% We first create cell arrays for all datasets we want to use. We only load
% data from a certain time period for better comparability and calculate
% the completeness in this time period to remove catchments with missing
% data.
[t_mat_US, Q_mat_US, P_mat_US, PET_mat_US, flow_perc_complete_US] = ...
    createCellCAMELS(CAMELS_US_data);
[t_mat_GB, Q_mat_GB, P_mat_GB, PET_mat_GB, flow_perc_complete_GB] = ...
    createCellCAMELS(CAMELS_GB_data);
[t_mat_AUS, Q_mat_AUS, P_mat_AUS, PET_mat_AUS, flow_perc_complete_AUS] = ...
    createCellCAMELS(CAMELS_AUS_data);
[t_mat_BR, Q_mat_BR, P_mat_BR, PET_mat_BR, flow_perc_complete_BR] = ...
    createCellCAMELS(CAMELS_BR_data);

% We then combine them into one large cell array.
t_mat = [t_mat_US; t_mat_GB; t_mat_AUS; t_mat_BR];
Q_mat = [Q_mat_US; Q_mat_GB; Q_mat_AUS; Q_mat_BR];
P_mat = [P_mat_US; P_mat_GB; P_mat_AUS; P_mat_BR];
PET_mat = [PET_mat_US; PET_mat_GB; PET_mat_AUS; PET_mat_BR];

% We also combine some attributes.
attributes.aridity = [CAMELS_US_data.aridity; CAMELS_GB_data.aridity; 
    CAMELS_AUS_data.aridity; CAMELS_BR_data.aridity];
attributes.frac_snow = [CAMELS_US_data.frac_snow; CAMELS_GB_data.frac_snow; 
    CAMELS_AUS_data.frac_snow; CAMELS_BR_data.frac_snow];
attributes.p_seasonality = [CAMELS_US_data.p_seasonality; CAMELS_GB_data.p_seasonality; 
    CAMELS_AUS_data.p_seasonality; CAMELS_BR_data.p_seasonality];
attributes.p_mean = [CAMELS_US_data.p_mean; CAMELS_GB_data.p_mean; 
    CAMELS_AUS_data.p_mean; CAMELS_BR_data.p_mean];
attributes.high_prec_freq = [CAMELS_US_data.high_prec_freq; CAMELS_GB_data.high_prec_freq; 
    CAMELS_AUS_data.high_prec_freq; CAMELS_BR_data.high_prec_freq];
attributes.pet_mean = [CAMELS_US_data.pet_mean; CAMELS_GB_data.pet_mean; 
    CAMELS_AUS_data.pet_mean; CAMELS_BR_data.pet_mean];
attributes.clay_frac = [CAMELS_US_data.clay_frac; CAMELS_GB_data.clay_perc; 
    CAMELS_AUS_data.claya; CAMELS_BR_data.clay_perc];
attributes.gauge_lat = [CAMELS_US_data.gauge_lat; CAMELS_GB_data.gauge_lat; 
    CAMELS_AUS_data.lat_outlet; CAMELS_BR_data.gauge_lat];
attributes.gauge_lon = [CAMELS_US_data.gauge_lon; CAMELS_GB_data.gauge_lon; 
    CAMELS_AUS_data.long_outlet; CAMELS_BR_data.gauge_lon];
attributes.country = [ones(size(CAMELS_US_data.gauge_lon)); ones(size(CAMELS_GB_data.gauge_lon))*2; 
    ones(size(CAMELS_AUS_data.long_outlet))*3; ones(size(CAMELS_BR_data.gauge_lon))*4];

% We remove catchments with incomplete records and human impacts. This is
% decided rather subjectively based on the available attributes. The main
% aim here is to remove catchments with *heavy* impacts.
% CAMELS US: contains only "near-natural" catchments
rmv_US = false(length(t_mat_US),1);
rmv_US(flow_perc_complete_US<99) = true;
% CAMELS GB: use benchmark catchments
rmv_GB = false(length(t_mat_GB),1);
rmv_GB(flow_perc_complete_GB<99) = true;
rmv_GB(~CAMELS_GB_data.isBenchmark) = true;
% CAMELS AUS: remove catchments with river disturbance index > 0.1
rmv_AUS = false(length(t_mat_AUS),1);
rmv_AUS(flow_perc_complete_AUS<99) = true;
rmv_AUS(CAMELS_AUS_data.river_di>0.1) = true;
% CAMELS BR: remove catchments with normalised consumptive use > 1% and
% catchments with regulation degree > 5%
rmv_BR = false(length(t_mat_BR),1);
rmv_BR(flow_perc_complete_BR<99) = true;
rmv_BR(CAMELS_BR_data.consumptive_use_perc>1) = true;
rmv_BR(CAMELS_BR_data.regulation_degree>5) = true;
% combine vectors
rmv = [rmv_US; rmv_GB; rmv_AUS; rmv_BR];

t_mat(rmv) = [];
Q_mat(rmv) = [];
P_mat(rmv) = [];
PET_mat(rmv) = [];
attributes.aridity(rmv) = [];
attributes.frac_snow(rmv) = [];
attributes.p_seasonality(rmv) = [];
attributes.p_mean(rmv) = [];
attributes.high_prec_freq(rmv) = [];
attributes.pet_mean(rmv) = [];
attributes.clay_frac(rmv) = [];
attributes.gauge_lat(rmv) = [];
attributes.gauge_lon(rmv) = [];
attributes.country(rmv) = [];

end