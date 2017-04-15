function T = get_basic_stats(allDataTable, varargin)
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

[m, n] = size(allDataTable);
startIndex = 1;
endIndex = m;
% optional epoch range
if nargin == 3
    % get row #s of entries in range
    assignin('base', 'myvar',varargin)
    startTime = cell2mat(varargin(1));
    endTime = cell2mat(varargin(2));
    for i = 1:m
        if allDataTable{i, 1} <= startTime
            startIndex = i;
        end
        if allDataTable{i, 1} <= endTime
            endIndex = i;
        end
    end
    startIndex = startIndex;
    endIndex = endIndex;
end

% stats for basic vars
for variable={'OutTemp','OutHum','InTemp','InHum','Soil'}
    varData = table2array(allDataTable(startIndex:endIndex, variable));
    T{variable, :} = {min(varData), max(varData), mean(varData)};
end

% differences
% % temperature
tempDiff = table2array(allDataTable(startIndex:endIndex, 'OutTemp')) - table2array(allDataTable(startIndex:endIndex, 'InTemp'));
T{'OutTemp - InTemp', :} = {min(tempDiff), max(tempDiff), mean(tempDiff)};

% % humidity
humDiff = table2array(allDataTable(startIndex:endIndex, 'OutHum')) - table2array(allDataTable(startIndex:endIndex, 'InHum'));
T{'OutHum - InHum', :} = {min(humDiff), max(humDiff), mean(humDiff)};

end