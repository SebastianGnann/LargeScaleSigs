function [t_mat, Q_mat, P_mat, PET_mat, flow_perc_complete] = ...
    createCellCAMELS(CAMELS_data, period, start_water_year)
%createCellCAMELS Creates cell array for certain time period.
%
%   INPUT
%   CAMELS_data: CAMELS data struct file
%   period: water years to be extracted ([start_year end_year])
%   start_water_year: beginning of water year (e.g. 10 for October)
%
%   OUTPUT
%   t_mat: time matrix
%   Q_mat: Q matrix
%   P_mat: P matrix
%   PET_mat: PET matrix
%   flow_perc_complete: completeness of record 


% check input parameters
if nargin < 1
    error('Not enough input arguments.')
end 
if nargin < 2
    period = [1989 2009];
end
if nargin < 3
    start_water_year = 10;
end

n_CAMELS = length(CAMELS_data.gauge_id);
t_mat = cell(n_CAMELS,1);
Q_mat = cell(n_CAMELS,1);
P_mat = cell(n_CAMELS,1);
PET_mat = cell(n_CAMELS,1);
flow_perc_complete = NaN(n_CAMELS,1);

% We then loop over all catchments and extract the time series for each
% catchment.
fprintf('Creating data matrix...\n')
for i = 1:n_CAMELS
    
    if mod(i,100) == 0 % check progress
        fprintf('%.0f/%.0f\n',i,n_CAMELS)
    end
    
    t = datetime(CAMELS_data.Q{i}(:,1),'ConvertFrom','datenum');
    Q = CAMELS_data.Q{i}(:,2);    
    P = CAMELS_data.P{i}(:,2);
    PET = CAMELS_data.PET{i}(:,2);
    
    % get subperiod
    indices = 1:length(t); 
    start_ind = indices(t==datetime(period(1),start_water_year,1));
    % in case time series starts after start date
    if isempty(start_ind); start_ind = 1; end 
    end_ind = indices(t==(datetime(period(2),start_water_year,1)-1));    
    t = t(start_ind:end_ind);
    Q = Q(start_ind:end_ind);
    P = P(start_ind:end_ind);
    PET = PET(start_ind:end_ind);
    PET(PET<0) = 0; % set negative PET values to 0
    % calculate completeness during sub-period
    flow_perc_complete(i) = 100*(1-sum(isnan(Q))./length(Q));
    
    t_mat{i} = t;
    Q_mat{i} = Q;
    P_mat{i} = P;
    PET_mat{i} = PET;
    
end

end