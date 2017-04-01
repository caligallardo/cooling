function T = get_basic_stats(allDataTable)
% allDataTable: table with all temp, hum, and soil measurements in a datalog
% table with min, max, avg of:
% - OutTemp
% - InTemp
% - OutHum
% - InHum
% - Soil
% - OutTemp - InTemp
% - OutHum - InHum

% create empty table
T = cell2table(cell(7, 3), 'VariableNames', {'Min', 'Max', 'Average'}); % 7 var, 3, metrics
T.Properties.RowNames = {'OutTemp';'OutHum';'InTemp';'InHum';'Soil';'OutTemp - InTemp';'OutHum - InHum'};

% stats for basic vars
for variable={'OutTemp','OutHum','InTemp','InHum','Soil'}
    varData = table2array(allDataTable(:, variable));
    T{variable, :} = {min(varData), max(varData), mean(varData)};
end

% differences
% % temperature
tempDiff = table2array(allDataTable(:, 'OutTemp')) - table2array(allDataTable(:, 'InTemp'));
T{'OutTemp - InTemp', :} = {min(tempDiff), max(tempDiff), mean(tempDiff)};

% % humidity
humDiff = table2array(allDataTable(:, 'OutHum')) - table2array(allDataTable(:, 'InHum'));
T{'OutHum - InHum', :} = {min(humDiff), max(humDiff), mean(humDiff)};

end