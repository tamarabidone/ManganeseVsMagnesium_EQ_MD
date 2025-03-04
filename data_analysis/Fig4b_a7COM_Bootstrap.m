%% July 25, 2024 Robert Coffman
% This returns the average of the largest sample size with the largest change
% The bins are created based on the max and min of individual conditions
 
clear
clc
%close all

% fill in the rest of the root folders path
%root1=".\ManganeseVsMagnesium_EQ_MD\States\";
root1="D:\OneDrive - University of Utah\BidoneLab\integrin\1_HeadpieceTest\";


% work code
openfile = "DistanceAlpha7"; % 
states =  ["1" "2" "3b" "4" "5" "6" "7" "8"] ;
subfolder= ["1" "5"];
replicas=string(1:25);
time=1200;
% Preallocate memory for arrays with NaN
legtext = cell(1, numel(subfolder) + 1);
replicadata = NaN(numel(replicas), length(subfolder), length(states));
datareplica = NaN(time * numel(replicas), 1);
replicastart = NaN(length(states), length(subfolder)); % Preallocate replicastart

% Variables to store means and confidence intervals
%SEM = NaN(length(states), length(subfolder));
data=NaN(length(replicas)*41,length(states));
means = NaN(length(states), length(subfolder));
meanStandardError = NaN(length(states), length(subfolder));
ci_lower = NaN(length(states), length(subfolder));
ci_upper = NaN(length(states), length(subfolder));

for subs=1:numel(subfolder)    
    if strcmp(subfolder(subs),"1")
        legtext{subs} = "Mg^{2+}";
        coloring{subs} =  [0 1 1];
    elseif strcmp(subfolder(subs),"5")
        legtext{subs} = "Mn^{2+}";
        coloring{subs} = [0 0.87 0];
    end
