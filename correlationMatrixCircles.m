function correlationMatrixCircles(rho,signature_names)
% https://de.mathworks.com/matlabcentral/answers/699755-fancy-correlation-plots-in-matlab
% sample correlation matrix
figure('pos',[100 100 500 500]);
r = rho;
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
text((1:n) + 0.5, repmat(n + 1, n, 1), labels, ...
    'HorizontalAlignment', 'right', 'Rotation', 315)
h = gca;
c = colorbar(h);
h.Visible = 'off';
h.Position(4) = h.Position(4)*0.9;
axis(h, 'equal')
c.Position = [0.1424 0.1132 0.042 0.2712]; 
% colormap('jet')
% set(gca,'YDir','Reverse')
caxis([-1 1])
end