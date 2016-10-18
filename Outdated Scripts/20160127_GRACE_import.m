function [ X, cmap, R ] = GRACE_import( filename )
%GRACE_import Imports a GRACE geotiff data file

[X, cmap, R] = geotiffread(filename);

X = double(X);

X(X < -99.9990) = NaN;

end

