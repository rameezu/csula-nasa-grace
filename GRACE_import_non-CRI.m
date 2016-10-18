%GRACE_import Imports the GRACE Mascon processed data

% directories
grace_dir = ['/Users/aarontrefler_temp2/Documents/Work : Education/',...
'Education/School_Post_UCLA/CSULA/NASA-STEM JPL/GRACE/'];
data_dir = [grace_dir, 'Data/Raw/Mascon/non-CRI/netcdf/'];
save_dir = [grace_dir, 'Data/Processed/'];

%files
mascon_file = 'GRCTellus.JPL.200204_201504.GLO.RL05M_1.MSCNv01.nc';
land_mask_file = 'LAND_MASK.CRIv01.nc';

% read variables from Mascon and land mask datafiles
lat = ncread([data_dir, mascon_file], 'lat');
lon = ncread([data_dir, mascon_file], 'lon');
time = ncread([data_dir, mascon_file], 'time');
lwe_thickness =  ncread([data_dir, mascon_file], 'lwe_thickness');
uncertainty = ncread([data_dir, mascon_file], 'uncertainty');
land_mask = ncread([data_dir, land_mask_file], 'land_mask');

% save
save([save_dir, mascon_file, '.mat'],...
    'lat', 'lon', 'time', 'lwe_thickness', 'uncertainty');
save([save_dir, land_mask_file, '.mat'], 'land_mask');
