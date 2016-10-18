function [ h ] = GRACE_plot( X, ttl )
%GRACE_plot Plots a GRACE data matrix 

% restrict axis 
%   x from 20E - 180
%   y from 80N - 40N, 
%X = X(11:50, 21:180);

% make NaN values plot as white
ddd=[1 1 1;jet(20)];

% set plotting parameters
cmin = -20;
cmax = 20;
clims = [cmin, cmax];
colormap(ddd);

% plot
imagesc(X, clims);
title(ttl);
colorbar;
grid;

end

