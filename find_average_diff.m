% find average time differential (OutTemp - InTemp)
averageDiffs = zeros(6, 1);
for i = 1:6
    table = get_fridge_data(strcat('datalogS00', num2str(i), '.xlsx'));
    outTemp = table2array(table(:, {'OutTemp'}));
    inTemp = table2array(table(:, {'InTemp'}));
    tempDiff = outTemp - inTemp;
    averageDiff = mean(tempDiff);
    averageDiffs(i) = averageDiff;
end