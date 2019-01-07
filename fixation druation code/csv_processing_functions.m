
function SUB = get_sub_matrix(input_mat, fixation_start, fixation_end)

fpog_id_mat = find(any(input_mat(:,2) == fixation_start,2));

fpog_start_row_num = fpog_id_mat(1,1);

fpog_id_mat = find(any(input_mat(:,2) == fixation_end,2));

size_mat = size(fpog_id_mat);

last_entry = size_mat(1,1);

fpog_end_row_num = fpog_id_mat(last_entry,1);

SUB = input_mat(fpog_start_row_num:fpog_end_row_num, :);

end
