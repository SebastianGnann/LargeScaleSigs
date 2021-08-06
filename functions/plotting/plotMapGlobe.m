function [] = plotMapGlobe(lat,lon,z,varargin)
%plotMapGlobe Plots Globe map with dots coloured according to an attribute.
%   Options:
%   - varioGlobe plotting options (axes limits, colorbar appearance, etc.)
%   - save plot
%
%   INPUT
%   lat: latitude
%   lon: longitude
%   z: attribute to be coloured in
%   OPTIONAL
%   attribute_name: name of attribute
%   ID: catchment IDs
% 	colour_scheme: name of colour scheme, e.g. 'Spectral'
%   flip_colour_scheme: whether to flip the colour scheme (boolean)
%   c_limits: limits of colour axis, e.g. [0 1]
%   c_lower_limit_open: whether the the lower limit is open (boolean)
%   c_upper_limit_open: whether the upper limit is open (boolean)
%   nr_colours: number of colours Globeed for colourscale
%   c_log_scale: whether colour scale should be on a log scale (boolean)
%   figure_title: title of plot, e.g. '(a)'
%   figure_name: name for saving, e.g. 'Globe_map'
%   save_figure: whether to save plot (boolean)
%   figure_path: path to folder where figure should be saved (char)
%   figure_type: figure type, e.g. -dpdf or -dmeta
%
%   OUTPUT
%   plot and saved figure
%
%   Copyright (C) 2021
%   This software is distributed under the GNU Public License Version 3.
%   See <https://www.gnu.org/licenses/gpl-3.0.en.html> for details.

if nargin < 3
    error('Not enough input arguments.')
end

ip = inputParser;

addRequired(ip, 'latitude', ...
    @(lat) isnumeric(lat) && (size(lat,1)==1 || size(lat,2)==1))
addRequired(ip, 'longitude', ...
    @(lon) isnumeric(lon) && (size(lon,1)==1 || size(lon,2)==1))
addRequired(ip, 'attribute', ...
    @(z) isnumeric(z) || islogical(z))

addParameter(ip, 'attribute_name', '', @ischar)
addParameter(ip, 'ID', NaN(size(z)), @isnumeric)
addParameter(ip, 'colour_scheme', 'Spectral', @ischar)
addParameter(ip, 'flip_colour_scheme', false, @islogical)
addParameter(ip, 'c_limits', [min(z) max(z)], @(x) isnumeric(x) && length(x)==2)
addParameter(ip, 'c_lower_limit_open', false, @islogical)
addParameter(ip, 'c_upper_limit_open', false, @islogical)
addParameter(ip, 'nr_colours', 10, @isnumeric)
addParameter(ip, 'c_log_scale', false, @islogical)
addParameter(ip, 'figure_title', '', @ischar)
addParameter(ip, 'figure_name', 'map_Globe', @ischar)
addParameter(ip, 'save_figure', false, @islogical)
addParameter(ip, 'figure_path', './', @ischar)
addParameter(ip, 'figure_type', '-dpdf', @ischar)

parse(ip, lat, lon, z, varargin{:})

attribute_name = ip.Results.attribute_name;
ID = ip.Results.ID;
colour_scheme = ip.Results.colour_scheme;
flip_colour_scheme = ip.Results.flip_colour_scheme;
c_limits = ip.Results.c_limits;
c_lower_limit_open = ip.Results.c_lower_limit_open;
c_upper_limit_open = ip.Results.c_upper_limit_open;
nr_colours = ip.Results.nr_colours;
c_log_scale = ip.Results.c_log_scale;
figure_title = ip.Results.figure_title;
figure_name = ip.Results.figure_name;
save_figure = ip.Results.save_figure;
figure_path = ip.Results.figure_path;
figure_type = ip.Results.figure_type;

%% plotting
index = [1:length(ID)]';

% plot map
pos = [100 100 900 600];
fig = figure('Name',figure_name,'NumberTitle','off','pos',pos);
ax = axesm('MapProjection','mercator','MapLatLimit',[-75 75],'MapLonLimit',[-180 180]);
shapefile = shaperead('Globe_50m.shp', 'UseGeoCoords', true);
geoshow(ax, shapefile, ...
    'DisplayType','polygon','DefaultFaceColor','white','DefaultEdgeColor','black')
hold on
% grid on

% create colormap
colour_mat = brewermap(nr_colours,colour_scheme);

% plot attribute
scatterm(lat(isnan(z)),lon(isnan(z)),'x k','linewidth',1.2);
scatterm(lat,lon,25,z,'filled')
% xlabel('Latitude [km]'); ylabel('Longitude [km]')
set(gca,'Visible','off')
title(figure_title,'Visible','on')
axis equal

% adjGlobet colour bar
colormap(colour_mat)
% colormap(colour_scheme);
if flip_colour_scheme
    cmap = colormap;
    colormap(flipud(cmap));
end
c = colorbar;
c.Position = [0.2 0.25 0.0078 0.125]; 
title(c,attribute_name)
caxis(c_limits)
if c_lower_limit_open
    c.TickLabels{1} = ['<' c.TickLabels{1}];
end
if c_upper_limit_open
    c.TickLabels{end} = ['>' c.TickLabels{end}];
end
if c_log_scale
    set(gca,'colorscale','log') 
end

% update cursor
dcm_obj = datacursormode(figure(fig));
set(dcm_obj,'UpdateFcn',{@myupdatefcn,ID,index})

%% save fig
if save_figure
    saveFig(fig,strcat('Globe_',figure_name),figure_path,figure_type)
end

end

