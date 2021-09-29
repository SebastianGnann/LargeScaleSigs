function CZO_groundwater_quantile_mat = ...
    calcInvQuantileGW(Groundwater_matrix,attributes,Groundwater_CZO)
%    Calculates the inverse quantiles of CZO signature values given the 
%    CAMELS signatures. If the CZO signature value is the median of the 
%    CAMELS values, then it would return 0.5, and so on...
%
%    INPUT
%    Groundwater_matrix: Groundwater matrix with all CAMELS signatures
%    attributes: ...
%    Groundwater_CZO: CZO groundwater signatures for one CZO (same order as
%    Groundwater_matrix)
%
%    OUTPUT
%    ...

CZO_groundwater_quantile_mat = NaN(size(Groundwater_matrix,2),5);
for i = 1:size(Groundwater_matrix,2)
    tmp = Groundwater_matrix(:,i);
    for j = 1:4
        country_tmp = tmp(attributes.country==j);
        country_tmp(isnan(country_tmp)) = [];
        tmp_sorted = sort(country_tmp);
        ranks = [1:length(tmp_sorted)]'./length(tmp_sorted);
        [~,ind] = min(abs(tmp_sorted - Groundwater_CZO(i)));
        CZO_groundwater_quantile_mat(i,j) = ranks(ind);
    end
    tmp = tmp(isfinite(tmp));
    tmp(isnan(tmp)) = [];
    tmp_sorted = sort(tmp);
    ranks = [1:length(tmp_sorted)]'./length(tmp_sorted);
    [~,ind] = min(abs(tmp_sorted - Groundwater_CZO(i)));
    CZO_groundwater_quantile_mat(i,5) = ranks(ind);
end

end
