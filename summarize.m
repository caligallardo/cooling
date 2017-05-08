function summary = summarize(timeWindow, varargin)
% varargin: tables to be summarized
% summary: table where cols are table names, rows are min/mean/max of
% variables

inputTables = varargin;
numTables = nargin -1;

% get table variable names
tableNames = cell(1, numTables);
for t = 1:numTables
    tableNames{t} = inputname(t+1)
end

% reduce windows
tables = cell_of_tables_reduce_window(inputTables, timeWindow)

variables={'OutTemp','OutHum','InTemp','InHum','Soil','Infrared','TempDiff' ,'HumDiff'};
row_names = cell(3*length(variables), 1);
summary_matrix = zeros(length(variables), numTables);

% fill in matrix with values
for v = 1:length(variables)
    current_var = variables{v};
    if isequal(current_var,'Time') || isequal(current_var,'Device')
        continue
    end
    row_names{v*3-2, 1} = strcat(current_var, 'Min');
    row_names{v*3-1, 1} = strcat(current_var, 'Mean');
    row_names{v*3, 1} = strcat(current_var, 'Max');
    for t = 1:numTables
        summary_matrix(v*3-2, t) = min(tables{t}{:, current_var});
        summary_matrix(v*3-1, t) = mean(tables{t}{:, current_var});
        summary_matrix(v*3, t) = max(tables{t}{:, current_var});
    end
end

summary = array2table(summary_matrix);
summary.Properties.RowNames = row_names;
summary.Properties.VariableNames = tableNames;

end