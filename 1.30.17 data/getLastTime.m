T = table;
for i = 101:170
    filename = strcat('datalogS', num2str(i), '.txt')
    filedata = readtable(filename); % get data from file as table
    h = height(filedata);
    % table of last row device name, time
    last = filedata(h, {'Device', 'Time'})
    T = [T; last]; % add to table
end