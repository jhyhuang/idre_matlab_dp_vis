% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 4

% clear command window
clc; clear;

% load Matlab demo wind data
load wind.mat;
Vel = (u.^2+v.^2+w.^2).^0.5; % velocity

% get domain range
xrange = [min(x(:)), max(x(:))];
yrange = [min(y(:)), max(y(:))];
zrange = [min(z(:)), max(z(:))];

figure(4)
% Velocity slice
% subplot(2,2,1) % pcolor
sel_z = 10;
subplot(2,2,1)
uv = (u.^2+v.^2).^0.5;
pcolor(x(:,:,sel_z),y(:,:,sel_z),uv(:,:,sel_z)); shading flat; hold;
set(gca,'xlim',xrange,'ylim',yrange,'clim',[min(uv(:)) max(uv(:))],'FontSize',14); colorbar;
set(gca,'XTickLabel','','YTickLabel','');
xlabel('X','FontSize',18); ylabel('Y','FontSize',18);
title('a) Velocity on a horizontal slice','FontSize',22);

subplot(2,2,2) % countourf+streamline
contourf(x(:,:,sel_z),y(:,:,sel_z),uv(:,:,sel_z),'Levels',2,'LineColor','none'); shading flat; hold;
h = streamslice(x(:,:,sel_z),y(:,:,sel_z),u(:,:,sel_z),v(:,:,sel_z));
set(h,'color','k'); clear h;
set(gca,'xlim',xrange,'ylim',yrange,'clim',[min(uv(:)) max(uv(:))],'FontSize',14); colorbar;
set(gca,'XTickLabel','','YTickLabel','');
xlabel('X','FontSize',18); ylabel('Y','FontSize',18);
title('b) Streamline on a horizontal slice','FontSize',22);
clear sel_z uv;

subplot(2,2,3) % 3D slices
xslice = mean(xrange);
yslice = mean(yrange);
zslice = 10;
slice(x,y,z,Vel,xslice,yslice,zslice,'cubic'); shading flat;
set(gca,'xlim',xrange,'ylim',yrange,'clim',[min(Vel(:)) max(Vel(:))],'FontSize',14); 
view([-45 50]);
xlabel('X','FontSize',18); ylabel('Y','FontSize',18); zlabel('Z','FontSize',18);
title('c) Velocity on 3D slices','FontSize',22);

subplot(2,2,4)
[sx,sy,sz] = meshgrid(xrange(1),yrange(1):5:yrange(2),zrange(1):3:zrange(2));
h = streamtube(x,y,z,u,v,w,sx,sy,sz); set(h,'EdgeColor','none');
set(gca,'xlim',xrange,'ylim',yrange,'FontSize',14);
view([-45 50]);
xlabel('X','FontSize',18); ylabel('Y','FontSize',18); zlabel('Z','FontSize',18);
title('d) Streamtube view','FontSize',22);
axis on; grid on;
light; lighting flat; camlight('left');
colormap jet;
