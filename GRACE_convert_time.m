% Aaron Trefler
% 2016-05-03
% GRACE_convert_time: Convert times imported from GRACE Mascon dataset to
% date strings

% (1) manually load processed GRACE Mascon data

for i = 1:144
    time_datestr_GRACE(i) = datetime(2002,01,01) + caldays(round(time(i)));
end

% (2) use time_datestr_GRACE to verify previously computed time_datestr
% char value vector

% (3) validateion was performed on 2016-05-03
