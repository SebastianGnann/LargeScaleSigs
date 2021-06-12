%% workflow_CorrelationAnalysis
%
%   This script shows how to analyse signatures calculated with the TOSSH
%   toolbox results:
%   - ...
%
%   Copyright (C) 2021
%   This software is distributed under the GNU Public License Version 3.
%   See <https://www.gnu.org/licenses/gpl-3.0.en.html> for details.

%% load useful packages

if (exist('BrewerMap') == 7)
    addpath(genpath('BrewerMap'));
else
    error('BrewerMap toolbox needed. Can be downloaded from https://github.com/DrosteEffect/BrewerMap and should be in a folder named BrewerMap in the same directory.')
end

if (exist('TOSSH') == 7)
    addpath(genpath('TOSSH'));
else
    error('TOSSH toolbox needed. Can be downloaded from https://github.com/TOSSHtoolbox and should be in a folder named TOSSH in the same directory.')
end

%% add paths

% working directory (important so that functions herein are called)
mydir = 'Signatures_large_scales';
addpath(genpath(mydir));

% figure path
fig_path = 'Signatures_large_scales/Figures/';
results_path = 'Signatures_large_scales/Results/';

