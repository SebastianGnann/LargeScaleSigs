clc

%% GW
% compare to TotalRR error string which only contains some warnings because
% of NaN streamflow values
sum(CAMELS_signatures_Groundwater.TotalRR_error_str == ...
    CAMELS_signatures_Groundwater.AverageStorage_error_str)

% do that for all signatures to see which ones contain additional warnings

%% inspect warnings

unique(CAMELS_signatures_Groundwater.AverageStorage_error_str)
%"Warning: Fewer than 10 recession segments extracted, results might not be robust. "
%"Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.BaseflowRecessionK_error_str)
%"Warning: Fewer than 10 recession segments extracted, results might not be robust. "
%"Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.MRC_num_segments_error_str)
%"Warning: Fewer than 10 recession segments extracted, results might not be robust. "
%"Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.Recession_a_Seasonality_error_str)
%"Warning: Fewer than 10 recession segments extracted, results might not be robust. "
%"Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.RecessionParameters_error_str)
%"Warning: Fewer than 10 recession segments extracted, results might not be robust. "
%"Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.Spearmans_rho_error_str)
%"Warning: Fewer than 10 recession segments extracted, results might not be robust. "
%"Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.StorageFraction_error_str)
%"Warning: Estimated active storage is larger than total storage. "
%"Warning: Estimated active storage is larger than total storage. Warning: Ignoring NaNs in streamflow data. "
%"Warning: Ignoring NaNs in streamflow data. "
%"Warning: Storage ratio calculation unreliable for ephemeral catchments. "
%"Warning: Storage ratio calculation unreliable for ephemeral catchments. Warning: Ignoring NaNs in streamflow data. "
%"Warning: Total storage could not be estimated properly. "
%"Warning: Total storage could not be estimated properly. Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.VariabilityIndex_error_str)
%"Warning: Ignoring NaNs in streamflow data. "
%"Warning: Zero flows excluded from calculation. "
%"Warning: Zero flows excluded from calculation. Warning: Ignoring NaNs in streamflow data. "

%% OF
sum(CAMELS_signatures_Groundwater.TotalRR_error_str == ...
    CAMELS_signatures_OverlandFlow.OF_error_str)
% no additional warnings
