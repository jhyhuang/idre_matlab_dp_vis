% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 12

% clear command window
clc; clear;

% load data from Kings
fname_in = 'Kings.mat';
load(fname_in); clear fname_in;
Snow = Snow/1000; % mm -> m
Snow(Snow<=0.5) = NaN;

% design colormap
cmap_elev = [27:(255-27)/31:255, 255:(102-255)/31:102; ...
             79:(255-79)/31:255, 255:(51-255)/31:51; ...
             53:(0-53)/63:0]'/255;
cmap_snow = load('Snow_color.csv');
cmap_snow = cmap_snow/255;
crange_elev = [0 4400];
crange_snow = [0 2];

figure(12)
ax1 = subplot(2,2,1); % elev
pcolor(Lon,Lat,Elev); shading flat;
set(gca,'xlim',[-119.75 -118.30],'ylim',[36.55 37.25],'clim',crange_elev,'FontSize',14);
xlabel('Longitude','FontSize',20); ylabel('Latitude','FontSize',20);
title('a) Elevation (m)','FontSize',22);
colormap(ax1,cmap_elev); colorbar;

ax2 = subplot(2,2,2); % snow
pcolor(Lon,Lat,Snow); shading flat;
set(gca,'xlim',[-119.75 -118.30],'ylim',[36.55 37.25],'clim',crange_snow,'FontSize',14);
xlabel('Longitude','FontSize',20); ylabel('Latitude','FontSize',20);
title('b) Snow depth (m)','FontSize',22);
colormap(ax2,cmap_snow); colorbar;
clear ax1 ax2;

% combine two axes
ax1 = subplot(2,2,3);
pcolor(Lon,Lat,Elev); shading flat; % elev
set(gca,'xlim',[-119.75 -118.30],'ylim',[36.55 37.25],'clim',crange_elev,'FontSize',14);
xlabel('Longitude','FontSize',20); ylabel('Latitude','FontSize',20);
title('c) Combination','FontSize',22);
ax1_pos = get(ax1,'Position');
ax1_pos(1) = ax1_pos(1)+0.22; % shift position
ax2 = axes;
pcolor(Lon,Lat,Snow); shading flat; % snow
set(gca,'xlim',[-119.75 -118.30],'ylim',[36.55 37.25],'XTick','','YTick','','clim',crange_snow);
% Link two axes
linkaxes([ax1 ax2]);
set(ax2,'Color','none','Visible','off');
colormap(ax1,cmap_elev); colormap(ax2,cmap_snow);
set([ax1,ax2],'Position',ax1_pos);

