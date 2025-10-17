function create_charts_group

    %
    % Quick and rough script to churn out charts for
    % all attack rates in the CSCI-532 Group Project.
    % Takes in 12 CSV files with the requisite sorted
    % data with an equal amount of clients and rounds ran.
    % Creates and saves 14 figures to the disk:
    % - 6 about accuracy per client per round for each type
    %   of attack
    % - 6 of the same, but for loss instead of accuracy
    % - 1 chart for the average/aggregate accuracy per round
    % - 1 chart for the same, but for loss instead of accuracy
    %
    % Author: Lily O'Carroll <lso2973>
    % Date: 12 October, 2025
    %

    % Close any already-open figures
    close all

    % Read in the file of each client's data.
    clientDataWithoutAttack = readtable('results_0.csv');

    % Read in the file of the aggregate data.
    aggregateDataWithoutAttack = readtable('aggregated_results_0.csv');

    % Repeat the following for...
    % 10% attack rate
    clientDataTenPercentAttack = readtable('results_10.csv');
    aggregateDataTenPercentAttack = readtable('aggregated_results_10.csv');

    % 25% attack rate
    clientDataTwentyFivePercentAttack = readtable('results_25.csv');
    aggregateDataTwentyFivePercentAttack = readtable('aggregated_results_25.csv');

    % 50% attack rate
    clientDataFiftyPercentAttack = readtable('results_50.csv');
    aggregateDataFiftyPercentAttack = readtable('aggregated_results_50.csv');

    % 75% attack rate
    clientDataSeventyFivePercentAttack = readtable('results_75.csv');
    aggregateDataSeventyFivePercentAttack = readtable('aggregated_results_75.csv');

    % 100% attack rate
    clientDataFullAttack = readtable('results_100.csv');
    aggregateDataFullAttack = readtable('aggregated_results_100.csv');

    % How many rounds did these simulations run?
    maximum_rounds = max(aggregateDataWithoutAttack.Round);

    %%%%%%%%%%%%%%%%%%%%%%%%%% PER-CLIENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Plot the loss per client over rounds.
    clientLineNames = {'Client 0', 'Client 1', 'Client 2', 'Client 3', ...
        'Client 4', 'Client 5', 'Client 6', 'Client 7', 'Client 8', ...
        'Client 9', 'Client 10', 'Client 11', 'Client 12', 'Client 13', ...
        'Client 14', 'Client 15', 'Client 16', 'Client 17', 'Client 18', ...
        'Client 19'};

    % Set up client offsets for the creation of sub-tables.
    c1Offset = maximum_rounds + maximum_rounds;
    c2Offset = c1Offset + maximum_rounds;
    c3Offset = c2Offset + maximum_rounds;
    c4Offset = c3Offset + maximum_rounds;
    c5Offset = c4Offset + maximum_rounds;
    c6Offset = c5Offset + maximum_rounds;
    c7Offset = c6Offset + maximum_rounds;
    c8Offset = c7Offset + maximum_rounds;
    c9Offset = c8Offset + maximum_rounds;
    c10Offset = c9Offset + maximum_rounds;
    c11Offset = c10Offset + maximum_rounds;
    c12Offset = c11Offset + maximum_rounds;
    c13Offset = c12Offset + maximum_rounds;
    c14Offset = c13Offset + maximum_rounds;
    c15Offset = c14Offset + maximum_rounds;
    c16Offset = c15Offset + maximum_rounds;
    c17Offset = c16Offset + maximum_rounds;
    c18Offset = c17Offset + maximum_rounds;
    c19Offset = c18Offset + maximum_rounds;

    % No attack
    client_0 = clientDataWithoutAttack(1:maximum_rounds,:);
    client_1 = clientDataWithoutAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataWithoutAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataWithoutAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataWithoutAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataWithoutAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataWithoutAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataWithoutAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataWithoutAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataWithoutAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataWithoutAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataWithoutAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataWithoutAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataWithoutAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataWithoutAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataWithoutAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataWithoutAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataWithoutAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataWithoutAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataWithoutAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    c0_plot = plot(client_0, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Loss", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Loss Per Round Per Client (0% Label Flipping)";
    title("Loss Per Round Per Client (0% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_0p_label_flipping.png");

    % 10% Attack
    client_0 = clientDataTenPercentAttack(1:maximum_rounds,:);
    client_1 = clientDataTenPercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTenPercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataTenPercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataTenPercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataTenPercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataTenPercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataTenPercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataTenPercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataTenPercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataTenPercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataTenPercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataTenPercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataTenPercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataTenPercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataTenPercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataTenPercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataTenPercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataTenPercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataTenPercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Loss", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Loss Per Round Per Client (10% Label Flipping)";
    title("Loss Per Round Per Client (10% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_10p_label_flipping.png");

    % 25% Attack
    client_0 = clientDataTwentyFivePercentAttack(1:maximum_rounds,:);
    client_1 = clientDataTwentyFivePercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTwentyFivePercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataTwentyFivePercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataTwentyFivePercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataTwentyFivePercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataTwentyFivePercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataTwentyFivePercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataTwentyFivePercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataTwentyFivePercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataTwentyFivePercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataTwentyFivePercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataTwentyFivePercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataTwentyFivePercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataTwentyFivePercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataTwentyFivePercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataTwentyFivePercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataTwentyFivePercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataTwentyFivePercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataTwentyFivePercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Loss", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Loss Per Round Per Client (25% Label Flipping)";
    title("Loss Per Round Per Client (25% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_25p_label_flipping.png");

    % 50% Attack
    client_0 = clientDataFiftyPercentAttack(1:maximum_rounds,:);
    client_1 = clientDataFiftyPercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFiftyPercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataFiftyPercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataFiftyPercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataFiftyPercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataFiftyPercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataFiftyPercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataFiftyPercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataFiftyPercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataFiftyPercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataFiftyPercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataFiftyPercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataFiftyPercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataFiftyPercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataFiftyPercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataFiftyPercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataFiftyPercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataFiftyPercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataFiftyPercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Loss", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Loss Per Round Per Client (50% Label Flipping)";
    title("Loss Per Round Per Client (50% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_50p_label_flipping.png");

    % 75% Attack
    client_0 = clientDataSeventyFivePercentAttack(1:maximum_rounds,:);
    client_1 = clientDataSeventyFivePercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataSeventyFivePercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataSeventyFivePercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataSeventyFivePercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataSeventyFivePercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataSeventyFivePercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataSeventyFivePercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataSeventyFivePercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataSeventyFivePercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataSeventyFivePercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataSeventyFivePercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataSeventyFivePercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataSeventyFivePercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataSeventyFivePercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataSeventyFivePercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataSeventyFivePercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataSeventyFivePercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataSeventyFivePercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataSeventyFivePercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Loss", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Loss Per Round Per Client (75% Label Flipping)";
    title("Loss Per Round Per Client (75% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_75p_label_flipping.png");

    % 100% Attack
    client_0 = clientDataFullAttack(1:maximum_rounds,:);
    client_1 = clientDataFullAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFullAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataFullAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataFullAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataFullAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataFullAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataFullAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataFullAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataFullAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataFullAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataFullAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataFullAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataFullAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataFullAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataFullAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataFullAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataFullAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataFullAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataFullAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Loss", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Loss", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Loss Per Round Per Client (100% Label Flipping)";
    title("Loss Per Round Per Client (100% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_100p_label_flipping.png");


    % Plot the evaluation accuracy per client over rounds.

    % No attack
    client_0 = clientDataWithoutAttack(1:maximum_rounds,:);
    client_1 = clientDataWithoutAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataWithoutAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataWithoutAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataWithoutAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataWithoutAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataWithoutAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataWithoutAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataWithoutAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataWithoutAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataWithoutAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataWithoutAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataWithoutAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataWithoutAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataWithoutAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataWithoutAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataWithoutAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataWithoutAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataWithoutAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataWithoutAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Accuracy", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Accuracy Per Round Per Client (0% Label Flipping)";
    title("Accuracy Per Round Per Client (0% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_0p_label_flipping.png");

    % 10% Attack
    client_0 = clientDataTenPercentAttack(1:maximum_rounds,:);
    client_1 = clientDataTenPercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTenPercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataTenPercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataTenPercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataTenPercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataTenPercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataTenPercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataTenPercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataTenPercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataTenPercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataTenPercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataTenPercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataTenPercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataTenPercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataTenPercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataTenPercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataTenPercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataTenPercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataTenPercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Accuracy", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Accuracy Per Round Per Client (10% Label Flipping)";
    title("Accuracy Per Round Per Client (10% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_10p_label_flipping.png");

    % 25% Attack
    client_0 = clientDataTwentyFivePercentAttack(1:maximum_rounds,:);
    client_1 = clientDataTwentyFivePercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTwentyFivePercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataTwentyFivePercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataTwentyFivePercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataTwentyFivePercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataTwentyFivePercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataTwentyFivePercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataTwentyFivePercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataTwentyFivePercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataTwentyFivePercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataTwentyFivePercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataTwentyFivePercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataTwentyFivePercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataTwentyFivePercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataTwentyFivePercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataTwentyFivePercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataTwentyFivePercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataTwentyFivePercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataTwentyFivePercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Accuracy", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Accuracy Per Round Per Client (25% Label Flipping)";
    title("Accuracy Per Round Per Client (25% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_25p_label_flipping.png");

    % 50% Attack
    client_0 = clientDataFiftyPercentAttack(1:maximum_rounds,:);
    client_1 = clientDataFiftyPercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFiftyPercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataFiftyPercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataFiftyPercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataFiftyPercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataFiftyPercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataFiftyPercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataFiftyPercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataFiftyPercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataFiftyPercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataFiftyPercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataFiftyPercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataFiftyPercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataFiftyPercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataFiftyPercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataFiftyPercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataFiftyPercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataFiftyPercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataFiftyPercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Accuracy", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Accuracy Per Round Per Client (50% Label Flipping)";
    title("Accuracy Per Round Per Client (50% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_50p_label_flipping.png");

    % 75% Attack
    client_0 = clientDataSeventyFivePercentAttack(1:maximum_rounds,:);
    client_1 = clientDataSeventyFivePercentAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataSeventyFivePercentAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataSeventyFivePercentAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataSeventyFivePercentAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataSeventyFivePercentAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataSeventyFivePercentAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataSeventyFivePercentAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataSeventyFivePercentAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataSeventyFivePercentAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataSeventyFivePercentAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataSeventyFivePercentAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataSeventyFivePercentAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataSeventyFivePercentAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataSeventyFivePercentAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataSeventyFivePercentAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataSeventyFivePercentAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataSeventyFivePercentAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataSeventyFivePercentAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataSeventyFivePercentAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Accuracy", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Accuracy Per Round Per Client (75% Label Flipping)";
    title("Accuracy Per Round Per Client (75% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_75p_label_flipping.png");

    % 100% Attack
    client_0 = clientDataFullAttack(1:maximum_rounds,:);
    client_1 = clientDataFullAttack(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFullAttack(c1Offset+1:c2Offset, :);
    client_3 = clientDataFullAttack(c2Offset+1:c3Offset, :);
    client_4 = clientDataFullAttack(c3Offset+1:c4Offset, :);
    client_5 = clientDataFullAttack(c4Offset+1:c5Offset, :);
    client_6 = clientDataFullAttack(c5Offset+1:c6Offset, :);
    client_7 = clientDataFullAttack(c6Offset+1:c7Offset, :);
    client_8 = clientDataFullAttack(c7Offset+1:c8Offset, :);
    client_9 = clientDataFullAttack(c8Offset+1:c9Offset, :);
    client_10 = clientDataFullAttack(c9Offset+1:c10Offset, :);
    client_11 = clientDataFullAttack(c10Offset+1:c11Offset, :);
    client_12 = clientDataFullAttack(c11Offset+1:c12Offset, :);
    client_13 = clientDataFullAttack(c12Offset+1:c13Offset, :);
    client_14 = clientDataFullAttack(c13Offset+1:c14Offset, :);
    client_15 = clientDataFullAttack(c14Offset+1:c15Offset, :);
    client_16 = clientDataFullAttack(c15Offset+1:c16Offset, :);
    client_17 = clientDataFullAttack(c16Offset+1:c17Offset, :);
    client_18 = clientDataFullAttack(c17Offset+1:c18Offset, :);
    client_19 = clientDataFullAttack(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(1,:));
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(2,:));
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(3,:));
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(4,:));
    c4_plot = plot(client_4, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(5,:));
    c5_plot = plot(client_5, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(6,:));
    c6_plot = plot(client_6, "Round", "Accuracy", "LineWidth", 1 , ...
        "Color", cmap(7,:));
    c7_plot = plot(client_7, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(8,:));
    c8_plot = plot(client_8, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(9,:));
    c9_plot = plot(client_9, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(10,:));
    c10_plot = plot(client_10, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(11,:));
    c11_plot = plot(client_11, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(12,:));
    c12_plot = plot(client_12, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(13,:));
    c13_plot = plot(client_13, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(14,:));
    c14_plot = plot(client_14, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(15,:));
    c15_plot = plot(client_15, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(16,:));
    c16_plot = plot(client_16, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(17,:));
    c17_plot = plot(client_17, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(18,:));
    c18_plot = plot(client_18, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(19,:));
    c19_plot = plot(client_19, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", cmap(20,:));
    hold off
    legend([c0_plot, c1_plot, c2_plot, c3_plot, c4_plot, c5_plot, ...
        c6_plot, c7_plot, c8_plot, c9_plot, c10_plot, c11_plot, ... 
        c11_plot, c12_plot, c13_plot, c14_plot, c15_plot, ... 
        c16_plot, c17_plot, c18_plot, c19_plot], clientLineNames, ...
        "Location", "northeastoutside");
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Accuracy Per Round Per Client (100% Label Flipping)";
    title("Accuracy Per Round Per Client (100% Label Flipping)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_100p_label_flipping.png");


    %%%%%%%%%%%%%%%%%%%%%%%%%%% AGGREGATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Plot the average loss among clients over rounds. This will
    % combine the results of all attack types.

    % First set up the names for each line type. This will be used
    % for plotting each line.
    aggregateLineNames = {'No Attack', '10% Attack', '25% Attack', ...
        '50% Attack', '75% Attack', '100% Attack'};

    figure
    % Plot without an attack.
    noAtk = plot(aggregateDataWithoutAttack, "Round", "AvgLoss", ...
        'LineWidth', 2);

    hold on
    % Plot with all ranges of attack percentages.
    tenAtk = plot(aggregateDataTenPercentAttack, "Round", "AvgLoss", ...
        'LineWidth', 2);
    twentyFiveAtk = plot(aggregateDataTwentyFivePercentAttack, "Round", ...
        "AvgLoss", 'LineWidth', 2);
    fiftyAtk = plot(aggregateDataFiftyPercentAttack, "Round", "AvgLoss", ...
        'LineWidth', 2);
    seventyFiveAtk = plot(aggregateDataSeventyFivePercentAttack, "Round", ...
        "AvgLoss", 'LineWidth', 2);
    fullAtk = plot(aggregateDataFullAttack, "Round", "AvgLoss", ...
        'LineWidth', 2);
    hold off
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Average Loss Among Clients Over Rounds";
    title("Average Loss Among Clients Over Rounds");
    legend([noAtk, tenAtk, twentyFiveAtk, fiftyAtk, seventyFiveAtk, fullAtk], ...
        aggregateLineNames, "Location", "northeastoutside");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Aggregated Loss')
    saveas(gcf, "aggregate_loss_over_rounds.png");

    % Plot the average evaluation accuracy among clients over 
    % rounds. This will combine the results of all attack types.
    figure
    % Plot without an attack.
    noAtk = plot(aggregateDataWithoutAttack, "Round", "AvgAccuracy", ...
        'LineWidth', 2);

    hold on
    % Plot with all ranges of attack percentages.
    tenAtk = plot(aggregateDataTenPercentAttack, "Round", "AvgAccuracy", ...
        'LineWidth', 2);
    twentyFiveAtk = plot(aggregateDataTwentyFivePercentAttack, "Round", ...
        "AvgAccuracy", 'LineWidth', 2);
    fiftyAtk = plot(aggregateDataFiftyPercentAttack, "Round", "AvgAccuracy", ...
        'LineWidth', 2);
    seventyFiveAtk = plot(aggregateDataSeventyFivePercentAttack, "Round", ...
        "AvgAccuracy", 'LineWidth', 2);
    fullAtk = plot(aggregateDataFullAttack, "Round", "AvgAccuracy", ...
        'LineWidth', 2);
    hold off
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Average Evaluation Accuracy Among Clients Over Rounds";
    title("Average Evaluation Accuracy Among Clients Over Rounds");
    legend([noAtk, tenAtk, twentyFiveAtk, fiftyAtk, seventyFiveAtk, fullAtk], ...
        aggregateLineNames, "Location", "northeastoutside");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Aggregated Accuracy')
    saveas(gcf, "aggregate_accuracy_over_rounds.png");

end
