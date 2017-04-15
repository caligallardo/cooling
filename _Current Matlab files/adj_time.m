function adj_time_vec = adj_time(time_vec)
% given time vector with resets,
% returns time vector where resets pick up at 30 min after last reading
step_ahead = 30 * 60;

% check input is valid
[m, n] = size(time_vec);
assert(m >= 1 && n ~= 0, 'Expected column vector');
if ~isa(time_vec, 'double')
    error('Expected double array');
end

% case size 1
if m == 1
    adj_time_vec = time_vec;
    return
end

adj_time_vec = zeros(length(time_vec), 1);
adj_time_vec(1) = time_vec(1);

for i = 2:length(time_vec)
    if time_vec(i) < time_vec(i-1)
        % increment by num_reset step_ahead's
        adj_time_vec(i) = adj_time_vec(i-1) + step_ahead;
    elseif i~=1
        % increment by difference from last reading
        adj_time_vec(i) = adj_time_vec(i-1) + (time_vec(i)-time_vec(i-1));
    end
end

end