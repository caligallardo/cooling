function compare_datalogs(inputTables, variableNames, timeWindow)
% filenames: {filename1, filename2, ...} limited to 4
% variableNames: {variableName1, variableName2, ...} OR 'All'
% Possible variables: 'OutTemp','OutHum','InTemp','InHum','Soil', OR 'Infrared'
% timeWindow: [startTime, endTime] OR 'All'
% files must be text files of standard datalog format

numTables = length(inputTables);
tables = cell(1, numTables);
if isequal(timeWindow, 'All')
    for i=1:numTables
       tables{i} = inputTables{i}; 
    end
else
    for i=1:numTables
        tables{i} = reduce_window(inputTables{i}, timeWindow(1), timeWindow(2)); 
    end
end

% variables: cell of names of variables to be plotted
if isequal(variableNames, 'All')
    variables={'OutTemp','OutHum','InTemp','InHum','Soil','Infrared'};
else
    variables = variableNames;
end

% assign colors to variables
keys = {'OutTemp', 'OutHum', 'InTemp', 'InHum', 'Soil', 'Infrared'};
values = {'k','b','m','g','y','r'};
colormap = containers.Map(keys, values);

% assign line types to files. limit of 4
keys = [1, 2, 3, 4];
values = {'-','--',':', '-.'};
linemap = containers.Map(keys, values);

allvar = cell(1, length(variables)*numTables); % for legend

% plot
    figure()
    i = 1;
    assignin('base', 'v', variables)
    for v=1:length(variables)
        var = variables{v};
        for tabNum=1:numTables
            tab = tables{tabNum};
            assignin('base', 'var', var);
            time = table2array(tab(:, 'Time'));
            data = table2array(tab(:,var));
            line(time, data, 'Color', colormap(var), 'LineStyle', linemap(tabNum))
            hold on
            allvar{1, i} = [var, ' ', num2str(tabNum)];
            i = i + 1;
        end
    end
%     myTitle = inputTables{1};
%     for i = 2:numTables
%         %myTitle = [myTitle, ', ', inputTables{i}];
%     end
%     title(myTitle);
    legend(allvar);

end