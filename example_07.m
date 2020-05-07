% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 7

% clear command window
clc; clear;

% load csv data from website
fname_in = 'Covid19_Cal_NY.mat'; % file name
load(fname_in);

% cumulative difference
Cal_cases_daily = [[0, 0]; diff(Cal_cases)];
NY_cases_daily = [[0, 0]; diff(NY_cases)];

% correlation
CC_Cal_cases = corrcoef(Cal_cases_daily(:,1),Cal_cases_daily(:,2));
CC_Cal_cases = CC_Cal_cases(1,2);
CC_NY_cases = corrcoef(NY_cases_daily(:,1),NY_cases_daily(:,2));
CC_NY_cases = CC_NY_cases(1,2);

% moving mean
moving_days = 5;
Cal_cases_movingmean = movmean(Cal_cases_daily,moving_days);
NY_cases_movingmean = movmean(NY_cases_daily,moving_days);

% increasing rate
Dif_Cal_cases_daily = [[0, 0]; diff(Cal_cases_daily)];
Dif_NY_cases_daily = [[0, 0]; diff(NY_cases_daily)];

% figure
figure(7)
subplot(2,1,1)
x = [1:length(Cal_cases_movingmean)];
bar(x,Cal_cases_daily(:,1)); hold; grid on;
bar(x,Cal_cases_daily(:,2));
plot(x,Cal_cases_movingmean,'-o','LineWidth',3);
set(gca,'xlim',[1 length(Cal_dates)],'XTick',[1:2:length(Cal_dates)], ...
    'XTicklabel',Cal_dates(1:2:end),'FontSize',14);
xtickangle(45);
legend('Confirmed cases','Deaths','5days mean','FontSize',20,'Location','NorthWest')
title_text = ['a) Daily COVID-19 cases in California'];
title(title_text,'FontSize',22);

subplot(2,1,2)
temp = Dif_Cal_cases_daily(:,1);
temp_pos = Dif_Cal_cases_daily(:,1)>=0; 
temp_neg = Dif_Cal_cases_daily(:,1)<0;
bar(x(temp_pos),temp(temp_pos),'r','EdgeColor','none'); hold;
bar(x(temp_neg),temp(temp_neg),'FaceColor',[0 0.5 0],'EdgeColor','none');
plot(x,Dif_Cal_cases_daily(:,2),'-o','LineWidth',3);
grid on;
set(gca,'xlim',[1 length(Cal_dates)],'XTick',[1:2:length(Cal_dates)], ...
    'XTicklabel',Cal_dates(1:2:end),'FontSize',14);
xtickangle(45);
legend('Confirmed cases increases','Confirmed cases decreases','Deaths', ...
       'FontSize',20,'Location','NorthWest')
title_text = ['b) Compare with previous day'];
title(title_text,'FontSize',22);
