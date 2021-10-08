function CZO_overland_flow_quantile_mat = ...
    calcInvQuantileOF(OverlandFlow_matrix,attributes,OverlandFlow_CZO)
%    Calculates the inverse quantiles of CZO signature values given the 
%    CAMELS signatures. If the CZO signature value is the median of the 
%    CAMELS values, then it would return 0.5, and so on...
%
%    INPUT
%    OverlandFlow_matrix: Overland flow matrix with all CAMELS signatures
%    attributes: ...
%    OverlandFlow_CZO: CZO overland flow signatures for one CZO (same order 
%    as OverlandFlow_matrix)
%
%    OUTPUT
%    CZO_overland_flow_quantile_mat: matrix with inverse quantiles 

CZO_overland_flow_quantile_mat = NaN(size(OverlandFlow_matrix,2),5);
for i = 1:size(OverlandFlow_matrix,2)
    tmp = OverlandFlow_matrix(:,i);
    for j = 1:4
        country_tmp = tmp(attributes.country==j);
        country_tmp(isnan(country_tmp)) = [];
        tmp_sorted = sort(country_tmp);
        ranks = [1:length(tmp_sorted)]'./length(tmp_sorted);
        [~,ind] = min(abs(tmp_sorted - OverlandFlow_CZO(i)));
        CZO_overland_flow_quantile_mat(i,j) = ranks(ind);
    end
    tmp = tmp(isfinite(tmp));
    tmp(isnan(tmp)) = [];
    tmp_sorted = sort(tmp);
    ranks = [1:length(tmp_sorted)]'./length(tmp_sorted);
    [~,ind] = min(abs(tmp_sorted - OverlandFlow_CZO(i)));
    CZO_overland_flow_quantile_mat(i,5) = ranks(ind);
end

end
