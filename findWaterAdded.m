function findWaterAdded(datalogNum)
% datalogNum: dataset number
% plots data and predicted (blue triangle) and actual (red circle) water-adding events.

% structures containing time range (in epoch) and time of water adding
% events (in epoch)
struct1 = struct('range', [1484069880, 1484614020], 'events', [1484240100; 1484502240]);
struct2 = struct('range', [1484069880, 1484614020], 'events', 0);
struct3 = struct('range', [1484069880, 1484614020], 'events', [1484240100; 1484502240]);
struct4 = struct('range', [1484069880, 1484614020], 'events', 0);
struct5 = struct('range', [1483571700, 1484614020], 'events', [1483642800; 1484240100; 1484502240]);
struct6 = struct('range', [1484069880, 1484614020], 'events', [1484240100; 1484502240]);
struct7 = struct('range', [1484255100, 1484614020], 'events', 1484502240);

% map dataset nums to structures
myMap = containers.Map({1, 2, 3, 4, 5, 6, 7},{struct1, struct2, struct3, struct4, struct5, struct6, struct7});

myStructure = myMap(datalogNum);

table = readtable(strcat('datalogS00', num2str(datalogNum), '.xlsx'));
soil = table2array(table(:,{'Soil'}));
epochStart = myStructure.range(1);
epochEnd = myStructure.range(2);
interval = (epochEnd - epochStart) / length(soil);
epochAdded = myStructure.events;
indexAdded = round((epochAdded - epochStart) / interval);

figure()
%[pks, locs] = findpeaks(soil, 'MinPeakProminence', 10, 'MinPeakWidth', 5)
findpeaks(soil,'Annotate','extents', 'MinPeakProminence', 15, 'MinPeakWidth', 5)
hold on
for i = 1:length(indexAdded)
    scatter(indexAdded, soil(indexAdded), 'red');
end
title(strcat('datalogS00', num2str(datalogNum), '.xlsx'))
end