%% Aug 3, 2024 Robert Coffman
% for plotting the Beta-I h-bond contacts and contact with R224 in alpha
% chain
clear
clc
close all

% fill in the rest of the root folders path
root1=".\ManganeseVsMagnesium_EQ_MD\States\";


% Work Code
% Tyr 122 was also measured but did not show up in hte graph. IE was zero.
openfiles = ["asp224side" "ser123mainN" "arg215mainN"];
legtext = ["R493-D224" "D495-S123" "D495-N215"];
X = categorical(["1" "2" "3" "4" "5" "6" "7" "8"]);
states = ["1" "2" "3" "4" "5" "6" "7" "8"];
subfolder = ["Alpha7HBondsData_1" "Alpha7HBondsData_5" ];

for conditions = 1:length(subfolder)
    replicadata = zeros(length(states), length(openfiles));
    replicastdevi = zeros(length(states), length(openfiles));
    for state = 1:length(states)
        yall = fullfile(root1, subfolder(conditions),['state', states{state}]);
        cd(yall); % move to directory
        for residue = 1:length(openfiles)
            fullFilename1 = fullfile(yall, [openfiles{residue}, '.txt']);
            if ~isfile(fullFilename1)
                warning('File %s does not exist. Skipping...', fullFilename1);
                continue;
            end
            fid1 = fopen(fullFilename1);
            data1 = textscan(fid1, '%s %s %s %s %s %s %f32', 'Delimiter', ' ', 'EmptyValue', 0);
            fclose(fid1)
            data = data1{7};
            replicadata(state, residue) = mean(data(data ~= 0));
            replicastdevi(state, residue) = std(data(data ~= 0))/sqrt(length(data(data ~= 0)));
        end
    end
    figure
    hold on
    b = bar(X, replicadata);
    for k = 1:length(b)
        if k == 4
            b(k).FaceColor = 'k'; % Change to red or any color you prefer
        end
    end
    set(gca, 'FontSize', 10)
    ylabel('Occupancy (%)', 'FontSize', 9);
    xlabel('State', 'FontSize', 12);
    ylim([0, 120]);
    set(gcf, 'Units', 'Inches', 'Position', [1, 1, 3.25, 1.5])
    set(gcf, 'PaperPositionMode', 'auto')
    leg = legend(legtext, 'location', 'best', 'FontSize', 8, 'NumColumns', 2);
    legend('boxoff')
    leg.ItemTokenSize = [8, 10];
    yticks([0 20 40 60 80 100])
    hold off
    walkername = fullfile(strcat(root1, 'Fig5ab_Hbonds_',subfolder(conditions)));
    %print(walkername, '-r600', '-dpng')
end