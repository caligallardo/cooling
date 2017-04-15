function averageTable = averages(sensorIDs)
% sensors: array of sensor ID numbers
% averageTable: table of sensors and outtemp, intemp, outhum, inhum averages
averageTable = table;
for IDNum = sensorIDs;
    T = readtable(strcat('datalogS', num2str(IDNum), '.txt'));
    % get array of means
    avgs = mean(table2array(T(:, {'DHT1_OUTTemp','DHT1_OUTHum','DHT2_INTemp', 'DHT2_INHum'})));
    % create new table with average of values
    avgT = table(IDNum, avgs(1), avgs(2), avgs(3), avgs(4), 'VariableNames', {'Device', 'DHT1_OUTTemp','DHT1_OUTHum','DHT2_INTemp', 'DHT2_INHum'}); 
    % add to table of averages
    averageTable = [averageTable; avgT];
end