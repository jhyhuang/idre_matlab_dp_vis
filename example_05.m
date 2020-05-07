% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 5

% clear command window
clc; clear;

% load hdf5 data
fname = 'LA_Ventura_Counties.h5';
fname_info = h5info(fname);
Lat = h5read(fname,'/Lat'); % latitude
Lon = h5read(fname,'/Lon'); % longitude 
Elev = h5read(fname,'/Elev'); % elevation
HWY_lonlat = h5read(fname,'/HWY_lonlat'); % highway lon/lat
CB_lonlat = h5read(fname,'/CB_lonlat'); % county border lon/lat

% colormap (256 RGB)
cmap_elev = [27:(255-27)/31:255, 255:(102-255)/31:102; ...
             79:(255-79)/31:255, 255:(51-255)/31:51; ...
             53:(0-53)/63:0]'/255;

figure(5)
pcolor(Lon,Lat,Elev); shading flat; hold; % plot domain elevation
plot(HWY_lonlat(:,1),HWY_lonlat(:,2),'.r','LineWidth',3); % add highway
plot(CB_lonlat(:,1),CB_lonlat(:,2),'-b','LineWidth',3); % add county bolders
set(gca,'FontSize',14);
xlabel('Longitude','FontSize',20); ylabel('Latitude','FontSize',20);
legend('Elevation (m)','Highway','County border','FontSize',20,'Location','SouthWest');
colormap(cmap_elev);
h = colorbar; set(h,'FontSize',14);
title('Elevation of LA and Ventura counties','FontSize',22);

