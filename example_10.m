% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 10

% clear command window
clc; clear;

% load data
fname_in = 'Covid19_Cal_NY.mat'; % file name
load(fname_in,'Cal_dates','Cal_cases'); % only load data in California
Cal_confirmed = Cal_cases(:,1);
Cal_death = Cal_cases(:,2); clear Cal_cases;
x = [1:length(Cal_dates)]';

% Polynomial fitting
% P(x) = a(n)*X^n+a(n-1)*X^(n-1)+a(n-2)*X^(n-2)+...+a(1)*X+a(0)
PnF1 = polyfit(x,Cal_confirmed,1); % power = 1
PnF2 = polyfit(x,Cal_confirmed,2); % power = 2 
PnF3 = polyfit(x,Cal_confirmed,3); % power = 3
PnF4 = polyfit(x,Cal_confirmed,4); % power = 4

% Curve function fitting
% Fit with designed functions
CF_poly2 = fit(x,Cal_confirmed,'poly2'); % Quadratic polynomial
CF_exp1 = fit(x,Cal_confirmed,'exp1'); % exponential
CF_spline = fit(x,Cal_confirmed,'smoothingspline'); % Splin

figure(10)
subplot(2,1,1)
plot(x,Cal_confirmed,'ok','MarkerSize',8,'MarkerFaceColor','k'); hold; grid;
plot(x,polyval(PnF1,x),'-r','LineWidth',2);
plot(x,polyval(PnF2,x),'-b','LineWidth',2');
plot(x,polyval(PnF3,x),'-','Color',[0 0.5 0],'LineWidth',2);
plot(x,polyval(PnF4,x),'-c','LineWidth',2);
set(gca,'xlim',[1 length(Cal_confirmed)],'XTick',[1:2:length(Cal_dates)],'XTicklabel','','FontSize',14);
xtickangle(45);
xlabel(''); ylabel('Number of cases','FontSize',20);
legend('Original data','PnF P1','PnF P2','PnF P3','PnF P4','FontSize',20,'Location','NorthWest');
title_text = ['a) COVID-19 confirmed cases in California (Polynomail fitting)'];
title(title_text,'FontSize',22);

subplot(2,1,2)
plot(x,Cal_confirmed,'ok','MarkerSize',8,'MarkerFaceColor','k'); hold; grid;
h = plot(CF_poly2,'r'); set(h,'LineWidth',2);
h = plot(CF_exp1,'b'); set(h,'LineWidth',2);
h = plot(CF_spline); set(h,'Color',[0 0.5 0],'LineWidth',2);
set(gca,'xlim',[1 length(Cal_confirmed)],'XTick',[1:2:length(Cal_dates)], ...
    'XTicklabel',Cal_dates(1:2:end),'FontSize',14);
xtickangle(45);
xlabel(''); ylabel('Number of cases','FontSize',20);
legend('Original data','CF Poly2','CF Exp','CF Spline','FontSize',20,'Location','NorthWest');
title_text = ['b) COVID-19 confirmed cases in California (Curve fitting)'];
title(title_text,'FontSize',22);


