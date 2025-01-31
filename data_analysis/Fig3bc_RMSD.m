close all
clear
clc
% Edit the first two variables.

% add in to the beginning of the root path where your data files are kept.
root1=".\ManganeseVsMagnesium_EQ_MD\States\";

% which set of data do you want to plot first? 1=Mg/Ca 5=Mn. paste the
% appropriate comment into the variable
whichfile="state*_5*5_ClosestDistance.xvg"  ; %"state*_5*5_ClosestDistance.xvg" or "state*_1*1_ClosestDistance.xvg"


% work code
if whichfile == "state*_1*1_ClosestDistance.xvg"
    subfolder = "MgCa";
else
    subfolder = "Mn";
end
states =  ["1" "2" "3" "4" "5" "6" "7" "8"] ;
Ang= char(197);
for state=1:length(states)
    for conditions = 1:length(subfolder)
        yall=strcat(root1,'state',states{state},'\',subfolder(conditions));
        if isfolder(yall)
            cd(yall); %move to directory
            filenames1 = cellstr(ls(whichfile));
            for state2=1:size(filenames1,1)
                datamatrix = readmatrix(filenames1{state2},'FileType', 'text', 'NumHeaderLines', 18);
                dataall(state,state2) = datamatrix(1,5);
            end
        end
    end
end
% remove duplicate entries and replace with NaN to plot the white spaces
row=1:8;
for col=1:8
    dataall(row,col)=NaN;
    row=row(2:end);
end
% create the figure and make it look good.
figure
h=imagesc(dataall*10);
set(h, 'AlphaData', ~isnan(dataall*10))
set(gca,'fontsize',10)
set(gca,'YDir','normal')
xticks([1 2 3 4 5 6 7 8])
yticks([1 2 3 4 5 6 7 8])
xlabel('State Ensemble','fontsize',12)
ylabel('Rep. State','fontsize',12)
a=colorbar;
ylabel(a,strcat('RMSD (',Ang,')'))
set(a,'YTick',[0.0 0.4 0.8 1.2 1.6 2.0 2.4 2.8 3.2])
clim([0 3.2])
set(gcf, 'Units', 'Inches', 'Position', [1, 1, 3.3, 1.5])
% create the filename and print out the figure as a .png file
walkername = fullfile(strcat(root1,'Fig3_RMSD_',subfolder));
print(walkername,'-r600','-dpng')
