% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 11

% clear command window
clc; clear;

% load Matlab demo MRI image
% Data includes 27 128-by-128 horizontal slices
load mri; % D: data; map: colormap; siz: data size

% Select 4 hoizontal slices for figure(11) 
sel_hor_slices = [1:7:27];
sel_hor_images = squeeze(D(:,:,1,sel_hor_slices));

figure(11)
for k = 1:length(sel_hor_slices)
  temp = squeeze(sel_hor_images(:,:,k));
  ax = subplot(3,4,k); % upper row using colormap jet
  pcolor(temp); shading flat; axis square;
  set(gca,'XTick','','YTick','');
  text(10,10,['Slice #' num2str(sel_hor_slices(k))],'color','w','FontSize',16);
  colormap(ax,'jet');
  
  ax = subplot(3,4,k+4); % lower row using colormap gray
  temp = squeeze(sel_hor_images(:,:,k));
  pcolor(temp); shading flat; axis square;
  set(gca,'XTick','','YTick','');
  text(10,10,['Slice #' num2str(sel_hor_slices(k))],'color','w','FontSize',16);
  colormap(ax,map);
end
clear k;

