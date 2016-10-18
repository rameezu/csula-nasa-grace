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

% create date-strings
time_datestr = datestr(time_datenum(:));

%% Winter Differences

% First GRACE winter record was 2003
% Last year percipitation was collected over Northern Eurasia
year = 2003:2011;

% derived from GRACE_end_dates_of_meas_periods.txt
ix_beg = [ 08, 19, 31, 43, 55, 67, 79, 91, 103];
ix_end = [ 10, 21, 33, 45, 57, 69, 81, 93, 104];

for i = 1:length(year)
    
    % define beg and end indicies
    beg = ix_beg(i);
    fin = ix_end(i);
    
    % create map
    map = lwe_thickness_land(:,:,fin) - lwe_thickness_land(:,:,beg);

    % plot titles
    ttl_beg = [ time_datestr(beg-1,:),'  to  ', time_datestr(beg,:)];
    ttl_end = [ time_datestr(fin-1,:),'  to  ', time_datestr(fin,:)];
    
    % plot
    figure();
    GRACE_plot(map, ['GRACE: ',...
        '(',ttl_end,')',' - ','(',ttl_beg,')']);
end





