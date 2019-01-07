index_manual_training = strcmp(STATE(:), 'MANUAL_TRAINING');
index_gaze_training = strcmp(STATE(:), 'GAZE_TRAINING');
PPT_NUMBERS = unique(USER_ID);

MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT = [];
GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT = [];

MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS = [];
GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS = [];

index_level = [];
for i = 1: max(LEVEL)
   index_level(:,i) = LEVEL(:) == i;
end

for i = 1: size(PPT_NUMBERS, 1)

        user_id = PPT_NUMBERS(i); 
        index_user_id = USER_ID(:) == user_id;
        
        %% manual training
        index_user_id_AND_manual_training = and(index_user_id, index_manual_training);
        
        user_levels = LEVEL(find(index_user_id_AND_manual_training));
        average_time_per_level = [];
        for j = 1:max(LEVEL)
            if j <= max(user_levels)
            index_user_id_AND_manual_training_AND_level = and(index_user_id_AND_manual_training, index_level(:,j));
            average = mean(TIME_ELAPSED(find(index_user_id_AND_manual_training_AND_level)));
            average_time_per_level = [average_time_per_level average];
            else
                average_time_per_level = [average_time_per_level -1];
            end
        end
        
        
        MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT = [MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT; average_time_per_level];
        
        %% gaze training
        index_user_id_AND_gaze_training = and(index_user_id, index_gaze_training);
        
        user_levels = LEVEL(find(index_user_id_AND_gaze_training));
        average_time_per_level = [];
        for j = 1:max(LEVEL)
            if j <= max(user_levels)
                index_user_id_AND_gaze_training_AND_level = and(index_user_id_AND_gaze_training, index_level(:,j));
                average = mean(TIME_ELAPSED(find(index_user_id_AND_gaze_training_AND_level)));
                average_time_per_level = [average_time_per_level average];
            else
                average_time_per_level = [average_time_per_level -1];
            end
        end
        
        GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT = [GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT; average_time_per_level];
        
end

%% plot MT learning curve
figure;
for i = 1: size(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT, 1)
   
    if sum(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i,:)<0) == 0
        record = MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i, :);
    else
        record = MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i, 1:find(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i,:)<0, 1) - 1);
    end
    
    h(i) = plot(record, 'Color',rand(1,3));
    
    legend(h(1:i))
    
    hold on;
    
end
set(gca,'XTick',(0:1:max(LEVEL)))
ylim([0 max(max(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT)) + 1])
xlim([0 max(LEVEL)])
xlabel('Level');
ylabel('Time limit (s)');
title('FZ Manual Training Learning Curve');

%% plot GT learning curve
figure;
for i = 1: size(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT, 1)
   
    if sum(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i,:)<0) == 0
        record = GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i, :);
    else
        record = GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i, 1:find(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(i,:)<0, 1) - 1);
    end
    
    h(i) = plot(record, 'Color',rand(1,3));
    
    legend(h(1:i))
    
    hold on;
    
end
set(gca,'XTick',(0:1:max(LEVEL)))
ylim([0 max(max(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT)) + 1])
xlim([0 max(LEVEL)])
xlabel('Level');
ylabel('Time limit (s)');
title('FZ Gaze Training Learning Curve');

% plot average MT and GT learning curves
manual_num_data_points_per_level = [];
gaze_num_data_points_per_level = [];

for i = 1: size(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT, 2)
    if sum(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(:, i) > 0) == 0
        MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS = [MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS];
    else
        value = mean(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(find(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(:, i) > 0), i));
        MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS = [MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS value];
    end
    
    manual_num_data_points_per_level = [manual_num_data_points_per_level size(find(MANUAL_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(:, i) > 0), 1)];
end

for i = 1: size(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT, 2)
    if sum(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(:, i) > 0) == 0
        GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS = [GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS 0];
    else
        value = mean(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(find(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(:, i) > 0), i));
        GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS = [GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS value];
    end
    
    gaze_num_data_points_per_level = [gaze_num_data_points_per_level size(find(GAZE_AVERAGE_TIME_PER_LEVEL_PER_PARTICIPANT(:, i) > 0), 1)];
end

figure;
plot(1:size(MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS,2),MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS, '-');
for i = 1: size(MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS,2)
    text(i, MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS(i), num2str(manual_num_data_points_per_level(i)))
end
hold on;
plot(1:size(GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS,2), GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS, '--');
for i = 1: size(GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS,2)
    text(i, GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS(i), num2str(gaze_num_data_points_per_level(i)))
end
legend('Manual-based', 'Gaze-supported')
set(gca,'XTick',(0:1:max(LEVEL + 1)))
ylim([0 max(max(GAZE_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS), max(MANUAL_AVERAGE_TIME_PER_LEVEL_ALL_PARTICIPANTS)) + 1])
xlim([0 max(LEVEL) + 1])
xlabel('Level');
ylabel('Time limit (s)');
title('FZ Average Training Learning Curves');

clear index_manual_training index_gaze_training index_level
clear i j h
clear user_id index_user_id 
clear index_user_id_AND_manual_training index_user_id_AND_manual_training_AND_level
clear index_user_id_AND_gaze_training index_user_id_AND_gaze_training_AND_level
clear user_levels average_time_per_level average
clear record value
clear manual_num_data_points_per_level gaze_num_data_points_per_level
