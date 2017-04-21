function plot_data(filenameORtable, timeRange, varargin)
% filenameORtable: valid filename or table
% varargin options:
% 'variable1', 'variable2', ...  OR  'All'
% - allowed variables: 'OutTemp', 'OutHum', 'InTemp', 'InHum', 'Soil',
% 'Infrared'

% get table of data
    if ~isa(filenameORtable, 'table') % is a filename
        T = get_data(filenameORtable);
    else
        T = filenameORtable;
    end

    if isequal(timeRange, 'All')
        valuesInRange = T;
    else
        % create new table with only values in range
        startTime = timeRange(1);
        endTime = timeRange(2);
        rows = (T.Time >= startTime) & (T.Time <= endTime);
        valuesInRange = T(rows, :);
    end
    
    time = table2array(valuesInRange(:, {'Time'})); % get time vector
    valuesInRange.Time = []; % remove time so do not plot
    
    % variables: cell of names of variables to be plotted
    assignin('base', 'varargin', varargin)
    if isequal(varargin, {'All'})
        variables=valuesInRange.Properties.VariableNames;
    else
        variables = varargin;
    end
    
    % color code variables
    keys = {'OutTemp', 'OutHum', 'InTemp', 'InHum', 'Soil', 'Infrared'};
    values = {'k','b','m','g','y','r'};
    colormap = containers.Map(keys, values);
    
    % plot
    figure()
    i = 1;
    assignin('base', 'v', variables)
    for var=variables
        data = table2array(valuesInRange(:,var));
        line(time, data, 'Color', colormap(cell2mat(var)))
        i = i + 1;
        hold on
    end
    legend(variables)
end 