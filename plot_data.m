function plot_data(filename, varargin)
% reads from text file. Does not include Infrared
% varargin = 'variable1', 'variable2', ... OR 'All'
% - allowed variables: 'DHT1_OUTTemp', 'DHT1_OUTHum', 'DHT2_INTemp', 'DHT2_INHum', 'Soil'
% filename: data file to be analyzed

    T = readtable(filename);
    time = table2array(T(:, {'Time'}));
    T.Time = []; % remove time so do not plot
    T.Device = [];
    T.Infrared = [];
    
    % variables: cell of names of variables to be plotted
    if isequal(char(varargin), char('All'))
        variables=T.Properties.VariableNames
    else
        variables = varargin
    end
    C = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]}; % colors
    
    figure()
    i = 1;
    for var=variables
        data = table2array(T(:,var));
        line(time, data, 'color', cell2mat(C(i)))
        i = i + 1;
        hold on
    end
    legend(variables)
    title(filename)
end 