clear
close all

%% Setup
% directories
grace_dir = ['/Users/aarontrefler_temp2/Documents/Work : Education/',...
'Education/School_Post_UCLA/CSULA/NASA-STEM JPL/GRACE/'];
data_dir = [grace_dir, 'Data/Processed/'];

% load GRACE Mascon data
load([data_dir, 'GRCTellus.JPL.200204_201504.GLO.RL05M_1.MSCNv01.nc.mat']);
load([data_dir, 'LAND_MASK.CRIv01.nc.mat']);

%% Process
% create land maps
lwe_thickness_land = lwe_thickness(:,:,:) .* repmat(land_mask, [1 1 144]);
lwe_thickness_land(lwe_thickness_land == 0) = NaN;

%% All Months
% import GRACE datasets 2003
JAN = lwe_thickness_land(:,:,1);
FEB = lwe_thickness_land(:,:,2);
MAR = lwe_thickness_land(:,:,3);
APR = lwe_thickness_land(:,:,4);
MAY = lwe_thickness_land(:,:,5);
% no June data file
JUL = lwe_thickness_land(:,:,6);
AUG = lwe_thickness_land(:,:,7);
SEP = lwe_thickness_land(:,:,8);
OCT = lwe_thickness_land(:,:,9);
NOV = lwe_thickness_land(:,:,10);
DEC = lwe_thickness_land(:,:,11);

% plot
rows = 6;
cols = 2;

figure;
subplot(rows,cols,1);
GRACE_plot(JAN, 'Jan 2003');
subplot(rows,cols,2);
GRACE_plot(FEB, 'Feb 2003');
subplot(rows,cols,3);
GRACE_plot(MAR, 'Mar 2003');
subplot(rows,cols,4);
GRACE_plot(APR, 'Apr 2003');
subplot(rows,cols,5);
GRACE_plot(MAY, 'May 2003');
% no June map
subplot(rows,cols,7);
GRACE_plot(JUL, 'Jul 2003');
subplot(rows,cols,8);
GRACE_plot(AUG, 'Aug 2003');
subplot(rows,cols,9);
GRACE_plot(SEP, 'Sep 2003');
subplot(rows,cols,10);
GRACE_plot(OCT, 'Oct 2003');
subplot(rows,cols,11);
GRACE_plot(NOV, 'Nov 2003');
subplot(rows,cols,12);
GRACE_plot(DEC, 'Dec 2003');