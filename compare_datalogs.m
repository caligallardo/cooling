function compare_datalogs(variableNames, timeWindow, varargin)
% variableNames: {variableName1, variableName2, ...} OR 'All'
% Possible variables: 'OutTemp','OutHum','InTemp','InHum','Soil',
% % 'Infrared', 'TempDiff', OR 'HumDiff'
% % 'All' plots 'OutTemp','OutHum','InTemp','InHum','Soil', 'Infrared' only
% timeWindow: [startTime, endTime] OR 'All'
% varargin: tables to be plotted

inputTables = varargin;
numTables = length(inputTables);

% reduce window
tables = cell_of_tables_reduce_window(inputTables, timeWindow)

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
            time = tab{:, 'Time'};
            data = tab{:,var};
            line(time, data, 'Color', colormap(var), 'LineStyle', linemap(tabNum))
            hold on
            allvar{1, i} = [var, ' ', num2str(tabNum)];
            i = i + 1;
        end
    end

    legend(allvar);

    mytitle = inputname(3);
    for i=2:numTables
        mytitle = strcat(mytitle, ', ', inputname(i+2));
    end
    title(mytitle)
end