% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 8

% clear command window
clc; clear;

% load csv data from website
fname_in = 'Covid19_Cal_NY.mat'; % file name
load(fname_in,'Cal_dates','Cal_cases'); % only load data in California

% generate some random missing data
num_missing = 10;
% md_idx = 0+rand(1,num_missing)*(length(Cal_cases)-0); % generate 10 missing data
% md_idx = sort(round(md_idx)); % make idx as integers and sort them
md_idx = [8,11,15,18,22,32,38,43,44,60];


% apply missing data to the original data
Cal_cases_missing = Cal_cases;
Cal_cases_missing(md_idx,:) = NaN;

% fill missing
fm_method_1 = 'previous';
Cal_cases_previous = fillmissing(Cal_cases_missing,fm_method_1);
fm_method_2 = 'linear';
Cal_cases_linear = fillmissing(Cal_cases_missing,fm_method_2);
fm_method_3 = 'spline';
Cal_cases_spline = fillmissing(Cal_cases_missing,fm_method_3);

% Calculate averaged difference
dPrevious_Original = abs(sum(Cal_cases_previous-Cal_cases))/num_missing;
dLinear_Original = abs(sum(Cal_cases_linear-Cal_cases))/num_missing;
dSpline_Original = abs(sum(Cal_cases_spline-Cal_cases))/num_missing;

figure(8)
x = [1:length(Cal_cases)];
for c = 1:2
  subplot(2,1,c)
  plot(x,Cal_cases_missing(:,c),'ok','MarkerFaceColor','k','MarkerSize',10); hold; grid on;
  plot(x,Cal_cases_previous(:,c),'-r','LineWidth',2);
  plot(Cal_cases_linear(:,c),'-b','LineWidth',2,'MarkerSize',10);
  plot(x,Cal_cases_spline(:,c),'-','Color',[0 0.5 0],'LineWidth',2);
  qx = [md_idx; md_idx]; 
  qy = [Cal_cases(md_idx,c)'+0.15*(max(Cal_cases(:,c))); Cal_cases(md_idx,c)'+0.05*(max(Cal_cases(:,c)))];
  line(qx,qy,'Color','k','LineWidth',1);
  plot(qx(2,:),qy(2,:),'v','color','k','MarkerFaceColor','k','MarkerSize',8);
  clear qx qy;
  set(gca,'xlim',[1 length(Cal_cases(:,c))],'XTick',[1:2:length(Cal_dates)], ...
      'XTicklabel',Cal_dates(1:2:end),'FontSize',14);
  xtickangle(45);
  ylabel('Number of cases','FontSize',20);
  temp1 = ['Fill method: "previous" (avg \Delta=' num2str(dPrevious_Original(c)) ')'];
  temp2 = ['Method: linear (avg \Delta=' num2str(dLinear_Original(c)) ')'];
  temp3 = ['Fill method: "spline" (avg \Delta=' num2str(dSpline_Original(c)) ')'];
  legend('Original',temp1,temp2,temp3,'FontSize',20,'Location','NorthWest');
  if (c==1)
    title_text = ['a) COVID-19 confirmed cases in California'];
  else
    title_text = ['b) COVID-19 deaths in California'];
  end
  title(title_text,'FontSize',22);
end