end
legtext{end} =  "Start";
% put together datareplica matrix containing the means of the last 10 
% ns of all the replicas and conditions for a single state
for state=1:length(states)
    for conditions = 1:length(subfolder)
        parfor replica=1:length(replicas)
            yall=strcat(root1,'state',states{state},'\',subfolder(conditions),'\replica',replicas(replica));
            if isfolder(yall)
                cd(yall); %move to directory
                fullFilename = fullfile(strcat(openfile,'.dat')); %
                if isfile(fullFilename) 
                    s = dir(fullFilename);
                    filesize = s.bytes;
                    if filesize > 40000
                        dataall = readmatrix(fullFilename);
                        replicadata(replica,conditions,state)=mean(dataall(time-40:time,3))-mean(dataall(time-40:time,2));
                        % Store the start value in the cell array
                        tempReplicastart{replica} = dataall(1,3) - dataall(1,2);
                    end
                end
            end
        end
        % Calculate replicastart for the current state and condition
        % replicastart is the difference between the distance from the
        % closed - distance from the open
        replicastart(state,conditions) = mean(cell2mat(tempReplicastart));
   end
end
for state=1:length(states)
    for conditions = 1:length(subfolder)
        % replicadata contains information for the current condition of all
        % replicas for the two distances. It is written over for each state and condition.
        nBootstraps = 1000;      % Number of bootstrap samples
        
        % Perform bootstrap resampling
        bootstrapSamples = bootstrapResample(replicadata(~isnan(replicadata(:,conditions,state)),conditions,state), nBootstraps);
        
        % Initialize matrices to store bootstrap statistics
        bootstrapMeans = zeros(nBootstraps, 1);
        bootstrapMedians = zeros(nBootstraps, 1);
        bootstrapStds = zeros(nBootstraps, 1);
        
        % Calculate the mean, median, and standard deviation for each bootstrap sample
        parfor i = 1:nBootstraps
            bootstrapMeans(i) = mean(bootstrapSamples{i});
            bootstrapMedians(i) = median(bootstrapSamples{i});
            bootstrapStds(i) = std(bootstrapSamples{i}); % this is only used to calculate a CI for the Std.deviation
        end
        % since this is derived from a bootstrap approach this is the SEM
        % for the bootstrap means. https://www.statology.org/bootstrap-standard-error-in-r/?form=MG0AV3
        % https://www.dummies.com/article/academics-the-arts/science/biology/the-bootstrap-method-for-standard-errors-and-confidence-intervals-164614/
        std_means(state, conditions) = std(bootstrapMeans);
        %meanStandardError(state, conditions) = mean(bootstrapStds);
        means(state, conditions) = mean(bootstrapMeans);
        % row 1 represents the lower percentile, row 2 represents the upper
        % percentile. column 1 represents condition 1 (Mg), column 2
        % represents the second condition (5, Mn). Each page represents
        % different state.
        meanCI(:, conditions, state) = prctile(bootstrapMeans, [2.5, 97.5]);
        stdCI(:, conditions, state) = prctile(bootstrapStds, [2.5, 97.5]);
        
%        % Plot the bootstrap distributions
%        figure;
%        subplot(2, 2, 1);
%        histogram(bootstrapMeans, 30, 'Normalization', 'probability');
%        title('Bootstrap Distribution of Means');
%        xlabel('Mean');
%        ylabel('Probability');
%        
%        subplot(2, 2, 2);
%        histogram(bootstrapMedians, 30, 'Normalization', 'probability');
%        title('Bootstrap Distribution of Medians');
%        xlabel('Median');
%        ylabel('Probability');
%        
%        subplot(2, 2, 3);
%       histogram(bootstrapStds, 30, 'Normalization', 'probability');
%        title('Bootstrap Distribution of Standard Deviations');
%        xlabel('Standard Deviation');
%        ylabel('Probability');
%        
%        % Plot the original data
%        subplot(2, 2, 4);
%        histogram(replicadata(~isnan(replicadata(:,conditions,state)),conditions,state), 30, 'Normalization', 'probability');
%        title('Original Data Distribution');
%        xlabel('Data Values');
%        ylabel('Probability');
    end
end

ci_95_magnitude = meanCI(2,:,:) - meanCI(1,:,:);
ci_95_magnitude = reshape(permute(ci_95_magnitude, [3,2,1]),[8,2]);
%ci_lower = meanCI(1,:,:);
%ci_upper = meanCI(2,:,:);



X = categorical(["1" "2" "3" "4" "5" "6" "7" "8"]);
ngroups = size(means, 1);
nbars = size(means, 2);
% -4.88407190778128 is the uncorrected value of the starting position for
% state1
means = means + 4.88407190778128; 
f=figure;
hold on
hb = bar(X,means,0.80,'FaceColor','flat');
ax=gca;
plot(X,replicastart+4.88407190778128,'k_','markersize',15,'linewidth',1)
for k = 1:size(subfolder,2)
    hb(k).CData = repmat(coloring{k},ngroups,1);
end
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars); 
    %errorbar(x, means(:, i), ci_95_magnitude(:,i), 'k', 'linestyle', 'none');
    errorbar(x, means(:, i), std_means(:,i), 'k', 'linestyle', 'none');
end
c = hb.BaseLine;
c.Color = 'none';
Ang= char(197);
fontsize(12,'points')
yAX = get(gca,'YAxis');
set(yAX,'FontSize', 10)
ylabel({'\alpha7 COM', ['(d_1-d_2, ', Ang,')']},'fontsize', 10);
yticks([-2 0 2 4 6 8 10])
ylim([-1,10]); 
set(gcf, 'Units', 'Inches', 'Position', [1, 1, 3.04, 1.25])
set(gcf,'PaperPositionMode','auto')
hold off;
%clearvars -except root1 subfolder dataindexing
walkername = fullfile(strcat(root1,"Fig4b_alpha7_SEM_",subfolder));
print(walkername{1},'-r600','-dpng')



% Custom function for bootstrap resampling
function samples = bootstrapResample(data, nBootstraps)
    % data: Original data vector
    % nBootstraps: Number of bootstrap samples to generate
    n = length(data);
    samples = cell(nBootstraps, 1);

    parfor i = 1:nBootstraps
        % Sample with replacement from the original data
        samples{i} = data(randi(n, n, 1));
    end
end
