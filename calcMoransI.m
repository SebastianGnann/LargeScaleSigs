function I = calcMoransI(lat,lon,z)
% Moran's I (see Addor paper)
% using inverse distance as weight

z_mean = mean(z,'omitnan');
z_m = z - z_mean;
z_m(isnan(z_m)) = z_mean;
n = length(z);

weights = zeros(n,n);
z_ij = zeros(n,n);

for i = 1:n
    for j = 1:n
        if i~=j
            weights(i,j) = 1./sqrt((lat(i)-lat(j))^2+(lon(i)-lon(j))^2);
            z_ij(i,j) = weights(i,j).*z_m(i)*z_m(j);
        end
    end
end

I = (1/sum(sum(weights)))*sum(sum(z_ij))./...
    ((1/n)*sum(z_m.^2));
% I
% E = -1/(n-1)
end
