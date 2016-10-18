% Aaron Trefler
% 4-24-2016
% Script_OceanDepth: produces graphs related to GRACE measurments over
% ocean values.
% 
% Number of monthly time-points for each year:
% 2002: 07, 2003: 11, 2004: 12, 2005: 12, 2006: 12, 2007: 12, 2008: 12, 
% 2009: 12, 2010: 12, 2011: 09, 2012: 11, 2013: 09, 2014: 09, 2015: 04

clear
close all

%% Setup

% directories
dir_nasa = ['/Users/aarontrefler_temp2/Documents/Work : Education/',...
'Education/School_Post_UCLA_Pre_UCSD/CSULA/NASA-STEM JPL/Geoscience/'];
dir_grace = [dir_nasa, 'Project/GRACE/'];
dir_data = [dir_grace, 'Data/Processed/'];
dir_fig = [dir_nasa, 'Project/Figures/GRACE/Ocean Depth/'];

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
time_date_year = str2double(time_datestr(:,8:end));

% create number of monthly time-points per year
TPs_per_year = [7, 11, 12, 12, 12, 12, 12, 12, 12, 9, 11, 9, 9, 4];
TPs_per_yearCum = cumsum(TPs_per_year);

%% Ocean Depth Analysis

% avg, std ocean values for all monthly-time points
ocean_avg = squeeze(nanmean(nanmean(lwe_thickness_ocean)));
ocean_std = squeeze(nanstd(nanstd(lwe_thickness_ocean)));

% avg, min, max ocean values for monthly-time points grouped by year
ocean_year_avg = zeros(1,length(TPs_per_year));
ocean_year_min = zeros(1,length(TPs_per_year));
ocean_year_max = zeros(1,length(TPs_per_year));
for i = 1:length(TPs_per_year)
    if i == 1
        ocean_year_avg(1) = mean(ocean_avg(1:TPs_per_yearCum(1)));
        ocean_year_min(1) = min(ocean_avg(1:TPs_per_yearCum(1)));
        ocean_year_max(1) = max(ocean_avg(1:TPs_per_yearCum(1)));
    else
        ocean_year_avg(i) = ...
            mean(ocean_avg(TPs_per_yearCum(i-1)+1:TPs_per_yearCum(i)));
        ocean_year_min(i) = ...
            min(ocean_avg(TPs_per_yearCum(i-1)+1:TPs_per_yearCum(i)));
        ocean_year_max(i) = ...
            max(ocean_avg(TPs_per_yearCum(i-1)+1:TPs_per_yearCum(i)));
    end
end

% max and min monthly-time point indicies
[~, ix_max] = max(ocean_avg);
[~, ix_min] = min(ocean_avg);

% rate of change matrices

%% General Plotting Parameters
plot_fontSize = 12;
plot_titleSize = 15;

%% Plot: Monthly Time-Point Plots
figure;

% parameters
plot_title_avg = 'Monthly Global Averaged Total Ocean Water';
plot_title_std = ...
    'Monthly Global Mean Standard Deviation of Total Ocean Water';
plot_titlex = 'All Time Points'; 
plot_titley = {'Equivalent Water Thickness', 'Relative to Baseline (cm)'};
plot_xlimits = [1 length(ocean_avg)];
plot_xticks = cumsum(TPs_per_year);
plot_xticklabels = {'2002', '2003', '2004', '2005', '2006', '2007',...
    '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015' };

% --- Monthly Avg Plot ---
%subplot(2,1,1)
plot(ocean_avg,'-','Marker','.','MarkerSize',20);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_avg,'FontSize', plot_titleSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);
%   x-tick labels
ax = gca;
ax.XTick = plot_xticks;
ax.XTickLabel = plot_xticklabels;
ax.XTickLabelRotation=45;
saveas(gcf,[dir_fig,'OceanDepth_Metrics_AllTPs_avg'],'tiffn');

%--- Monthly Std Plot ---
%subplot(2,1,2)
plot(ocean_std,'-','Marker','.','MarkerSize',20);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_std,'FontSize', plot_titleSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);
%   x-tick labels
ax = gca;
ax.XTick = plot_xticks;
ax.XTickLabel = plot_xticklabels;
ax.XTickLabelRotation=45;
saveas(gcf,[dir_fig,'OceanDepth_Metrics_AllTPs_std'],'tiffn');

%% Plot: Yearly Plots
figure; 

% parameters
plot_title_avg = 'Time Series of Annual Mean Global Ocean Water';
plot_title_max = 'Maximum Ocean Water for Each Year';
plot_title_min = 'Minimum Ocean Water for Each Year';
plot_titlex = 'Years'; 
plot_titley = {'Equivalent Water Thickness', 'Relative to Baseline (cm)'};
plot_xlimits = [1 length(TPs_per_year)];
plot_xticks = 1:length(TPs_per_year);
plot_xticklabels = {'2002', '2003', '2004', '2005', '2006', '2007',...
    '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015' };

