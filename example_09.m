% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 9

% clear command window
clc; clear;

% load csv data from website
fname_in = 'Covid19_Cal_NY.mat'; % file name
load(fname_in,'Cal_dates','Cal_cases'); % only load data in California

% generate some outlier data index
num_outlier = 10;
% ol_idx_gen = 0+rand(1,num_outlier)*(length(Cal_cases)-0); % generate 10 missing data
% ol_idx_gen = sort(round(ol_idx_gen)); % make idx as integers and sort them
ol_idx_gen = [8,11,15,18,22,32,38,43,44,60];

% apply outlier data to the original data
Cal_cases = Cal_cases(:,2); % only death data
Cal_cases_outlier = Cal_cases;
Cal_cases_outlier(ol_idx_gen) = 5*Cal_cases(ol_idx_gen);
  
% check outliers
find_method_1 = 'median';
ol_idx_m1 = find(isoutlier(Cal_cases_outlier,find_method_1));
find_method_2 = 'mean';
ol_idx_m2 = find(isoutlier(Cal_cases_outlier,find_method_2));
find_method_3 = 'quartiles';
ol_idx_m3 = find(isoutlier(Cal_cases_outlier,find_method_3));
 
% fill outliers
fill_method_1 = 'previous';
Cal_cases_previous_median = filloutliers(Cal_cases_outlier,fill_method_1,find_method_1);
fill_method_2 = 'linear';
Cal_cases_linear_median = filloutliers(Cal_cases_outlier,fill_method_2,find_method_1);
fill_method_3 = 'spline';
Cal_cases_spline_median = filloutliers(Cal_cases_outlier,fill_method_3,find_method_1);
 
figure(9)
subplot(2,1,1)
plot(Cal_cases,'-ok','MarkerSize',10); hold;
plot(ol_idx_gen,Cal_cases_outlier(ol_idx_gen),'or','MarkerSize',10);
plot(ol_idx_m1,Cal_cases_outlier(ol_idx_m1),'^k','MarkerSize',10,'MarkerFaceColor','k');
plot(ol_idx_m2,Cal_cases_outlier(ol_idx_m2),'vk','MarkerSize',10,'MarkerFaceColor','k'); 
plot(ol_idx_m3,Cal_cases_outlier(ol_idx_m3),'*k','MarkerSize',10,'MarkerFaceColor','k');
set(gca,'xlim',[1 length(Cal_cases)],'ylim',[0 max(Cal_cases_outlier)+100], ...
    'XTick',[1:2:length(Cal_dates)],'XTickLabel',Cal_dates(1:2:end),'FontSize',14);
xtickangle(45);
ylabel('Number of cases','FontSize',20);
legend('Original data','Outliers generated','Outliers found by "median"', ...
       'Outliers found by "mean"','Outliers found by "quartiles"','FontSize',20,'Location','NorthWest');
title_text = ['a) COVID-19 deaths in California'];
title(title_text,'FontSize',22);

subplot(2,1,2)
plot(Cal_cases,'-ok','MarkerSize',10); hold;
plot(ol_idx_gen,Cal_cases_outlier(ol_idx_gen),'or','MarkerSize',10);
plot(Cal_cases_previous_median,'-r','LineWidth',2,'MarkerSize',10);
plot(Cal_cases_linear_median,'-b','LineWidth',2,'MarkerSize',10);
plot(Cal_cases_spline_median,'-','Color',[0 0.5 0],'LineWidth',2,'MarkerSize',10);
set(gca,'xlim',[1 length(Cal_cases)],'ylim',[0 max(Cal_cases_outlier)+100], ...\
    'XTick',[1:2:length(Cal_dates)],'XTicklabel',Cal_dates(1:2:end),'FontSize',14);
xtickangle(45);
ylabel('Number of cases','FontSize',20);
legend('Original data','Outliers generated','Outliers replaced by "previous"','Outliers replaced by "linear"', ...
       'Outliers replaced by "spline"','FontSize',20,'Location','NorthWest');
title_text = ['b) COVID-19 deaths in California'];
title(title_text,'FontSize',22);

