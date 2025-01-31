% Note: 

clear
clc
close all

% fill in the rest of the root folders path
root1=".\ManganeseVsMagnesium_EQ_MD\States\";


folders1 = ["state1" "state2" "state3" "state4" "state5" "state6" "state7" "state8"] ;
subfolder=["MgCa" "Mn"];
replicas=string(1:25);
time=1200;
timedata=(1:time).*0.25;
legtext = ["State1" "State2" "State3" "State4" "State5" "State6" "State7" "State8"];
Ang= char(197);
for condition=1:size(subfolder,2)
    for crystalstate=1:length(folders1)
        figure
        hold on
        if crystalstate == 3
            filename=strcat("state",num2str(crystalstate),"b_1_Crystalvs_",subfolder(condition),'_FULL.xvg');
        else
            filename=strcat("state",num2str(crystalstate),"_1_Crystalvs_",subfolder(condition),'_FULL.xvg');
        end
        for statetraj=1:length(folders1)
            % preparing matrix to fill with replica data
            replica = zeros(time,25);
            for rep=1:length(replicas)
                % preparing variable to read data into
                dataall = zeros(time,2);
                % preparing the path we want to analyze
                yall = strcat(root1,folders1{statetraj},'\',subfolder(condition),'\replica',replicas(rep));
                if isfolder(yall)
                    % using the prepared path to give a full filename
                    fulfilename = fullfile(yall,filename);
                    if isfile(fulfilename)
                        % reading in the data
                        dataall = readmatrix(fulfilename,'FileType','text','Range',19);
                        % checking the data to make sure it was measured
                        % correctly and doesn't have all zeros for RMSD
                        % values
                        if dataall(:,1) == 0
                            disp('not OK')
                            replica(1:time,rep) = NaN(time,1);
                            continue
                        else                            
                            replica(:,rep) = dataall(1:time,2);
                        end
                    else
                        replica(1:time,rep) = NaN(time,1);
                    end

                else
                    replica(1:time,rep) = NaN(time,1);
                end
            end
            meanofreplicas(:,statetraj) = smoothdata(mean(replica,2,'omitnan'),"movmean",20);
            stdevofreplica(:,statetraj) = std(replica,0,1,'omitnan');
            maxrep(statetraj,condition,crystalstate)=max(replica(1200,:));
            minrep(statetraj,condition,crystalstate)=min(replica(1200,:));
        end
        plot(timedata,meanofreplicas.*10)
        ylabel(strcat('RMSD (',Ang,')'),'fontsize', 10);
        xlabel('Time (ns)','fontsize', 10);
        ylim([0,3.5])
        set(gcf, 'Units', 'Inches', 'Position', [1, 1,1.725, 1.5],'PaperPositionMode','auto')
        leg = legend(legtext,'location','southeast','fontsize', 6,'NumColumns',2);
        legend('boxoff')
        leg.ItemTokenSize = [10,10];
        set(gca,'ColorOrder',colormap(gray(10)))
        hold off
        walkername = fullfile(strcat(root1, 'FigS1_RMSD_',subfolder(condition)));
        print(walkername, '-r600', '-dpng')
    end
end
maxall=max(maxrep);
minall=min(minrep);