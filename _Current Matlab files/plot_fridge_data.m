function plot_fridge_data(filename, varargin)
% filename: txt file w/ header:
% Device,Time,DHT1-OUT Temp,DHT1-OUT Hum,DHT2-IN Temp,DHT2-IN Hum,Soil,Infrared
% (names don't matter, only variable order)
% followed by data delimited by commas
% 
% varargin: 'variable1', 'variable2', ... OR 'All'
% - allowed variables: 'Time', 'OutTemp','OutHum','InTemp','InHum','Soil','Infrared'

    T = get_fridge_data(filename);

    % variables: cell of names of variables to be plotted
    if isequal(char(varargin), char('All'))
        variables=T.Properties.VariableNames;
    else
        variables = varargin;
    end
    C = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]}; % colors
    
    figure()
    time = table2array(T(:, {'Time'}));
    i = 1;
    for var=variables,
        if ~isequal(table2array(var), 'Time')
            data = table2array(T(:,var));
            line(time, data, 'color', cell2mat(C(i)))
            i = i + 1;
            hold on
        end
    end
    legend(variables)
    title(filename)
end 