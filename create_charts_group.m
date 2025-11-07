function create_charts_group

    %
    % Quick and rough script to churn out charts for
    % all attack rates in the CSCI-532 Group Project.
    % It's the same as before, but now features the ability to
    % plot PID-related artifacts and severity plots.
    %
    % Author: Lily O'Carroll <lso2973>
    % Date: 5 November, 2025
    %

    % Close any already-open figures
    close all

    % Read in the file of each client's data.
    clientDataWithoutAttack = readtable('results_0_pt3.csv');

    % Read in the file of the aggregate data.
    aggregateDataWithoutAttack = readtable('agg_results_0_pt3.csv');

    % Now, read in for the versions including PID.
    clientDataWithoutAttackPID = readtable('results_pid_0.csv');
    aggregateDataWithoutAttackPID = readtable('agg_results_pid_0.csv');

    % Repeat the following for...
    % 10% attack rate
    clientDataTenPercentAttack = readtable('results_10_pt3.csv');
    aggregateDataTenPercentAttack = readtable('agg_results_10_pt3.csv');
    clientDataTenPercentAttackPID = readtable('results_pid_10.csv');
    aggregateDataTenPercentAttackPID = readtable('agg_results_pid_10.csv');

    % 25% attack rate
    clientDataTwentyFivePercentAttack = readtable('results_25_pt3.csv');
    aggregateDataTwentyFivePercentAttack = readtable('agg_results_25_pt3.csv');
    clientDataTwentyFivePercentAttackPID = readtable('results_pid_25.csv');
    aggregateDataTwentyFivePercentAttackPID = readtable('agg_results_pid_25.csv');

    % 50% attack rate
    clientDataFiftyPercentAttack = readtable('results_50_pt3.csv');
    aggregateDataFiftyPercentAttack = readtable('agg_results_50_pt3.csv');
    clientDataFiftyPercentAttackPID = readtable('results_pid_50.csv');
    aggregateDataFiftyPercentAttackPID = readtable('agg_results_pid_50.csv');

    % 75% attack rate
    clientDataSeventyFivePercentAttack = readtable('results_75_pt3.csv');
    aggregateDataSeventyFivePercentAttack = readtable('agg_results_75_pt3.csv');
    clientDataSeventyFivePercentAttackPID = readtable('results_pid_75.csv');
    aggregateDataSeventyFivePercentAttackPID = readtable('agg_results_pid_75.csv');

    % 100% attack rate
    clientDataFullAttack = readtable('results_100_pt3.csv');
    aggregateDataFullAttack = readtable('agg_results_100_pt3.csv');
    clientDataFullAttackPID = readtable('results_pid_100.csv');
    aggregateDataFullAttackPID = readtable('agg_results_pid_100.csv');

    % How many rounds did these simulations run?
    maximum_rounds = max(aggregateDataWithoutAttack.Round);

    % For severity plots
    sevNoAtkLoss = aggregateDataWithoutAttack.AvgLoss(maximum_rounds);
    sevNoAtkLossPID = aggregateDataWithoutAttackPID.AvgLoss(maximum_rounds);
    sevNoAtkAcc = aggregateDataWithoutAttack.AvgAccuracy(maximum_rounds);
    sevNoAtkAccPID = aggregateDataWithoutAttack.AvgAccuracy(maximum_rounds);

    sevTenAtkLoss = aggregateDataTenPercentAttack.AvgLoss(maximum_rounds);
    sevTenAtkLossPID = aggregateDataTenPercentAttackPID.AvgLoss(maximum_rounds);
    sevTenAtkAcc = aggregateDataTenPercentAttack.AvgAccuracy(maximum_rounds);
    sevTenAtkAccPID = aggregateDataTenPercentAttackPID.AvgAccuracy(maximum_rounds);

    sevTwentyFiveAtkLoss = aggregateDataTwentyFivePercentAttack.AvgLoss(maximum_rounds);
    sevTwentyFiveAtkLossPID = aggregateDataTwentyFivePercentAttackPID.AvgLoss(maximum_rounds);
    sevTwentyFiveAtkAcc = aggregateDataTwentyFivePercentAttack.AvgAccuracy(maximum_rounds);
    sevTwentyFiveAtkAccPID = aggregateDataTwentyFivePercentAttackPID.AvgAccuracy(maximum_rounds);

    sevFiftyAtkLoss = aggregateDataFiftyPercentAttack.AvgLoss(maximum_rounds);
    sevFiftyAtkLossPID = aggregateDataFiftyPercentAttackPID.AvgLoss(maximum_rounds);
    sevFiftyAtkAcc = aggregateDataFiftyPercentAttack.AvgAccuracy(maximum_rounds);
    sevFiftyAtkAccPID = aggregateDataFiftyPercentAttackPID.AvgAccuracy(maximum_rounds);

    sevSeventyFiveAtkLoss = aggregateDataSeventyFivePercentAttack.AvgLoss(maximum_rounds);
    sevSeventyFiveAtkLossPID = aggregateDataSeventyFivePercentAttackPID.AvgLoss(maximum_rounds);
    sevSeventyFiveAtkAcc = aggregateDataSeventyFivePercentAttack.AvgAccuracy(maximum_rounds);
    sevSeventyFiveAtkAccPID = aggregateDataSeventyFivePercentAttackPID.AvgAccuracy(maximum_rounds);

    sevFullAtkLoss = aggregateDataFullAttack.AvgLoss(maximum_rounds);
    sevFullAtkLossPID = aggregateDataFullAttackPID.AvgLoss(maximum_rounds);
    sevFullAtkAcc = aggregateDataFullAttack.AvgAccuracy(maximum_rounds);
    sevFullAtkAccPID = aggregateDataFullAttack.AvgAccuracy(maximum_rounds);

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
    currFig.Name = "Loss Per Round Per Client (0% Label Flipping, Conventional FL Model)";
    title("Loss Per Round Per Client (0% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_0p_label_flipping_CFL.png");

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
    currFig.Name = "Loss Per Round Per Client (10% Label Flipping, Conventional FL Model)";
    title("Loss Per Round Per Client (10% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_10p_label_flipping_CFL.png");

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
    currFig.Name = "Loss Per Round Per Client (25% Label Flipping, Conventional FL Model)";
    title("Loss Per Round Per Client (25% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_25p_label_flipping_CFL.png");

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
    currFig.Name = "Loss Per Round Per Client (50% Label Flipping, Conventional FL Model)";
    title("Loss Per Round Per Client (50% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_50p_label_flipping_CFL.png");

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
    currFig.Name = "Loss Per Round Per Client (75% Label Flipping, Conventional FL Model)";
    title("Loss Per Round Per Client (75% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_75p_label_flipping_CFL.png");

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
    currFig.Name = "Loss Per Round Per Client (100% Label Flipping, Conventional FL Model)";
    title("Loss Per Round Per Client (100% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_100p_label_flipping_CFL.png");


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
    currFig.Name = "Accuracy Per Round Per Client (0% Label Flipping, Conventional FL Model)";
    title("Accuracy Per Round Per Client (0% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_0p_label_flipping_CFL.png");

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
    currFig.Name = "Accuracy Per Round Per Client (10% Label Flipping, Conventional FL Model)";
    title("Accuracy Per Round Per Client (10% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_10p_label_flipping_CFL.png");

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
    currFig.Name = "Accuracy Per Round Per Client (25% Label Flipping, Conventional FL Model)";
    title("Accuracy Per Round Per Client (25% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_25p_label_flipping_CFL.png");

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
    currFig.Name = "Accuracy Per Round Per Client (50% Label Flipping, Conventional FL Model)";
    title("Accuracy Per Round Per Client (50% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_50p_label_flipping_CFL.png");

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
    currFig.Name = "Accuracy Per Round Per Client (75% Label Flipping, Conventional FL Model)";
    title("Accuracy Per Round Per Client (75% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_75p_label_flipping_CFL.png");

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
    currFig.Name = "Accuracy Per Round Per Client (100% Label Flipping, Conventional FL Model)";
    title("Accuracy Per Round Per Client (100% Label Flipping, Conventional FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_100p_label_flipping_CFL.png");

    %%% PID VARIANTS %%%

    % No attack
    client_0 = clientDataWithoutAttackPID(1:maximum_rounds,:);
    client_1 = clientDataWithoutAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataWithoutAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataWithoutAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataWithoutAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataWithoutAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataWithoutAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataWithoutAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataWithoutAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataWithoutAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataWithoutAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataWithoutAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataWithoutAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataWithoutAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataWithoutAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataWithoutAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataWithoutAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataWithoutAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataWithoutAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataWithoutAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Loss Per Round Per Client (0% Label Flipping, PID-Enhanced FL Model)";
    title("Loss Per Round Per Client (0% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_0p_label_flipping_PID.png");

    % 10% Attack
    client_0 = clientDataTenPercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataTenPercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTenPercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataTenPercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataTenPercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataTenPercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataTenPercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataTenPercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataTenPercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataTenPercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataTenPercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataTenPercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataTenPercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataTenPercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataTenPercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataTenPercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataTenPercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataTenPercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataTenPercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataTenPercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Loss Per Round Per Client (10% Label Flipping, PID-Enhanced FL Model)";
    title("Loss Per Round Per Client (10% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_10p_label_flipping_PID.png");

    % 25% Attack
    client_0 = clientDataTwentyFivePercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataTwentyFivePercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTwentyFivePercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataTwentyFivePercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataTwentyFivePercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataTwentyFivePercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataTwentyFivePercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataTwentyFivePercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataTwentyFivePercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataTwentyFivePercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataTwentyFivePercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataTwentyFivePercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataTwentyFivePercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataTwentyFivePercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataTwentyFivePercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataTwentyFivePercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataTwentyFivePercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataTwentyFivePercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataTwentyFivePercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataTwentyFivePercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Loss Per Round Per Client (25% Label Flipping, PID-Enhanced FL Model)";
    title("Loss Per Round Per Client (25% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_25p_label_flipping_PID.png");

    % 50% Attack
    client_0 = clientDataFiftyPercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataFiftyPercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFiftyPercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataFiftyPercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataFiftyPercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataFiftyPercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataFiftyPercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataFiftyPercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataFiftyPercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataFiftyPercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataFiftyPercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataFiftyPercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataFiftyPercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataFiftyPercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataFiftyPercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataFiftyPercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataFiftyPercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataFiftyPercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataFiftyPercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataFiftyPercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Loss Per Round Per Client (50% Label Flipping, PID-Enhanced FL Model)";
    title("Loss Per Round Per Client (50% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_50p_label_flipping_PID.png");

    % 75% Attack
    client_0 = clientDataSeventyFivePercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataSeventyFivePercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataSeventyFivePercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataSeventyFivePercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataSeventyFivePercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataSeventyFivePercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataSeventyFivePercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataSeventyFivePercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataSeventyFivePercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataSeventyFivePercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataSeventyFivePercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataSeventyFivePercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataSeventyFivePercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataSeventyFivePercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataSeventyFivePercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataSeventyFivePercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataSeventyFivePercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataSeventyFivePercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataSeventyFivePercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataSeventyFivePercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Loss Per Round Per Client (75% Label Flipping, PID-Enhanced FL Model)";
    title("Loss Per Round Per Client (75% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_75p_label_flipping_PID.png");

    % 100% Attack
    client_0 = clientDataFullAttackPID(1:maximum_rounds,:);
    client_1 = clientDataFullAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFullAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataFullAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataFullAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataFullAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataFullAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataFullAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataFullAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataFullAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataFullAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataFullAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataFullAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataFullAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataFullAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataFullAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataFullAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataFullAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataFullAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataFullAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Loss Per Round Per Client (100% Label Flipping, PID-Enhanced FL Model)";
    title("Loss Per Round Per Client (100% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Loss')
    saveas(gcf, "client_loss_100p_label_flipping_PID.png");


    % Plot the evaluation accuracy per client over rounds.

    % No attack
    client_0 = clientDataWithoutAttackPID(1:maximum_rounds,:);
    client_1 = clientDataWithoutAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataWithoutAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataWithoutAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataWithoutAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataWithoutAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataWithoutAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataWithoutAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataWithoutAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataWithoutAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataWithoutAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataWithoutAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataWithoutAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataWithoutAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataWithoutAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataWithoutAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataWithoutAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataWithoutAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataWithoutAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataWithoutAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Accuracy Per Round Per Client (0% Label Flipping, PID-Enhanced FL Model)";
    title("Accuracy Per Round Per Client (0% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_0p_label_flipping_PID.png");

    % 10% Attack
    client_0 = clientDataTenPercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataTenPercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTenPercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataTenPercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataTenPercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataTenPercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataTenPercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataTenPercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataTenPercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataTenPercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataTenPercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataTenPercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataTenPercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataTenPercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataTenPercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataTenPercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataTenPercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataTenPercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataTenPercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataTenPercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Accuracy Per Round Per Client (10% Label Flipping, PID-Enhanced FL Model)";
    title("Accuracy Per Round Per Client (10% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_10p_label_flipping_PID.png");

    % 25% Attack
    client_0 = clientDataTwentyFivePercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataTwentyFivePercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataTwentyFivePercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataTwentyFivePercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataTwentyFivePercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataTwentyFivePercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataTwentyFivePercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataTwentyFivePercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataTwentyFivePercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataTwentyFivePercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataTwentyFivePercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataTwentyFivePercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataTwentyFivePercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataTwentyFivePercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataTwentyFivePercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataTwentyFivePercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataTwentyFivePercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataTwentyFivePercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataTwentyFivePercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataTwentyFivePercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Accuracy Per Round Per Client (25% Label Flipping, PID-Enhanced FL Model)";
    title("Accuracy Per Round Per Client (25% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_25p_label_flipping_PID.png");

    % 50% Attack
    client_0 = clientDataFiftyPercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataFiftyPercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFiftyPercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataFiftyPercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataFiftyPercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataFiftyPercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataFiftyPercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataFiftyPercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataFiftyPercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataFiftyPercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataFiftyPercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataFiftyPercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataFiftyPercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataFiftyPercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataFiftyPercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataFiftyPercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataFiftyPercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataFiftyPercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataFiftyPercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataFiftyPercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Accuracy Per Round Per Client (50% Label Flipping, PID-Enhanced FL Model)";
    title("Accuracy Per Round Per Client (50% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_50p_label_flipping_PID.png");

    % 75% Attack
    client_0 = clientDataSeventyFivePercentAttackPID(1:maximum_rounds,:);
    client_1 = clientDataSeventyFivePercentAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataSeventyFivePercentAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataSeventyFivePercentAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataSeventyFivePercentAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataSeventyFivePercentAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataSeventyFivePercentAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataSeventyFivePercentAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataSeventyFivePercentAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataSeventyFivePercentAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataSeventyFivePercentAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataSeventyFivePercentAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataSeventyFivePercentAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataSeventyFivePercentAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataSeventyFivePercentAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataSeventyFivePercentAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataSeventyFivePercentAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataSeventyFivePercentAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataSeventyFivePercentAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataSeventyFivePercentAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Accuracy Per Round Per Client (75% Label Flipping, PID-Enhanced FL Model)";
    title("Accuracy Per Round Per Client (75% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_75p_label_flipping_PID.png");

    % 100% Attack
    client_0 = clientDataFullAttackPID(1:maximum_rounds,:);
    client_1 = clientDataFullAttackPID(maximum_rounds+1:c1Offset, :);
    client_2 = clientDataFullAttackPID(c1Offset+1:c2Offset, :);
    client_3 = clientDataFullAttackPID(c2Offset+1:c3Offset, :);
    client_4 = clientDataFullAttackPID(c3Offset+1:c4Offset, :);
    client_5 = clientDataFullAttackPID(c4Offset+1:c5Offset, :);
    client_6 = clientDataFullAttackPID(c5Offset+1:c6Offset, :);
    client_7 = clientDataFullAttackPID(c6Offset+1:c7Offset, :);
    client_8 = clientDataFullAttackPID(c7Offset+1:c8Offset, :);
    client_9 = clientDataFullAttackPID(c8Offset+1:c9Offset, :);
    client_10 = clientDataFullAttackPID(c9Offset+1:c10Offset, :);
    client_11 = clientDataFullAttackPID(c10Offset+1:c11Offset, :);
    client_12 = clientDataFullAttackPID(c11Offset+1:c12Offset, :);
    client_13 = clientDataFullAttackPID(c12Offset+1:c13Offset, :);
    client_14 = clientDataFullAttackPID(c13Offset+1:c14Offset, :);
    client_15 = clientDataFullAttackPID(c14Offset+1:c15Offset, :);
    client_16 = clientDataFullAttackPID(c15Offset+1:c16Offset, :);
    client_17 = clientDataFullAttackPID(c16Offset+1:c17Offset, :);
    client_18 = clientDataFullAttackPID(c17Offset+1:c18Offset, :);
    client_19 = clientDataFullAttackPID(c18Offset+1:c19Offset, :);

    cmap = colormap(parula(20));
    cmap(1,:);

    figure
    c0_plot = plot(client_0, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    hold on
    c1_plot = plot(client_1, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c2_plot = plot(client_2, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
    c3_plot = plot(client_3, "Round", "Accuracy", "LineWidth", 1, ...
        "Color", "red");
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
    currFig.Name = "Accuracy Per Round Per Client (100% Label Flipping, PID-Enhanced FL Model)";
    title("Accuracy Per Round Per Client (100% Label Flipping, PID-Enhanced FL Model)");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds]);
    xlabel('Round')
    ylabel('Accuracy')
    saveas(gcf, "client_accuracy_100p_label_flipping_PID.png");



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
    currFig.Name = "Average Loss Among Clients Over Rounds (Conventional FL Model)";
    title("Average Loss Among Clients Over Rounds (Conventional FL Model)");
    legend([noAtk, tenAtk, twentyFiveAtk, fiftyAtk, seventyFiveAtk, fullAtk], ...
        aggregateLineNames, "Location", "northeastoutside");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Aggregated Loss')
    saveas(gcf, "aggregate_loss_over_rounds_CFL.png");

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
    currFig.Name = "Average Evaluation Accuracy Among Clients Over Rounds (Conventional FL Model)";
    title("Average Evaluation Accuracy Among Clients Over Rounds (Conventional FL Model)");
    legend([noAtk, tenAtk, twentyFiveAtk, fiftyAtk, seventyFiveAtk, fullAtk], ...
        aggregateLineNames, "Location", "northeastoutside");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Aggregated Accuracy')
    saveas(gcf, "aggregate_accuracy_over_rounds_CFL.png");

    %%% PID VARIANTS %%%

    figure
    % Plot without an attack.
    noAtk = plot(aggregateDataWithoutAttackPID, "Round", "AvgLoss", ...
        'LineWidth', 2);

    hold on
    % Plot with all ranges of attack percentages.
    tenAtk = plot(aggregateDataTenPercentAttackPID, "Round", "AvgLoss", ...
        'LineWidth', 2);
    twentyFiveAtk = plot(aggregateDataTwentyFivePercentAttackPID, "Round", ...
        "AvgLoss", 'LineWidth', 2);
    fiftyAtk = plot(aggregateDataFiftyPercentAttackPID, "Round", "AvgLoss", ...
        'LineWidth', 2);
    seventyFiveAtk = plot(aggregateDataSeventyFivePercentAttackPID, "Round", ...
        "AvgLoss", 'LineWidth', 2);
    fullAtk = plot(aggregateDataFullAttackPID, "Round", "AvgLoss", ...
        'LineWidth', 2);
    hold off
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Average Loss Among Clients Over Rounds (PID-Enhanced FL Model)";
    title("Average Loss Among Clients Over Rounds (PID-Enhanced FL Model)");
    legend([noAtk, tenAtk, twentyFiveAtk, fiftyAtk, seventyFiveAtk, fullAtk], ...
        aggregateLineNames, "Location", "northeastoutside");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Aggregated Loss')
    saveas(gcf, "aggregate_loss_over_rounds_PID.png");

    % Plot the average evaluation accuracy among clients over 
    % rounds. This will combine the results of all attack types.
    figure
    % Plot without an attack.
    noAtk = plot(aggregateDataWithoutAttack, "Round", "AvgAccuracy", ...
        'LineWidth', 2);

    hold on
    % Plot with all ranges of attack percentages.
    tenAtk = plot(aggregateDataTenPercentAttackPID, "Round", "AvgAccuracy", ...
        'LineWidth', 2);
    twentyFiveAtk = plot(aggregateDataTwentyFivePercentAttackPID, "Round", ...
        "AvgAccuracy", 'LineWidth', 2);
    fiftyAtk = plot(aggregateDataFiftyPercentAttackPID, "Round", "AvgAccuracy", ...
        'LineWidth', 2);
    seventyFiveAtk = plot(aggregateDataSeventyFivePercentAttackPID, "Round", ...
        "AvgAccuracy", 'LineWidth', 2);
    fullAtk = plot(aggregateDataFullAttackPID, "Round", "AvgAccuracy", ...
        'LineWidth', 2);
    hold off
    currFig = gcf;
    ax = currFig.CurrentAxes;
    ax.XTick = unique(round(ax.XTick));
    ax.Interactions = [zoomInteraction panInteraction];
    currFig.Name = "Average Evaluation Accuracy Among Clients Over Rounds (PID-Enhanced FL Model)";
    title("Average Evaluation Accuracy Among Clients Over Rounds (PID-Enhanced FL Model)");
    legend([noAtk, tenAtk, twentyFiveAtk, fiftyAtk, seventyFiveAtk, fullAtk], ...
        aggregateLineNames, "Location", "northeastoutside");
    disableDefaultInteractivity(ax);
    xlim([1 maximum_rounds])
    xlabel('Round')
    ylabel('Aggregated Accuracy')
    saveas(gcf, "aggregate_accuracy_over_rounds_PID.png");

    %%%%%%%%%%%%%%%%LOSS/ACC DEPENDENCE ON ATK SEVERITY%%%%%%%%%%%%%%%%%%

    figure
    % severities
    x = [0, 10, 25, 50, 75, 100];
    % cfl
    y_loss_cfl = [sevNoAtkLoss, sevTenAtkLoss, sevTwentyFiveAtkLoss, sevFiftyAtkLoss, ...
        sevSeventyFiveAtkLoss, sevFullAtkLoss];
    y_acc_cfl = [sevNoAtkAcc, sevTenAtkAcc, sevTwentyFiveAtkAcc, sevFiftyAtkAcc, ...
        sevSeventyFiveAtkAcc, sevFullAtkAcc];
    % pid
    y_loss_pid = [sevNoAtkLossPID, sevTenAtkLossPID, sevTwentyFiveAtkLossPID, sevFiftyAtkLossPID, ...
        sevSeventyFiveAtkLossPID, sevFullAtkLossPID];
    y_acc_pid = [sevNoAtkAccPID, sevTenAtkAccPID, sevTwentyFiveAtkAccPID, sevFiftyAtkAccPID, ...
        sevSeventyFiveAtkAccPID, sevFullAtkAccPID];

    % cfl
    loss_cfl = plot(x, y_loss_cfl, 'LineWidth', 2, 'Color', 'magenta');
    hold on;
    acc_cfl = plot(x, y_acc_cfl, 'LineWidth', 2, 'Color', 'cyan');
    xticks([0 10 25 50 75 100]);
    title('Loss and Accuracy Based on Attack Severity (Conventional FL Model)');
    xlabel('Attack Severity');
    ylabel('Dependence');
    legend([loss_cfl, acc_cfl], ["Loss", "Accuracy"], 'Location', 'northeastoutside');
    grid on;
    saveas(gcf, "loss_acc_dependence_atk_severity_CFL.png");

    % pid
    figure
    loss_pid = plot(x, y_loss_pid, 'LineWidth', 2, 'Color', 'red');
    hold on;
    acc_pid = plot(x, y_acc_pid, 'LineWidth', 2, 'Color', 'green');
    xticks([0 10 25 50 75 100]);
    title('Loss and Accuracy Based on Attack Severity (PID-Enhanced FL Model)');
    xlabel('Attack Severity');
    ylabel('Dependence');
    legend([loss_pid, acc_pid], ["Loss", "Accuracy"], 'Location', 'northeastoutside');
    grid on;
    saveas(gcf, "loss_acc_dependence_atk_severity_PID.png");

end
