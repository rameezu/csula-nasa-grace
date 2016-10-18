clear
close all

% import GRACE datasets
% 2003
[A, ~, ~] = GRACE_import('GRCTellus.CSR.20030117.LND.RL05.DSTvSCS1409.tif');
[B, ~, ~] = GRACE_import('GRCTellus.CSR.20030215.LND.RL05.DSTvSCS1409.tif');
[C, ~, ~] = GRACE_import('GRCTellus.CSR.20030317.LND.RL05.DSTvSCS1409.tif');
% 2015
[X, ~, ~] = GRACE_import('GRCTellus.CSR.20150123.LND.RL05.DSTvSCS1409.tif');
[Y, ~, ~] = GRACE_import('GRCTellus.CSR.20150215.LND.RL05.DSTvSCS1409.tif');
[Z, ~, ~] = GRACE_import('GRCTellus.CSR.20150317.LND.RL05.DSTvSCS1409.tif');

%% plot single datasets 2003
figure;
subplot(3,1,1);
GRACE_plot(A, 'Jan 2003');
subplot(3,1,2);
GRACE_plot(B, 'Feb 2003');
subplot(3,1,3);
GRACE_plot(C, 'Mar 2003');

%% plot single datasets 2015
figure;
subplot(3,1,1);
GRACE_plot(X, 'Jan 2015');
subplot(3,1,2);
GRACE_plot(Y, 'Feb 2015');
subplot(3,1,3);
GRACE_plot(Z, 'Mar 2015');

%% plot differences 2003
figure;
subplot(2,1,1);
GRACE_plot(A-B, 'Jan - Feb 2003 (CSR)');
subplot(2,1,2);
GRACE_plot(B-C, 'Feb - Mar 2003 (CSR)');

%% plot differences 2015
figure;
subplot(2,1,1);
GRACE_plot(X-Y, 'Jan - Feb 2015 (CSR)');
subplot(2,1,2);
GRACE_plot(Y-Z, 'Feb - Mar 2015 (CSR)');

