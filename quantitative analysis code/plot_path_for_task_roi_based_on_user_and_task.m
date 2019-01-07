user_id = 5;
manual_task_num = 1;
gaze_task_num = 14;

task_num = manual_task_num;
get_roi_for_user_and_task_num;
manual = ROI_MANUAL_USER_ID_TASK_NUM;
manual = manual(1:size(manual,1) - 1, :);

task_num = gaze_task_num;
get_roi_for_user_and_task_num;
gaze = ROI_GAZE_USER_ID_TASK_NUM;
gaze = gaze(1:size(gaze,1) - 1, :);

figure;
plot(diff(manual(:,1)))
figure;
plot(diff(gaze(:,1)))

figure;
subplot(2, 2, 1);
plot(1:1:size(manual), manual(:, 1), '-', 1:1:size(gaze), gaze(:, 1), '--')
legend('manual', 'gaze')
title('horizontal movements');
xlabel('ROI steps (pixels)');
ylabel('ROI X');

subplot(2, 2, 2);
plot(1:1:size(manual), manual(:, 2), '-', 1:1:size(gaze), gaze(:, 2), '--')
legend('manual', 'gaze')
title('vertical movements');
xlabel('ROI steps (pixels)');
ylabel('ROI Y');

subplot(2, 2, 4);
plot(1:1:size(manual), manual(:, 3), '-', 1:1:size(gaze), gaze(:, 3), '--')
legend('manual', 'gaze')
title('size');
xlabel('ROI steps (pixels)');
ylabel('ROI size (pixels)');

subplot(2, 2, 4);

info_1 = sprintf('User # %d \n----------------------\n\n', user_id);


user_id_list = USER_ID == user_id;

task_num_list = TASK_NUM == manual_task_num;
state_list = strcmp(STATE, 'MANUAL_RECORDED');
user_id_AND_task_num = and(user_id_list, task_num_list);
user_id_AND_task_num_AND_state = and(user_id_AND_task_num, state_list);
indexes = find(user_id_AND_task_num_AND_state);
x = TARGET_X(indexes(1));
y = TARGET_Y(indexes(1));
w = TARGET_W(indexes(1));
h = TARGET_H(indexes(1));
timeout = TIMEOUT(indexes(1));

info_2 = sprintf('\nManual Task # %d\nTimeout: %d\nTarget Pos = (%d, %d)\nTarget Size = (%d, %d)\n---\n\n', manual_task_num, timeout, x, y, w, h);

task_num_list = TASK_NUM == gaze_task_num;
state_list = strcmp(STATE, 'GAZE_RECORDED');
user_id_AND_task_num = and(user_id_list, task_num_list);
user_id_AND_task_num_AND_state = and(user_id_AND_task_num, state_list);
indexes = find(user_id_AND_task_num_AND_state);
x = TARGET_X(indexes(1));
y = TARGET_Y(indexes(1));
w = TARGET_W(indexes(1));
h = TARGET_H(indexes(1));
timeout = TIMEOUT(indexes(1));

info_3 = sprintf('\nGaze Task # %d\nTimeout: %d\nTarget Pos = (%d, %d)\nTarget Size = (%d, %d)', gaze_task_num, timeout, x, y, w, h);

h=axes;
set(h,'Visible','off')
text(0,0.2,strcat(info_1, info_2, info_3))


clear info_1;
clear info_2;
clear user_id_list;
clear task_num_list;
clear state_list;
clear user_id_AND_task_num;
clear user_id_AND_task_num_AND_state;
clear indexes;
clear manual;
clear gaze;
clear x;
clear y;
clear w;
clear h;
clear timeout;

