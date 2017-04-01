epochStart = 1484069880;
interval = 300; % number of seconds. approx 10 minutes
eAdded = [1484240100; 1484502240];
iAdded = round((eAdded - epochStart) / interval);

table = get_fridge_data(strcat('datalogS00', num2str(1), '.xlsx'));
soil = table2array(table(:,{'Soil'}));
[pks, locs] = findpeaks(soil, 'MinPeakProminence', 10, 'MinPeakWidth', 5);

eAdded3 = [1484240100, 1484502240];
    
epochEnd = 1484614020;