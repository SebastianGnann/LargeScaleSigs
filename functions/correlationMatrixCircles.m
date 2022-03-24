function correlationMatrixCircles(rho,signature_names,set,fig_path)
% https://de.mathworks.com/matlabcentral/answers/699755-fancy-correlation-plots-in-matlab
% creates plot showing correlation matrix

if strcmp(set,'gw')
    fig = figure('pos',[10 10 560 672]); hold on
elseif strcmp(set,'of')
    fig = figure('pos',[10 10 320 384]); hold on
else
    error('Set not defined.')
end
r = rho;
r(r==1) = NaN;
% labels
labels = signature_names;
% enclose markers in a grid
n = size(r, 1);
% xl = [1:n+1;repmat(n+1, 1, n+1)];
% xl = [xl(:, 1), xl(:, 1:end-1)];
% yl = repmat(n+1:-1:1, 2, 1);
xl = [2:n;repmat(n+1, 1, n-1)];
xl = [xl(:, 1), xl(:, 1:end-1)];
xl2 = xl; 
xl2(1,1) = 1;
yl = repmat(n+0.5:-1:2.5, 2, 1);
line(xl2, yl, 'color', [.5 .5 .5 .5]) % horizontal lines
line(yl, xl, 'color', [.5 .5 .5 .5]) % vertical lines
% scatter plot
y = triu(repmat(n+1, n, n) - (1:n)') + 0.5;
x = triu(repmat(1:n, n, 1)) + 0.5;
x(x == 0.5) = NaN;
scatter(x(:), y(:), 400.*abs(r(:)), r(:), 'filled', 'MarkerFaceAlpha', 1.0)
% show labels
text(1:n-1, (n-1:-1:1) + 1.5, labels(1:end-1), 'HorizontalAlignment', 'right','Interpreter','None')
text((2:n) + 0.75, repmat(n + 1, n-1, 1) + 0.5, labels(2:end), ...
    'HorizontalAlignment', 'right', 'Rotation', 315,'Interpreter','None')
h = gca;
c = colorbar(h);
c.FontSize = 10;
h.Visible = 'off';
h.Position(4) = h.Position(4)*0.9;
h.Position(1) = h.Position(1)*1.5;
axis(h, 'equal')
if strcmp(set,'gw')
    c.Position = [0.1 0.1 0.031 0.23];
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
title(c,'\rho_s [-]', 'FontSize', 12)
% axis equal

saveFig(fig,strcat('corr_',set),fig_path,'-dpng')

end