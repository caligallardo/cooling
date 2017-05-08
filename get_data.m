function [dataTable] = get_data (filename)
    % given txt file w/ following header:
    % Device,Time,DHT1-OUT Temp,DHT1-OUT Hum,DHT2-IN Temp,DHT2-IN Hum,Soil,Infrared
    % followed by data delimited by commas
    % outputs a table w/ columns: 'Time',
    % 'OutTemp','OutHum','InTemp','InHum','Soil','Infrared'
    
    T = readtable(filename);
    
    % get rid of resets
    reset =  0;
     % get rid of all lines after the first beginning with 'Device'
    unwanted_row_nums = find(ismember(T.Device, 'Device'));
    for i = 1:length(unwanted_row_nums)
        T(unwanted_row_nums(i), :) = [];
        reset = 1;
    end
    
    T.Properties.VariableNames = {'Device' 'Time' 'OutTemp' 'OutHum' 'InTemp' 'InHum' 'Soil' 'Infrared'};
    
    % convert to doubles if needed
    if reset
        T.Time = cellfun(@str2num, T.Time);
        T.OutTemp = cellfun(@str2num, T.OutTemp);
        T.OutHum = cellfun(@str2num, T.OutHum);
        T.InTemp = cellfun(@str2num, T.InTemp);
        T.InHum = cellfun(@str2num, T.InHum);
        T.Soil = cellfun(@str2num, T.Soil);
        T.Infrared = cellfun(@str2num, T.Infrared);
    end
    
    % adjust for time resets
    T{:,'Time'} = adj_time(T{:, 'Time'}, 30);
    assignin('base', 'get_table_T', T);
    
    % difference columns
    temp_diffs = T{:,'InTemp'}-T{:,'OutTemp'};
    hum_diffs = T{:,'InHum'}-T{:,'OutHum'};
    diff_table = table(temp_diffs, hum_diffs, 'VariableNames', {'TempDiff' 'HumDiff'});
    assignin('base', 'diff_table', diff_table);
    
    % create table from cell c
    dataTable = [T, diff_table];    
    
end