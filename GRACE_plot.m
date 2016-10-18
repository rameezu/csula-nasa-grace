function [ ] = GRACE_plot( X, ttl )
%GRACE_plot Plots a GRACE Mascon data matrix for Northern Eurasia

% alter matrix
X = X'; %swith x and y axis
X = flipud(X); %flip matrix about horizontal

% restrict axes 
%   x from 20E - 180
%   y from 80N - 40N, 
X = X(20:100, 40:360);

% make NaN values plot as white
ddd=[1 1 1;jet(1000)];

% set plotting parameters
cmin = -30;
cmax = 30;
clims = [cmin, cmax];
colormap(ddd);

% plot
imagesc(X, clims);
title(ttl);
%xlabel('Longitude');
%ylabel('Latitude');
colorbar;
grid;

% set axes tiks
ax = gca;
ax.XTick = 1:40:360;
ax.XTickLabel = {'20E' '40E' '60E' '80E' '100E' '120E' '140E'...
    '160E' '180'};
ay = gca;
ay.YTick = 1:10:81;
ay.YTickLabel = {'80N' '75N' '70N' '65N' '60N' '55N' '50N' '45N' '40N'};

% grid line style
ax = gca;
ax.GridLineStyle = '--';

end

