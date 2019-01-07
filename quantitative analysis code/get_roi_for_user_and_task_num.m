% IMPORTANT NOTE: se the values for user_id and task_num

ROI_MANUAL_USER_ID_TASK_NUM = [];
ROI_GAZE_USER_ID_TASK_NUM = [];

task_num_list = TASK_NUM(:) == task_num;

index_user_id = USER_ID(:) == user_id; 

%% manual task for participant

index_state_manual_recorded = strcmp(STATE(:), 'MANUAL_RECORDED');

user_id_AND_manual_recorded = and(index_user_id, index_state_manual_recorded);

user_id_AND_manual_recorded_AND_task_num = and(user_id_AND_manual_recorded, task_num_list);

indexes = find(user_id_AND_manual_recorded_AND_task_num);

for i = (indexes(1): indexes(size(indexes,1)))
    entry = [ROI_X(i) ROI_Y(i) ROI_W(i) ROI_H(i)];
    
    ROI_MANUAL_USER_ID_TASK_NUM = [ROI_MANUAL_USER_ID_TASK_NUM; entry];
end

%% gaze task for participant

index_state_gaze_recorded = strcmp(STATE(:), 'GAZE_RECORDED');

user_id_AND_gaze_recorded = and(index_user_id, index_state_gaze_recorded);

user_id_AND_gaze_recorded_AND_task_num = and(user_id_AND_gaze_recorded, task_num_list);

indexes = find(user_id_AND_gaze_recorded_AND_task_num);

for i = (indexes(1): indexes(size(indexes,1)))
    entry = [ROI_X(i) ROI_Y(i) ROI_W(i) ROI_H(i)];
    
    ROI_GAZE_USER_ID_TASK_NUM = [ROI_GAZE_USER_ID_TASK_NUM; entry];
end

clear task_num_list;
clear index_state_manual_recorded;
clear index_user_id;
clear user_id_AND_manual_recorded;
clear user_id_AND_manual_recorded_AND_task_num;
clear index_state_gaze_recorded;
clear user_id_AND_gaze_recorded;
clear user_id_AND_gaze_recorded_AND_task_num;
clear roi_gaze_user_5_task_num;
clear roi_manual_user_5_task_num;
clear i;
clear indexes;
clear entry;