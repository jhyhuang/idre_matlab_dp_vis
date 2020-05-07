% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 6

% clear command window
clc; clear;

% load data
fname = 'windData.mat'; % Matlab built-in wind data example
load(fname,'direction','humidity','speed'); % select variables to load
direction = double(direction); % change data from int to double precision
speed = double(speed);
humidity = double(humidity);

% Basic data processing
% statistics
speed_stat = [min(speed),mean(speed),max(speed),std(speed)];
humidity_stat = [min(humidity),mean(humidity),max(humidity),std(humidity)];

figure(6)
subplot(2,2,1)
plot(speed,'-r','LineWidth',2); hold;
plot(movmean(speed,5),'-*','Color',[0 0.5 0],'LineWidth',3)
plot(find(speed==speed_stat(1),1),speed_stat(1),'ok','MarkerSize',10);
plot(find(speed==speed_stat(3),1),speed_stat(3),'ok','MarkerFaceColor','k','MarkerSize',10);
line([1 length(speed)],[speed_stat(2) speed_stat(2)],'LineWidth',2,'LineStyle','-','Color','k');
line([1 length(speed)],[speed_stat(2)+speed_stat(4) speed_stat(2)+speed_stat(4)], ...
    'LineWidth',2,'LineStyle','--','Color','k');
line([1 length(speed)],[speed_stat(2)-speed_stat(4) speed_stat(2)-speed_stat(4)], ...
    'LineWidth',2,'LineStyle','-.','Color','k');
set(gca,'xlim',[1 length(speed)],'ylim',[0 speed_stat(3)+2],'FontSize',16);
xlabel('Samples','FontSize',18); ylabel('Speed (m/s)','FontSize',18); 
legend('Speed','Moving mean','Min','Max','Mean','Mean+SD','Mean-SD','FontSize',18,'Location','NorthEast');
title('a) Wind speed record','FontSize',22);

subplot(2,2,2)
plot(humidity,'-b','LineWidth',2); hold;
plot(find(humidity==humidity_stat(1),1),humidity_stat(1),'ok','MarkerSize',8);
plot(find(humidity==humidity_stat(3),1),humidity_stat(3),'ok','MarkerFaceColor','k','MarkerSize',8);
line([1 length(humidity)],[humidity_stat(2) humidity_stat(2)],'LineWidth',2,'LineStyle','-','Color','k');
line([1 length(humidity)],[humidity_stat(2)+humidity_stat(4) humidity_stat(2)+humidity_stat(4)], ...
     'LineWidth',2,'LineStyle','--','Color','k');
line([1 length(humidity)],[humidity_stat(2)-humidity_stat(4) humidity_stat(2)-humidity_stat(4)], ...
     'LineWidth',2,'LineStyle','--','Color','k');
set(gca,'xlim',[1 length(speed)],'ylim',[0 100],'FontSize',14);
xlabel('Samples','FontSize',18); ylabel('Humidity (%)','FontSize',18); 
legend('Humidity','Min','Max','Mean','Mean+SD','Mean-SD','FontSize',16,'Location','NorthWest');
title('b) Humidity record','FontSize',22);

subplot(2,2,3)
plot(speed,'-r','LineWidth',2); hold;
plot(humidity,'-.b','LineWidth',2);
set(gca,'xlim',[1 length(speed)],'FontSize',14);
xlabel('Samples','FontSize',18); ylabel('Speed (m/s) / Humidity (%)','FontSize',18);
legend('Speed','Humidity','FontSize',16,'Location','NorthWest');
title('c) Combined data (I)','FontSize',22);

subplot(2,2,4)
yyaxis left;
plot(speed,'-r','LineWidth',2); hold; 
set(gca,'xlim',[1 length(speed)],'ylim',[0 speed_stat(3)+2],'FontSize',16);
ylabel('Speed (m/s)','FontSize',18); 
yyaxis right;
plot(humidity,'-.','Color','b','LineWidth',2); 
set(gca,'xlim',[1 length(speed)],'ylim',[0 100],'FontSize',16);
xlabel('Samples','FontSize',18); ylabel('Humidity (%)','FontSize',18);
ax = gca;
ax.YAxis(1).Color = 'r'; ax.YAxis(2).Color = 'b';
legend('Speed','Humidity','FontSize',18,'Location','NorthEast');
title('d) Combined data (II)','FontSize',22);


