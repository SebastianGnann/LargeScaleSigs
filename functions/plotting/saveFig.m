function [] = saveFig(fig,figure_name,figure_path,figure_type)
%saveFig saves figure as selected file type (e.g. PDF).
%
%   INPUT
%   fig: figure
%   figure_name: name of figure
%   figure_path: path to folder where figure should be saved
%   figure_type: figure type, e.g. -dpdf or -dmeta
%   OPTIONAL
%
%   OUTPUT
%   saved figure
%
%   Copyright (C) 2021
%   This software is distributed under the GNU Public License Version 3.
%   See <https://www.gnu.org/licenses/gpl-3.0.en.html> for details.

% check input parameters
if nargin < 3
    error('Not enough input arguments.')
elseif nargin < 4
    figure_type = '-dpdf';
end

set(fig,'Units','Inches');
position = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches',...
    'PaperSize',[position(3),position(4)]);
figure_name = strcat(figure_name);
path = strcat(figure_path,'/',figure_name);
print(fig,path,figure_type,'-r500'); 

end