% ---------- Avg Plot ----------
%subplot(3,1,1);
plot(ocean_year_avg,'-','Marker','.','MarkerSize',20,'LineWidth',1);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_avg,'FontSize', plot_titleSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);
%   x-tick labels
ax = gca;
ax.XTick = plot_xticks;
ax.XTickLabel = plot_xticklabels;
ax.XTickLabelRotation=45;
%   create full-data shaded area
yl = ylim;
yl_min = yl(1);
yl_max = yl(2);
patch(...
    [3 3 9 9],...
    [yl_min,yl_max, yl_max,yl_min],...
    'k', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
saveas(gcf,[dir_fig,'OceanDepth_Metrics_YearlyTPs_avg'],'tiffn');

% ---------- Max Plot ----------
%subplot(3,1,2);
plot(ocean_year_max,'-','Marker','.','MarkerSize',20,'LineWidth',1);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_max,'FontSize', plot_titleSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);
%   x-tick labels
ax = gca;
ax.XTick = plot_xticks;
ax.XTickLabel = plot_xticklabels;
ax.XTickLabelRotation=45;
%   create full-data shaded area
yl = ylim;
yl_min = yl(1);
yl_max = yl(2);
patch(...
    [3 3 9 9],...
    [yl_min,yl_max, yl_max,yl_min],...
    'k', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
saveas(gcf,[dir_fig,'OceanDepth_Metrics_YearlyTPs_max'],'tiffn');

% ---------- Min Plot ----------
%subplot(3,1,3);
plot(ocean_year_min,'-','Marker','.','MarkerSize',20,'LineWidth',1);
xlim(plot_xlimits);
grid;
%   titles
title(plot_title_min,'FontSize', plot_titleSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);
%   x-tick labels
ax = gca;
ax.XTick = plot_xticks;
ax.XTickLabel = plot_xticklabels;
ax.XTickLabelRotation=45;
%   create full-data shaded area
yl = ylim;
yl_min = yl(1);
yl_max = yl(2);
patch(...
    [3 3 9 9],...
    [yl_min,yl_max, yl_max,yl_min],...
    'k', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
saveas(gcf,[dir_fig,'OceanDepth_Metrics_YearlyTPs_min'],'tiffn');

%% Plot: Regression for Avg Ocean Yearly Values
% Using only years that have 12 data points
figure;

% parameters
plot_title = 'Linear Regrssion for Annual Mean Global Ocean Water';
plot_titlex = 'Years'; 
plot_titley = {'Equivalent Water Thickness', 'Relative to Baseline (cm)'};
plot_xticks = 1:7;
plot_xticklabels = {'2004','2005','2006','2007','2008','2009','2010'};

% plotting data
x = 1:7;
y = ocean_year_avg(3:9);

% scatter plot
plot(x,y,'.','MarkerSize',30)
grid;
%   titles
title(plot_title,'FontSize', plot_titleSize);
xlabel(plot_titlex,'FontSize', plot_fontSize);
ylabel(plot_titley,'FontSize', plot_fontSize);
%   x-tick labels
ax = gca;
ax.XTick = plot_xticks;
ax.XTickLabel = plot_xticklabels;
ax.XTickLabelRotation=45;

% regression line
X = [ones(length(x),1) x'];
b = X\y';
hold on
plot(x, X*b,'k--','LineWidth',2);

% shaded plot
yl = ylim;
yl_min = yl(1);
yl_max = yl(2);
patch([1 1 7 7],[yl_min,yl_max, yl_max,yl_min],...
    'k','FaceAlpha',0.1,'EdgeColor','none');
saveas(gcf,[dir_fig,'OceanDepth_Metrics_YearlyTPs_avg_reg'],'tiffn');


%% Plot: Max and Min Spatial Plots and Current Counterparts
figure;

% ---------- Max Plot ----------
%subplot(1,2,1);
GRACE_plot_world(...
    lwe_thickness_ocean(:,:,ix_max),... 
    {'Distribution of Water Volume Departures From a Baseline', ...
    'for 16-sept to 17-Oct, 2006'});
saveas(gcf,[dir_fig,'OceanDepth_Spatial_MaxMinTPs_max'],'tiffn');

% ---------- Max Plot Current Counterpart ----------
ix_max_counterpart = 


% ---------- Min Plot ----------
%subplot(1,2,2);
GRACE_plot_world(...
    lwe_thickness_ocean(:,:,ix_min),... 
    {'Distribution of Water Volume Departures From a Baseline',...
    'for 02-Jan to 17-Jan, 2012'});
saveas(gcf,[dir_fig,'OceanDepth_Spatial_MaxMinTPs_min'],'tiffn');

% ---------- Min Plot Current Counterpart ----------


















