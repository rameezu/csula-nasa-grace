% Aaron Trefler
% 4-24-2016
% Script_OceanDepth: produces graphs related to GRACE measurments over
% ocean values.

clear
%close all

%% Setup

% directories
dir_nasa = ['/Users/aarontrefler_temp2/Documents/Work : Education/',...
'Education/School_Post_UCLA_Pre_UCSD/CSULA/NASA-STEM JPL/'];
dir_grace = [dir_nasa, 'Project/GRACE/'];
dir_data = [dir_grace, 'Data/Processed/'];

% load GRACE Mascon data
load([dir_data, 'GRCTellus.JPL.200204_201504.GLO.RL05M_1.MSCNv01.nc.mat']);
load([dir_data, 'LAND_MASK.CRIv01.nc.mat']);

%% Process

% create ocean mask
ocean_mask = (land_mask == 0);

% create land maps
lwe_thickness_land = lwe_thickness(:,:,:) .* repmat(land_mask, [1 1 144]);
lwe_thickness_land(lwe_thickness_land == 0) = NaN;

% create ocean maps
lwe_thickness_ocean = lwe_thickness(:,:,:) .* repmat(ocean_mask, [1 1 144]);
lwe_thickness_ocean(lwe_thickness_ocean == 0) = NaN;

% create matlab datenum-time values
time_datenum = ones(length(time),1) .*  datenum('00:00:00 01-01-2002');
for i = 1:length(time)
    time_datenum(i,1) = addtodate(time_datenum(i), int64(time(i)), 'day');
end

% create date-strings
time_datestr = datestr(time_datenum(:));

%% Ocean Depth Analysis

% create avg, min, max ocean value vectors for all time points
ocean_avg = squeeze(nanmean(nanmean(lwe_thickness_ocean)));
ocean_std = squeeze(nanstd(nanstd(lwe_thickness_ocean)));
ocean_min = squeeze(min(min(lwe_thickness_ocean)));
ocean_max = squeeze(max(max(lwe_thickness_ocean)));

%% Monthly Plots
figure;

% parameters
plot_fontSize = 12;
plot_title_avg = 'GRACE Average Ocean Value';
plot_title_std = 'GRACE Standard Deviation of Ocean Values';
plot_title_min = 'GRACE Minimum Ocean Value';
plot_title_max = 'GRACE Maximum Ocean Value';
plot_titlex = 'Monthly Time Points'; 
plot_titley = {'Equivalent Water Thickness', 'Relative to Baseline (cm)'};
plot_xlimits = [1 length(ocean_avg)];

subplot(4,1,1)
plot(ocean_avg,'-','Marker','.','MarkerSize',20);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_avg,'FontSize', plot_fontSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);

subplot(4,1,2)
plot(ocean_std,'-','Marker','.','MarkerSize',20);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_std,'FontSize', plot_fontSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);

subplot(4,1,3);
plot(ocean_min,'-','Marker','.','MarkerSize',20);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_min,'FontSize', plot_fontSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);

subplot(4,1,4);
plot(ocean_max,'-','Marker','.','MarkerSize',20);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_max,'FontSize', plot_fontSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);

%%

%   x-tick labels
filenames_mod = strrep(filenames, 'nc_3A25.', '');
filenames_mod = strrep(filenames_mod, '.7.HDF.Z.nc', '');
ax = gca;
ax.XTick = 1:length(data_missing_time);
ax.XTickLabel = filenames_mod;
ax.XTickLabelRotation=90;
set(gca, 'FontSize', 5);













