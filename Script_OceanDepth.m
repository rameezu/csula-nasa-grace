% Aaron Trefler
% 4-24-2016
% Script_OceanDepth: peforms analysis on GRACE measurments over
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

% create date vector
time_datenum = ones(length(time),1) .*  datenum('00:00:00 01-01-2002');
for i = 1:length(time)
    time_datenum(i,1) = addtodate(time_datenum(i), int64(time(i)), 'day');
end
time_datestr = datestr(time_datenum(:));
time_datestr_cell = cellstr(time_datestr);

% create time-points per year vector
TPs_per_year = [7, 11, 12, 12, 12, 12, 12, 12, 12, 9, 11, 9, 9, 4];
TPs_per_yearCum = cumsum(TPs_per_year);

% create ocean maps for each month
lwe_thickness_ocean_jan = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Jan')) );
lwe_thickness_ocean_feb = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Feb')) );
lwe_thickness_ocean_mar = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Mar')) );
lwe_thickness_ocean_apr = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Apr')) );
lwe_thickness_ocean_may = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'May')) );
lwe_thickness_ocean_jun = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Jun')) );
lwe_thickness_ocean_jul = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Jul')) );
lwe_thickness_ocean_aug = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Aug')) );
lwe_thickness_ocean_sep = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Sep')) );
lwe_thickness_ocean_oct = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Oct')) );
lwe_thickness_ocean_nov = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Nov')) );
lwe_thickness_ocean_dec = lwe_thickness_ocean(:,:,...
    ~cellfun(@isempty, strfind(time_datestr_cell,'Dec')) );

%% Analysis

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

%% Figures

% General Plotting Parameters
plot_fontSize = 12;
plot_titleSize = 15;

%% Figures: Monthly Time-Point Plots
figure;

% parameters
plot_title_avg = 'Monthly Global Averaged Total Ocean Water';
plot_title_std = ...
    'Monthly Global Mean Standard Deviation of Total Ocean Water';
plot_titlex = 'All Time Points'; 
plot_titley = {'Equivalent Water Thickness', 'Relative to Baseline (cm)'};
plot_xlimits = [1 length(ocean_avg)];
plot_xticks = [1, cumsum(TPs_per_year)];
plot_xticklabels = {'2002','2003','2004','2005','2006','2007',...
    '2008','2009','2010','2011','2012','2013','2014','2015','2016'};

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

%% Figures: Yearly Plots
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

%% Figures: Yearly Regression Plots
% Using only years that have 9 data points or more.
figure;

% parameters
plot_title = 'Linear Regrssion for Annual Mean Global Ocean Water';
plot_titlex = 'Years'; 
plot_titley = {'Equivalent Water Thickness', 'Relative to Baseline (cm)'};
plot_xticks = 0:13;
plot_xticklabels = {'2002','2003','2004','2005','2006','2007','2008',...
    '2009','2010','2011','2012','2013','2014','2015'};
plot_xlim = [0 13];

% plotting data
x = 1:12;
y = ocean_year_avg(2:13);

% scatter plot
plot(x,y,'.','MarkerSize',30)
xlim(plot_xlim)

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
%yl = ylim;
%yl_min = yl(1);
%yl_max = yl(2);
%patch([1 1 7 7],[yl_min,yl_max, yl_max,yl_min],...
%    'k','FaceAlpha',0.1,'EdgeColor','none');
saveas(gcf,[dir_fig,'OceanDepth_Metrics_YearlyTPs_avg_reg'],'tiffn');

%% Figures: Monthly Spatial Plots 
% Maximum and Minimum months with Current Counterparts
figure;

% plotting parameters
clims = [-30, 30];

% ---------- Max Plot ----------
%subplot(1,2,1);
GRACE_plot_world(...
    lwe_thickness_ocean(:,:,ix_max),... 
    {'Distribution of Water Volume Departures from Baseline', ...
    'October 17th, 2006'}, clims);
saveas(gcf,[dir_fig,'OceanDepth_Spatial_MaxMinTPs_max'],'tiffn');


% ---------- Max Plot Current Counterpart ----------
ix_max_counterpart = 139; % corresponds to 17-Oct-2014
GRACE_plot_world(...
    lwe_thickness_ocean(:,:,ix_max_counterpart),... 
    {'Distribution of Water Volume Departures from Baseline', ...
    'October 17th, 2014'}, clims);
saveas(gcf,...
    [dir_fig,'OceanDepth_Spatial_MaxMinTPs_max_counterpart_2014'],'tiffn');

% ---------- Min Plot ----------
%subplot(1,2,2);
GRACE_plot_world(...
    lwe_thickness_ocean(:,:,ix_min),... 
    {'Distribution of Water Volume Departures from Baseline',...
    'January 17th, 2012'}, clims);
saveas(gcf,[dir_fig,'OceanDepth_Spatial_MaxMinTPs_min'],'tiffn');

% ---------- Min Plot Current Counterpart ----------
ix_min_counterpart = 141; % corresponds to 23-Jan-2015
GRACE_plot_world(...
    lwe_thickness_ocean(:,:,ix_min_counterpart),... 
    {'Distribution of Water Volume Departures from Baseline', ...
    'January 23rd, 2015'}, clims);
saveas(gcf,...
    [dir_fig,'OceanDepth_Spatial_MaxMinTPs_min_counterpart_2015'],'tiffn');

%% Monthly Spatial Linear Regression Plots

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_jan);
GRACE_plot_world(intercept,'Jan Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_01'],'tiffn');
GRACE_plot_world(slope,'Jan Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_01'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_feb);
GRACE_plot_world(intercept,'Feb Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_02'],'tiffn');
GRACE_plot_world(slope,'Feb Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_02'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_mar);
GRACE_plot_world(intercept,'Mar Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_03'],'tiffn');
GRACE_plot_world(slope,'Mar Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_03'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_apr);
GRACE_plot_world(intercept,'Apr Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_04'],'tiffn');
GRACE_plot_world(slope,'Apr Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_04'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_may);
GRACE_plot_world(intercept,'May Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_05'],'tiffn');
GRACE_plot_world(slope,'May Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_05'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_jun);
GRACE_plot_world(intercept,'Jun Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_06'],'tiffn');
GRACE_plot_world(slope,'Jun Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_06'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_jul);
GRACE_plot_world(intercept,'Jul Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_07'],'tiffn');
GRACE_plot_world(slope,'Jul Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_07'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_aug);
GRACE_plot_world(intercept,'Aug Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_08'],'tiffn');
GRACE_plot_world(slope,'Aug Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_08'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_sep);
GRACE_plot_world(intercept,'Sep Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_09'],'tiffn');
GRACE_plot_world(slope,'Sep Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_09'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_oct);
GRACE_plot_world(intercept,'Oct Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_10'],'tiffn');
GRACE_plot_world(slope,'Oct Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_10'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_nov);
GRACE_plot_world(intercept,'Nov Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_11'],'tiffn');
GRACE_plot_world(slope,'Nov Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_11'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean_dec);
GRACE_plot_world(intercept,'Dec Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_12'],'tiffn');
GRACE_plot_world(slope,'Dec Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_12'],'tiffn');

[intercept, slope] = GRACE_regression(lwe_thickness_ocean);
GRACE_plot_world(intercept,'All Intercept',[-10 10]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Inter_All'],'tiffn');
GRACE_plot_world(slope,'All Slope',[-1 1]);
saveas(gcf,[dir_fig,'OceanDepth_Monthly_Spatial_LR_Slope_All'],'tiffn');









