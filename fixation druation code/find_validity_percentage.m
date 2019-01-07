function [ valid_points_percentage, valid_matrix ] = find_validity_percentage( input_matrix )

valid_points_count = 0;

validity_matrix = input_matrix(:,4);

valid_matrix = [];

for i = 1:length(validity_matrix)
if (validity_matrix(i) == 1)
    valid_points_count = valid_points_count + 1;
    valid_matrix(valid_points_count,:) = input_matrix(i,:);
end
end

valid_points_percentage = (valid_points_count / length(input_matrix(:,4))) * 100;

end

