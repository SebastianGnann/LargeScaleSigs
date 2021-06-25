function correlationMatrixCircles(rho,signature_names,set,fig_path)
% https://de.mathworks.com/matlabcentral/answers/699755-fancy-correlation-plots-in-matlab
% sample correlation matrix

if strcmp(set,'gw')
    fig = figure('pos',[100 100 560 560]);
elseif strcmp(set,'of')
    fig = figure('pos',[100 100 360 360]);
else
    error('Set not defined.')
end
r = rho;
r(r==1) = NaN;
% labels
labels = signature_names;
% scatter plot
n = size(r, 1);
y = triu(repmat(n+1, n, n) - (1:n)') + 0.5;
x = triu(repmat(1:n, n, 1)) + 0.5;
x(x == 0.5) = NaN;
scatter(x(:), y(:), 400.*abs(r(:)), r(:), 'filled', 'MarkerFaceAlpha', 1.0)
% enclose markers in a grid
xl = [1:n+1;repmat(n+1, 1, n+1)];
xl = [xl(:, 1), xl(:, 1:end-1)];
yl = repmat(n+1:-1:1, 2, 1);
% line(xl, yl, 'color', 'k') % horizontal lines
% line(yl, xl, 'color', 'k') % vertical lines
% show labels
text(1:n, (n:-1:1) + 0.5, labels, 'HorizontalAlignment', 'right')
text((1:n) + 0.5, repmat(n + 1, n, 1) + 0.5, labels, ...
    'HorizontalAlignment', 'right', 'Rotation', 315)
h = gca;
c = colorbar(h);
h.Visible = 'off';
h.Position(4) = h.Position(4)*0.9;
axis(h, 'equal')
if strcmp(set,'gw')
    c.Position = [0.10 0.10 0.0321 0.1286];
    ax = gca;
%     ax.OuterPosition(1) = 0.05;
    ax.OuterPosition(2) = -0.05; 
elseif strcmp(set,'of')
    c.Position = [0.10 0.10 0.05 0.20]; 
    ax = gca;
    ax.OuterPosition(1) = 0.1;
    ax.OuterPosition(2) = -0.05;
else
    error('Set not defined.')
end
% create colormap
colour_mat = brewermap(10,'RdBu');
colormap(colour_mat)
% set(gca,'YDir','Reverse')
caxis([-1 1])
title(c,'\rho_s [-]')
% axis equal

saveFig(fig,strcat('corr_',set),fig_path,'-dpng')

end