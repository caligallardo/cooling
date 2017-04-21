function valuesInRange = reduce_window(T, startTime, endTime)
% returns table of entries between startTime and endTime

    rows = (T.Time >= startTime) & (T.Time <= endTime);
    valuesInRange = T(rows, :);

end