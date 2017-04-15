function v = compare_datalogs(filename1, filename2, variableName, varargin)
% variableName: 'OutTemp','OutHum','InTemp','InHum','Soil', OR 'Infrared'
% files must be text files of standard datalog format
% plots data vector from each file for variable
% returns array where first column is readings from filename1, second from
% filename2
% plotting: optional. 'off' turns plotting off. Defaults to 'on'

table1 = get_fridge_data(filename1);
table2 = get_fridge_data(filename2);
v1 = table1{:, variableName};
v2 = table2{:, variableName};
t1 = table1{:, 'Time'};
t2 = table2{:, 'Time'};

% cut for same length **** should change this to time alignment
l = min(length(v1), length(v2));
v1 = v1(1:l);
% assignin('base', 'v1', v1);
v2 = v2(1:l);
% assignin('base', 'v2', v2);
v = horzcat(v1, v2);

if ~isequal(varargin, {'off'})
    figure()
    title(strcat(variableName, ': ', filename1, ', ', filename2));
    plot(t1, v1)
    hold on
    plot(t2, v2)
    legend({filename1, filename2})
    xlabel('Time') % **** units?
end

end