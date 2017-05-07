function tables = cell_of_tables_reduce_window(inputTables, timeWindow)
% applies reduce_window to a cell of table objects

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
end