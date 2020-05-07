% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 3

% clear command window
clc; clear;

% load csv data from website
fname_in = ['us-states.csv']; % file name
% website address
url = ['https://raw.githubusercontent.com/nytimes/covid-19-data/master/' fname_in]; 
websave(fname_in,url); % save file to local drive
fmt = ['%s %s %f %f %f']; % data format (date, state, fids, confirmed cases, deaths)
fid = fopen(fname_in,'rt'); % open file
ori_data = textscan(fid,fmt,'HeaderLines',1,'Delimiter',','); % scan data text
clear url fname_in fmt fid ans;
 
% arrange data
all_dates = unique(ori_data{1}(:)); % get unique dates in data series
all_states = unique(ori_data{2}(:)); % get unique state name in data series

% figure
figure(3)
% select data
subplot(1,2,1) % state data in the last day
sel_date = all_dates{end}; % select the last day 
sel_idx = find(strcmp(ori_data{1}(:),sel_date)==1); 
sel_states = ori_data{2}(sel_idx); % states 
sel_confirmed_data = [ori_data{4}(sel_idx), ori_data{5}(sel_idx)]; % confirmed case, deaths
clear sel_idx;
% horizontal bar plot
barh(sel_confirmed_data,'EdgeColor','none'); hold;
set(gca,'Xscale','log','YTick',[1:length(sel_states)],'YTickLabel',sel_states,'FontSize',14);
xlabel('Number of confirmed cases (log scale)','FontSize',20);
ylabel('States','FontSize',20);
legend('Confirmed cases','Deaths','FontSize',20);
title_text = ['a) COVID-19 confirmed cases and deaths as of ' sel_date];
title(title_text,'FontSize',22);
clear sel_date sel_states sel_confirmed_data Cal_idx NY_idx title_text ax; 

% select California and New York
NY_idx = find(strcmp(ori_data{2}(:),'New York')); % New York
NY_dates = ori_data{1}(NY_idx);
NY_cases = [ori_data{4}(NY_idx), ori_data{5}(NY_idx)];
NY_cases_7days = movmean(NY_cases,7); % 7 days move mean
Cal_idx = find(strcmp(ori_data{2}(:),'California')); % California
Cal_dates = ori_data{1}(Cal_idx);
Cal_cases = [ori_data{4}(Cal_idx), ori_data{5}(Cal_idx)];
temp = find(strcmp(Cal_dates,NY_dates(1))); % find the date NY case starts
Cal_dates = Cal_dates(temp:end);
Cal_cases = Cal_cases(temp:end,:);
Cal_cases_7days = movmean(Cal_cases,7); % 7 days move mean

% save California data for later use
fnameout = 'Covid19_Cal_NY.mat';
save(fnameout,'Cal_dates','Cal_cases','NY_dates','NY_cases');

subplot(2,2,2) % barplot of California
bar(Cal_cases); hold;
plot([1:length(Cal_cases_7days)],Cal_cases_7days,'-o','LineWidth',2);
set(gca,'XTick',[1:2:length(Cal_dates)],'XTicklabel',Cal_dates(1:2:end),'Yscale','log','FontSize',12);
xtickangle(45)
ylabel('Number of confirmed cases (log scale)','FontSize',16); 
legend('Confirmed cases','Deaths','7days mean','Location','NorthWest','FontSize',18);
title_text = ['b) COVID-19 confirmed cases in California'];
title(title_text,'FontSize',22);

subplot(2,2,4) % barplot of NY 
bar(NY_cases); hold;
plot([1:length(NY_cases_7days)],NY_cases_7days,'-o','LineWidth',2);
set(gca,'XTick',[1:2:length(NY_dates)],'XTicklabel',NY_dates(1:2:end),'Yscale','log','FontSize',12);
xtickangle(45)
ylabel('Number of confirmed cases (log scale)','FontSize',16); 
title_text = ['c) COVID-19 confirmed cases in New York'];
title(title_text,'FontSize',22);

