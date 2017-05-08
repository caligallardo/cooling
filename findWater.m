function event_times = findWater(T)
% given table T of data, returns vector of epoch times of water adding events

soil = T{:, 'Soil'};
[pks, locs] = findpeaks(soil, 'MinPeakHeight', 4, 'MinPeakProminence', 4, 'MinPeakDistance', 10);

event_times = zeros(length(pks), 1);
for i = 1:length(pks)
    index = locs(i);
    event_times(i) = T{index,'Time'};
end