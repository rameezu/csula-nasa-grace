clear
%close all

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

% create matlab datenum-time values
time_datenum = ones(length(time),1) .*  datenum('00:00:00 01-01-2002');
for i = 1:length(time)
    time_datenum(i,1) = addtodate(time_datenum(i), int64(time(i)), 'day');
end

%% Winter Months
% 2003
JAN = lwe_thickness_land(:,:,8);
FEB = lwe_thickness_land(:,:,9);
MAR = lwe_thickness_land(:,:,10);

% plot
rows = 3;
cols = 1;
figure;

subplot(rows,cols,1);
ttl = [datestr(time_datenum(7)),'  to  ', datestr(time_datenum(8))];
GRACE_plot(JAN, ttl);
subplot(rows,cols,2);
ttl = [datestr(time_datenum(8)),'  to  ', datestr(time_datenum(9))];
GRACE_plot(FEB, ttl);
subplot(rows,cols,3);
ttl = [datestr(time_datenum(9)),'  to  ', datestr(time_datenum(10))];
GRACE_plot(MAR, ttl);

%% Winter Month Differences
% 2003
JAN = lwe_thickness_land(:,:,8);
FEB = lwe_thickness_land(:,:,9);
MAR = lwe_thickness_land(:,:,10);

% plot titles
ttl_jan = [ datestr(time_datenum(7)),'  to  ', datestr(time_datenum(8))];
ttl_feb = [datestr(time_datenum(8)),'  to  ', datestr(time_datenum(9))];
ttl_mar = [datestr(time_datenum(9)),'  to  ', datestr(time_datenum(10))];

% plot
rows = 2;
cols = 1;
figure;

subplot(rows,cols,1);
GRACE_plot(FEB-JAN, ['GRACE: ', '(',ttl_feb,')',' - ','(',ttl_jan,')']);

subplot(rows,cols,2);
GRACE_plot(MAR-FEB, ['GRACE: ', '(',ttl_mar,')',' - ','(',ttl_feb,')']);


%% All Months
% 2003
JAN = lwe_thickness_land(:,:,8);
FEB = lwe_thickness_land(:,:,9);
MAR = lwe_thickness_land(:,:,10);
APR = lwe_thickness_land(:,:,11);
MAY = lwe_thickness_land(:,:,12);
JUN = lwe_thickness_land(:,:,13);
JUL = lwe_thickness_land(:,:,14);
AUG = lwe_thickness_land(:,:,15);
SEP = lwe_thickness_land(:,:,16);
OCT = lwe_thickness_land(:,:,17);
NOV = lwe_thickness_land(:,:,18);
DEC = lwe_thickness_land(:,:,19);

% plot
rows = 6;
cols = 2;
figure;

subplot(rows,cols,1);
ttl = [datestr(time_datenum(7)),'  to  ', datestr(time_datenum(8))];
GRACE_plot(JAN, ttl);
subplot(rows,cols,2);
ttl = [datestr(time_datenum(8)),'  to  ', datestr(time_datenum(9))];
GRACE_plot(FEB, ttl);
subplot(rows,cols,3);
ttl = [datestr(time_datenum(9)),'  to  ', datestr(time_datenum(10))];
GRACE_plot(MAR, ttl);
subplot(rows,cols,4);
ttl = [datestr(time_datenum(10)),'  to  ', datestr(time_datenum(11))];
GRACE_plot(APR, ttl);
subplot(rows,cols,5);
ttl = [datestr(time_datenum(11)),'  to  ', datestr(time_datenum(12))];
GRACE_plot(MAY, ttl);
subplot(rows,cols,6);
ttl = [datestr(time_datenum(12)),'  to  ', datestr(time_datenum(13))];
GRACE_plot(JUN, ttl);
subplot(rows,cols,7);
ttl = [datestr(time_datenum(13)),'  to  ', datestr(time_datenum(14))];
GRACE_plot(JUL, ttl);
subplot(rows,cols,8);
ttl = [datestr(time_datenum(14)),'  to  ', datestr(time_datenum(15))];
GRACE_plot(AUG, ttl);
subplot(rows,cols,9);
ttl = [datestr(time_datenum(15)),'  to  ', datestr(time_datenum(16))];
GRACE_plot(SEP, ttl);
subplot(rows,cols,10);
ttl = [datestr(time_datenum(16)),'  to  ', datestr(time_datenum(17))];
GRACE_plot(OCT, ttl);
subplot(rows,cols,11);
ttl = [datestr(time_datenum(17)),'  to  ', datestr(time_datenum(18))];
GRACE_plot(NOV, ttl);
subplot(rows,cols,12);
ttl = [datestr(time_datenum(18)),'  to  ', datestr(time_datenum(19))];
GRACE_plot(DEC, ttl);