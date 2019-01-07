function [ average_fixation_duration, validity_percentage ] = find_average_fixation_duration( INPUT )


[INPUT_validity_percentage, INPUT_valid] = find_validity_percentage(INPUT);
INPUT_valid_unique = unique(INPUT_valid(:,2));

INPUT_fixation_duration_matrix = [];
 
for i = 1:length(INPUT_valid_unique)
    
INPUT_row_num = find(any(INPUT_valid(:,2) == INPUT_valid_unique(i),2));
s = size(INPUT_row_num);
row = INPUT_row_num(s(1));
INPUT_fixation_duration_matrix(i,:) = INPUT_valid(row,:);
 
end

INPUT_average_fixation_duration = mean(INPUT_fixation_duration_matrix(:,3));

average_fixation_duration = INPUT_average_fixation_duration;
validity_percentage = INPUT_validity_percentage;

end

