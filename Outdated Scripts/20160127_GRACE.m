clear
close all

%% Winter Months
% import GRACE datasets 2003
[JAN, ~, ~] = GRACE_import('GRCTellus.JPL.20030117.LND.RL05_1.DSTvSCS1411.tif');
[FEB, ~, ~] = GRACE_import('GRCTellus.JPL.20030215.LND.RL05_1.DSTvSCS1411.tif');
[MAR, ~, ~] = GRACE_import('GRCTellus.JPL.20030317.LND.RL05_1.DSTvSCS1411.tif');

% plot
figure;
subplot(3,1,1);
GRACE_plot(JAN, 'Jan 2003');
subplot(3,1,2);
GRACE_plot(FEB, 'Feb 2003');
subplot(3,1,3);
GRACE_plot(MAR, 'Mar 2003');

%% All Months
% import GRACE datasets 2003
[JAN, ~, ~] = GRACE_import('GRCTellus.JPL.20030117.LND.RL05_1.DSTvSCS1411.tif');
[FEB, ~, ~] = GRACE_import('GRCTellus.JPL.20030215.LND.RL05_1.DSTvSCS1411.tif');
[MAR, ~, ~] = GRACE_import('GRCTellus.JPL.20030317.LND.RL05_1.DSTvSCS1411.tif');
[APR, ~, ~] = GRACE_import('GRCTellus.JPL.20030416.LND.RL05_1.DSTvSCS1411.tif');
[MAY, ~, ~] = GRACE_import('GRCTellus.JPL.20030512.LND.RL05_1.DSTvSCS1411.tif');
% no June data file
[JUL, ~, ~] = GRACE_import('GRCTellus.JPL.20030717.LND.RL05_1.DSTvSCS1411.tif');
[AUG, ~, ~] = GRACE_import('GRCTellus.JPL.20030817.LND.RL05_1.DSTvSCS1411.tif');
[SEP, ~, ~] = GRACE_import('GRCTellus.JPL.20030916.LND.RL05_1.DSTvSCS1411.tif');
[OCT, ~, ~] = GRACE_import('GRCTellus.JPL.20031017.LND.RL05_1.DSTvSCS1411.tif');
[NOV, ~, ~] = GRACE_import('GRCTellus.JPL.20031116.LND.RL05_1.DSTvSCS1411.tif');

% plot
rows = 4;
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
subplot(rows,cols,3);
GRACE_plot(DEC, 'Dec 2003');