% Matlab Data processing and Visualization workshop (IDRE, UCLA)
% Author: Jerry Huang
% Example 13

% clear command window
clc; clear;
opt = 2; % 1)Total confirmed cases; 2)Normalized by population

% load csv data from website
fname_in = ['us-states.csv']; % file name
fmt = ['%s %s %f %f %f']; % data format (date, state, fids, cases, deaths)
fid = fopen(fname_in,'rt'); % open file
ori_data = textscan(fid,fmt,'HeaderLines',1,'Delimiter',','); % scan data
clear fname_in fmt fid ans;

% load us population
fname_in = ['us-population.csv'];
fmt = ['%s %f']; % data format (state, population)
fid = fopen(fname_in,'rt'); % open file
population = textscan(fid,fmt,'HeaderLines',1,'Delimiter',','); % scan data
population = population{2}(:);
clear fname_in fmt fid ans;

% find date and states
all_dates = unique(ori_data{1}(:));
all_states = unique(ori_data{2}(:));

% arange data
confirmed_cases_tbl = zeros(length(all_states),length(all_dates)); 
for d = 1:length(all_dates)
  temp_date = all_dates{d};
  idx = find(strcmp(ori_data{1}(:),temp_date));
  temp_states = ori_data{2}(idx);
  confirmed_cases_tbl(ismember(all_states,temp_states),d) = ori_data{4}(idx);
  clear temp_date idx temp_states;
end
clear d ori_data;

% make animation figure
if (opt==1)
  fname_out = 'COVID-19_confirmed.gif';
else
  fname_out = 'COVID-19_normalized.gif';
end
num_frames = length(all_dates);
h = figure;
axis tight manual; % getframe returns a consistent size
hold on;
pause(3);
for d = 1:num_frames
  if (opt==1)
    temp_data = confirmed_cases_tbl(:,d);
  else
    temp_data = 100*confirmed_cases_tbl(:,d)./population;
  end
  [temp_asc,idx] = sort(temp_data,'ascend');
  barh(temp_asc,'FaceColor',[0.5 0.5 0.5],'EdgeColor','none');   
  barh(find(idx==5),temp_data(5),'FaceColor',[255,215,0]/255,'EdgeColor','none');
  barh(find(idx==34),temp_data(34),'FaceColor','b','EdgeColor','none');
  if d==num_frames
    if (opt==1)
      text(1.1*temp_asc,[1:length(all_states)],num2str(temp_asc),'FontSize',12);
    else
      text(1.1*temp_asc,[1:length(all_states)],num2str(temp_asc,'%.2f'),'FontSize',12);
    end
  end
  if (opt==1)
    set(gca,'xlim',[0 5e5],'ylim',[0 length(all_states)+1],'xscale','log');
    xlabel('Number of confirmed cases (log scale)','FontSize',16);
    title_text = ['Number of COVID-19 confirmed cases as of ' all_dates{d}];
  else
    set(gca,'xlim',[0 2],'ylim',[0 length(all_states)+1]);
    xlabel('Normalized by population (%)','FontSize',16);
    title_text = ['Normalized COVID-19 confirmed cases as of ' all_dates{d}];
  end
  set(gca,'YTick',[1:length(all_states)],'YTickLabel',all_states(idx),'FontSize',12);
  ylabel('States','FontSize',16);
  title(title_text,'FontSize',20); clear title_text;
  drawnow;  
  % getframe
  F(d) = getframe(h);
  im = frame2im(F(d));
  [imind,cm] = rgb2ind(im,256);  
  if d==1
    imwrite(imind,cm,fname_out,'gif','Loopcount',1);
  else
    imwrite(imind,cm,fname_out,'gif','DelayTime',0.1,'WriteMode','append');
  end
  clear temp_asc idx;
end
clear d;

