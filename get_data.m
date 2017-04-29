function [dataTable] = get_data (filename)
    % given txt file w/ following header:
    % Device,Time,DHT1-OUT Temp,DHT1-OUT Hum,DHT2-IN Temp,DHT2-IN Hum,Soil,Infrared
    % followed by data delimited by commas
    % outputs a table w/ columns: 'Time',
    % 'OutTemp','OutHum','InTemp','InHum','Soil','Infrared'
    
    c = {'Time','OutTemp','OutHum','InTemp','InHum','Soil','Infrared'}; % create cell array to convert to table
    
    fid = fopen(filename);
    tline = fgetl(fid);
    while ischar(tline)
        %disp(tline)
        linecell = textscan(tline, '%s %f %f %f %f %f %f %f', 'Delimiter', ',');
        newrow = linecell(2:length(linecell));
        if isempty(linecell{2})
            % is reset header
        else
            % add to data cell
            c = [c;newrow];
        end
        tline = fgetl(fid);
    end
    fclose(fid);    
    
    % adjust for time resets
    [m, n] = size(c);
    c(2:m, 1) = num2cell(adj_time(cell2mat(c(2:m, 1))));
    
    % difference columns
    header = {'TempDiff', 'HumDiff'}
    td=cell2mat(c(2:m, 4))-cell2mat(c(2:m, 2))
    length(td)
    tempDiff = num2cell(td)
    humDiff = num2cell(cell2mat(c(2:m, 5))-cell2mat(c(2:m, 3)));
    diffCols = [header; [tempDiff, humDiff]];
    
    c = [c, diffCols];
    
    % create table from cell c
    dataTable = cell2table(c(2:m, :), 'VariableNames', c(1, :));    
    
end