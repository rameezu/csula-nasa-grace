clear
close all

% import GRACE datasets
% 2003
[A, ~, ~] = GRACE_import('GRCTellus.JPL.20030117.LND.RL05_1.DSTvSCS1411.tif');
[B, ~, ~] = GRACE_import('GRCTellus.JPL.20030215.LND.RL05_1.DSTvSCS1411.tif');
[C, ~, ~] = GRACE_import('GRCTellus.JPL.20030317.LND.RL05_1.DSTvSCS1411.tif');
% 2015
[X, ~, ~] = GRACE_import('GRCTellus.JPL.20150123.LND.RL05_1.DSTvSCS1411.tif');
[Y, ~, ~] = GRACE_import('GRCTellus.JPL.20030215.LND.RL05_1.DSTvSCS1411.tif');
[Z, ~, ~] = GRACE_import('GRCTellus.JPL.20030317.LND.RL05_1.DSTvSCS1411.tif');

%% plot single datasets 2003
figure;
subplot(3,1,1);
GRACE_plot(A, 'Jan 2003');
subplot(3,1,2);
GRACE_plot(B, 'Feb 2003');
subplot(3,1,3);
GRACE_plot(C, 'Mar 2003');

%% plot differences 2003
figure;
subplot(2,1,1);
GRACE_plot(A-B, 'Jan - Feb 2003');
subplot(2,1,2);
GRACE_plot(B-C, 'Feb - Mar 2003');

%% plot differences 2015

