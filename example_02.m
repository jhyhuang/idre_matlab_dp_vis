% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 2

% clear command window
clc; clear;

% Import count.dat file
load count.dat; % Matlab internal dataset example

% figures
figure(2)
plot(count,'-o','LineWidth',2,'MarkerSize',8); grid on;
set(gca,'FontSize',14);
xlabel('Time','FontSize',20);
ylabel('Vehicle count','FontSize',20);
legend('Location 1','Location 2','Location 3','Location','NorthWest','FontSize',20);
title('Traffic counts at three intersections','FontSize',22);
