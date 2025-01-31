%% Plots the RMSD over time placing replicas of each state and condition on the same graph
 
clear
clc
close all

% Choose which data you want to plot and the root folder
% 2 = residue 123, 3 = residue 126, 4 = residue 127, 5 = residue 335
DataColumn = 5;
root1=".\ManganeseVsMagnesium_EQ_MD\States\";


% Work code
openfile = "DistanceADMIDAS_all"; %
states =  ["1" "2" "3" "4" "5" "6" "7" "8"] ;
subfolder= ["1" "5"];
replicas=string(1:25);
time=1200;
if DataColumn == 2
    atom = string(123);
elseif DataColumn == 3
    atom = string(126);
elseif DataColumn == 4
    atom = string(127);
elseif DataColumn == 5
    atom = "M335";
end
for state=1:length(states)
    for conditions = 1:length(subfolder)
        figure
        hold on
        for replica=1:length(replicas)
            yall=strcat(root1,'state',states{state},'\',subfolder(conditions),'\replica',replicas(replica));
            if isfolder(yall)
                cd(yall); %move to directory
                fullFilename = fullfile(strcat(openfile,'.dat')); %
                if isfile(fullFilename) 
                    s = dir(fullFilename);
                    filesize = s.bytes;
                    if filesize > 40000
                        dataall = readmatrix(fullFilename);
                        plot(dataall(:,1)*.25,dataall(:,2)/10) 
                    end
                end
            end
        end
        fontsize(12,'points')
        yAX = get(gca,'YAxis');
        set(yAX,'FontSize', 10)
        ylabel({'ADMIDAS_{ion}';['to ',char(atom),' (nm)']},'interpreter','tex','fontsize', 10)
        xlabel('Time (ns)','fontsize', 12);
        set(gcf, 'Units', 'Inches', 'Position', [1, 1, 2.965, 1.5])
        yticks([0.5 1 1.5 2 2.5 3 3.5 4])
        ylim([0 4])
        set(gcf,'PaperPositionMode','auto')
        hold off
        walkername = fullfile(strcat(root1, 'FigS2_127ADMIDAS_',subfolder(conditions)));
        print(walkername, '-r600', '-dpng')
    end
end
