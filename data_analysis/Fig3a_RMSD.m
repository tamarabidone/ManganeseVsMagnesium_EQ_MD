close all
clear
clc
% change the first 2 variables to match your needs

% change the outpath to where you want the figure written out to
outputpath=".\ManganeseVsMagnesium_EQ_MD\States\";

% data input by hand in data1 variable
data1 = [NaN,0.311,0.347,0.375,0.389,0.471,1,1.24; NaN,NaN,0.351,0.379,0.394,0.349,0.925,1.222;NaN,NaN,NaN,0.18,0.195,0.416,0.972,1.235;
    NaN,NaN,NaN,NaN,0.134,0.424,0.976,1.238;NaN,NaN,NaN,NaN,NaN,0.429,0.974,1.235;NaN,NaN,NaN,NaN,NaN,NaN,0.812,1.128;
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,1.024;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];


% work code
% save the angstrom symbol
Ang= char(197);
% create the figure
figure
% populate the figure
h=imagesc(data1);
% edit how things look in the figure
 % show nan as white values on figure
set(h, 'AlphaData', ~isnan(data1))
set(gca,'fontsize',10)
set(gca,'YDir','normal')
xticks([1 2 3 4 5 6 7 8])
yticks([1 2 3 4 5 6 7 8])
% label the axes
xlabel('Starting State','fontsize',12)
ylabel('Starting State','fontsize',12)
a=colorbar;
% label the colorbar
ylabel(a,strcat('RMSD (',Ang,')'))
% set the colorbar tick marks
set(a,'YTick',[0 0.4 0.8 1.2 1.6 2.0 2.4 2.8 3.2])
% set the limit for the colorbar
clim([0 3.2])
% set the figure size
set(gcf, 'Units', 'Inches', 'Position', [1, 1, 3.3, 1.5])
% create the filename
walkername = fullfile(strcat(outputpath,'Fig3a_RMSD'));
% print the graph as a png
print(walkername,'-r600','-dpng')