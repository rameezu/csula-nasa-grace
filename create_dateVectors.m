% Aaron Trefler
% 2016-06-06
% Convert GRACE monthly datenum values to vectors containing associated date
% values.

DV = datevec(time_datenum); %time_datenum produced from Script_OceanDepth
DV = DV(:, 1:3); %extract year, month, day

DV2 = DV;
DV2(:, 2:3) = 0; %set all values to be beginning of respective year

time_dayOfYear = datenum(DV) - datenum(DV2); %number of days since the beginning of year
time_year = DV(:,1);
time_month = DV(:,2);