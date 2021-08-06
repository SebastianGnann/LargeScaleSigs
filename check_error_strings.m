%% GW
% compare to TotalRR error string which only contains some warnings because
% of NaN streamflow values
sum(CAMELS_signatures_Groundwater.TotalRR_error_str == ...
    CAMELS_signatures_Groundwater.RecessionParameters_error_str)

%%
% check out other errors
unique(CAMELS_signatures_Groundwater.TotalRR_error_str)

unique(CAMELS_signatures_Groundwater.AverageStorage_error_str)
% everytime: "Warning: eps set to a value larger than 1 percent of median(Q). High eps values can lead to problematic recession selection. "
% internal to function

unique(CAMELS_signatures_Groundwater.BaseflowRecessionK_error_str)
% twice: "Error: No long enough baseflow recession periods, consider increasing filter_par parameter. "
% few times: "Warning: Fewer than 10 recession segments extracted, results might not be robust. "
% few times: "Warning: Ignoring NaNs in streamflow data. Warning: Fewer than 10 recession segments extracted, results might not be robust. "

unique(CAMELS_signatures_Groundwater.MRC_num_segments_error_str)
% same as BaseflowRecessionK

unique(CAMELS_signatures_Groundwater.RecessionParameters_error_str)
% no errors (?) problem fixed... need to check again

unique(CAMELS_signatures_Groundwater.Spearmans_rho_error_str)
% few times: "Warning: Fewer than 10 recession segments extracted, results might not be robust. "

unique(CAMELS_signatures_Groundwater.StorageFraction_error_str)
% many times: "Warning: Estimated active storage is larger than total storage. "
% many times: "Warning: Estimated active storage is larger than total storage. Warning: Ignoring NaNs in streamflow data. "
% "Warning: Ignoring NaNs in streamflow data. "
% many times: "Warning: Storage ratio calculation unreliable for ephemeral catchments. "
% many times: "Warning: Storage ratio calculation unreliable for ephemeral catchments. Warning: Ignoring NaNs in streamflow data. "
% very many times: "Warning: Total storage could not be estimated properly. "
% very many times: "Warning: Total storage could not be estimated properly. Warning: Ignoring NaNs in streamflow data. "

unique(CAMELS_signatures_Groundwater.VariabilityIndex_error_str)
% many times: "Warning: Zero flows excluded from calculation. "
% "Warning: Zero flows excluded from calculation. Warning: Ignoring NaNs in streamflow data. "

%% OF
sum(CAMELS_signatures_Groundwater.TotalRR_error_str == ...
    CAMELS_signatures_OverlandFlow.OF_error_str)