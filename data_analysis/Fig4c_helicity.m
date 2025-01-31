% Note: This plots the change in secondary structure based on the range of
% changes detected in each condition split into 3 bins. The bin with the
% most samples is plotted with a bias towards plotting the "highest" bin
% should any of the other bins have the same sample size.
clear
clc
close all

% fill in the rest of the root folders path
root1=".\ManganeseVsMagnesium_EQ_MD\States\";


% work code
states =  ["1" "2" "3" "4" "5" "6" "7" "8"] ;
subfolder= ["MgCa" "Mn"];
openfile = "secondary_structure_digitized";
replicas=string(1:25);
time=1200;
for subs=1:size(subfolder,2)    
    if strcmp(subfolder(subs),"MgCa")
        legtext{subs} = "Mg^{2+}";
        coloring{subs} =  [0 1 1];
    elseif strcmp(subfolder(subs),"Mn")
        legtext{subs} = "Mn^{2+}";
        coloring{subs} = [0 0.87 0];
    end
end
legtext{subs+1} = 'Start';
for state=1:length(states)
    for conditions = 1:length(subfolder)
        for replica=1:length(replicas)
            yall=strcat(root1,'state',states{state},'\',subfolder(conditions),'\replica',replicas(replica));
            if isfolder(yall)
                cd(yall); %move to directory           
                fullFilename = fullfile(strcat(openfile,'.dat')); 
                if isfile(fullFilename) 
                        s = dir(fullFilename);
                        filesize = s.bytes;
                        if filesize > 40000
                            dataall = readmatrix(fullFilename)';
                            dataall = mean(dataall(:,1:time),'omitnan');
                            replicadata(replica,:) = mean(dataall(:,time-40:time),'omitnan');
                        else
                            replicadata(replica,:)=NaN;
                        end
                else
                    replicadata(replica,:)=NaN;
                end
            else
                replicadata(replica,:)=NaN;
            end
        end
        fullFilename2 = fullfile(strcat(root1,'state',states{state},'\',subfolder(conditions),'\replica4\secondary_structure_start_digitized.dat')); 
        dataall2 = readmatrix(fullFilename2);
        replicastart(state) = mean(dataall2);
        datareplica(:,conditions,state) = replicadata;
    end
end
conditionmax = max(datareplica);
conditionmin = min(datareplica);
binrange = conditionmax - conditionmin;
bintop = conditionmax - (binrange/3);
binbottom = conditionmin + (binrange/3);
% split the 5 replicas into bins established by the bin criteria above
% and keep track of which replicas are in each bin 
for state=1:length(states)
    for conditions = 1:length(subfolder)
        for replica=1:length(replicas)
            % top bin
            if datareplica(replica,conditions,state) >= bintop(1,conditions,state)
                datatop(replica,conditions,state)=datareplica(replica,conditions,state);
                dataindexing(replica,conditions,state) = 1;
            else
                datatop(replica,conditions,state)=NaN;
            end
            if datareplica(replica,conditions,state) < binbottom(1,conditions,state)
                databottom(replica,conditions,state)=datareplica(replica,conditions,state);
                dataindexing(replica,conditions,state) = 3;
            else
                databottom(replica,conditions,state)=NaN;
            end
            if datareplica(replica,conditions,state) >= binbottom(1,conditions,state) && datareplica(replica,conditions,state) < bintop(1,conditions,state)
                datamiddle(replica,conditions,state)=datareplica(replica,conditions,state);
                dataindexing(replica,conditions,state) = 2;
            else
                datamiddle(replica,conditions,state)=NaN;
            end
        end
    end
end
% get the counts and mean data points of each bin 
counttop = reshape(sum(~isnan(datatop)),[],size(states,2));
countmiddle = reshape(sum(~isnan(datamiddle)),[],size(states,2));
countbottom = reshape(sum(~isnan(databottom)),[],size(states,2));
changetop=reshape(mean(datatop,'omitnan'),[],size(states,2));
changemiddle=reshape(mean(datamiddle,'omitnan'),[],size(states,2));
changebottom=reshape(mean(databottom,'omitnan'),[],size(states,2));
%find standard deviations of data in the bins, as well as counts
stdtop = reshape(std(datatop,0,1,"omitmissing"),[],size(states,2));
stdmiddle = reshape(std(datamiddle,0,1,"omitmissing"),[],size(states,2));
stdbottom = reshape(std(databottom,0,1,"omitmissing"),[],size(states,2));
%calculate the SEM of the data in the bins
SEMtop = stdtop ./ sqrt(counttop);
SEMmiddle = stdmiddle ./ sqrt(countmiddle);
SEMbottom = stdbottom ./ sqrt(countbottom);
% calculate the T statistic for each condition in each bin set. 0.975
% corresponds to a 95% confidence interval for a two-way t-test
for states2=1:size(states,2)
    for conditions2=1:size(subfolder,2)
        tstattop(conditions2,states2) = tinv(0.975,counttop(conditions2,states2)-1);
        tstatmiddle(conditions2,states2) = tinv(0.975,countmiddle(conditions2,states2)-1);
        tstatbottom(conditions2,states2) = tinv(0.975,countbottom(conditions2,states2)-1);
    end
end
% calculate the confidence interval
CItop = (tstattop.*SEMtop);
CImiddle = (tstatmiddle.*SEMmiddle);
CIbottom = (tstatbottom.*SEMbottom);
% bin the data based on largest sample sizes
for states2=1:size(states,2)
    for conditions2=1:size(subfolder,2)
        % if the top bin has more or equal number of samples than the middle 
        % bin and the bottom bin, save the data into new matrix
        if counttop(conditions2,states2) >= countmiddle(conditions2,states2) && counttop(conditions2,states2) >= countbottom(conditions2,states2)
            mostsamplesmatrix(conditions2,states2) = changetop(conditions2,states2);
            mostsamplecounter(conditions2,states2) = counttop(conditions2,states2);
            mostSEM(conditions2,states2) = SEMtop(conditions2,states2);
            mostCI(conditions2,states2) = CItop(conditions2,states2);
            mostdataindex(conditions2,states2) = 1;
        % if the first test fails check to see if the middle bin has more
        % or equal number of samples
        elseif countmiddle(conditions2,states2) >= countbottom(conditions2,states2)
            mostsamplesmatrix(conditions2,states2) = changemiddle(conditions2,states2);
            mostsamplecounter(conditions2,states2) = countmiddle(conditions2,states2);
            mostSEM(conditions2,states2) = SEMmiddle(conditions2,states2);
            mostCI(conditions2,states2) = CImiddle(conditions2,states2);
            mostdataindex(conditions2,states2) = 2;
        % if the first two tests fail, assume we are using the bottom bin    
        else
            mostsamplesmatrix(conditions2,states2) = changebottom(conditions2,states2);
            mostsamplecounter(conditions2,states2) = countbottom(conditions2,states2);
            mostSEM(conditions2,states2) = SEMbottom(conditions2,states2);
            mostCI(conditions2,states2) = CIbottom(conditions2,states2);
            mostdataindex(conditions2,states2) = 3;
        end
    end
end

X = categorical(["1" "2" "3" "4" "5" "6" "7" "8"]);
f=figure;
hold on
hb = bar(X,mostsamplesmatrix*100,0.80,'FaceColor','flat');
plot(X,replicastart*100,'k_','markersize',15,'linewidth',1)
for k = 1:size(subfolder,2)
    hb(k).CData = repmat(coloring{k},size(mostsamplesmatrix,2),1);
end
set(hb, GroupWidth = 0.90)
ngroups = size(states,2);
nbars = size(subfolder,2);
% Calculating the width for each bar group
% NEED TO ADJUST THE CONSTANT BELOW DUE TO SETTING GROUPWIDTH ABOVE
groupwidth =  nbars/(nbars + 0.3);
countt = arrayfun(@num2str, mostsamplecounter,'UniformOutput',0);
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, mostsamplesmatrix(i,:)*100, mostCI(i,:)*100,'.k');
end
fontsize(12,'points')
yAX = get(gca,'YAxis');
set(yAX,'FontSize', 10)
ylabel({'\alpha1 Helix';'% Helicity'},'fontsize', 10);
set(gcf, 'Units', 'Inches', 'Position', [1, 1, 2.865, 1.25])
set(gcf,'PaperPositionMode','auto')
ylim([40 100])
yticks([40 50 60 70 80 90 100])
hold off
clearvars -except root1 subfolder dataindexing
walkername = fullfile(strcat(root1,"Fig4c_alpha1_",subfolder));
print(walkername{1},'-r600','-dpng')
