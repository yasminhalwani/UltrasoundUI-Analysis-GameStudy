convert_timeout_to_numbers

MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [];
GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [];

MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [];
GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [];

MT_TIMEOUTS_PER_PARTICIPANT = [];
GT_TIMEOUTS_PER_PARTICIPANT = [];

MT_NO_TIMEOUTS_PER_PARTICIPANT = [];
GT_NO_TIMEOUTS_PER_PARTICIPANT = [];


PPT_NUMBERS = unique(USER_ID);

index_state_manual_training = strcmp(STATE(:), 'MANUAL_TRAINING');
index_state_gaze_training = strcmp(STATE(:), 'GAZE_TRAINING');
index_timeouts = TIMEOUT(:) == 1;
index_no_timeouts = not(index_timeouts);

for j = 1: max(LEVEL)
    
    index_level_n = LEVEL(:) == j;
    
    for i = 1: size(PPT_NUMBERS, 1)

        user_id = PPT_NUMBERS(i); 

        index_user_id = USER_ID(:) == user_id;

        %% count timeouts and no timeouts in mt

        user_id_AND_manual_training = and(index_user_id, index_state_manual_training);
        
        user_id_AND_manual_training_AND_timeout = and(user_id_AND_manual_training, index_timeouts);
        user_id_AND_manual_training_AND_timeout_AND_level_n = and(user_id_AND_manual_training_AND_timeout, index_level_n);
        
        mt_timeout_count = size(find(user_id_AND_manual_training_AND_timeout_AND_level_n));
        MT_TIMEOUTS_PER_PARTICIPANT = [MT_TIMEOUTS_PER_PARTICIPANT; mt_timeout_count(1)];

        user_id_AND_manual_training_AND_no_timeout = and(user_id_AND_manual_training, index_no_timeouts);
        user_id_AND_manual_training_AND_no_timeout_AND_level_n = and(user_id_AND_manual_training_AND_no_timeout, index_level_n);
        
        mt_no_timeout_count = size(find(user_id_AND_manual_training_AND_no_timeout_AND_level_n));
        MT_NO_TIMEOUTS_PER_PARTICIPANT = [MT_NO_TIMEOUTS_PER_PARTICIPANT; mt_no_timeout_count(1)];


        %% count timeouts and no timeouts in gt

        user_id_AND_gaze_training = and(index_user_id, index_state_gaze_training);

        user_id_AND_gaze_training_AND_timeout = and(user_id_AND_gaze_training, index_timeouts);
        user_id_AND_gaze_training_AND_timeout_AND_level_n = and(user_id_AND_gaze_training_AND_timeout, index_level_n);
        
        gt_timeout_count = size(find(user_id_AND_gaze_training_AND_timeout_AND_level_n));
        GT_TIMEOUTS_PER_PARTICIPANT = [GT_TIMEOUTS_PER_PARTICIPANT; gt_timeout_count(1)];

        user_id_AND_gaze_training_AND_no_timeout = and(user_id_AND_gaze_training, index_no_timeouts);
        user_id_AND_gaze_training_AND_no_timeout_AND_level_n = and(user_id_AND_gaze_training_AND_no_timeout, index_level_n);
        
        gt_no_timeout_count = size(find(user_id_AND_gaze_training_AND_no_timeout_AND_level_n));
        GT_NO_TIMEOUTS_PER_PARTICIPANT = [GT_NO_TIMEOUTS_PER_PARTICIPANT; gt_no_timeout_count(1)];

    end
    
    MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, MT_TIMEOUTS_PER_PARTICIPANT];
    GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, GT_TIMEOUTS_PER_PARTICIPANT];

    MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, MT_NO_TIMEOUTS_PER_PARTICIPANT];
    GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS = [GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, GT_NO_TIMEOUTS_PER_PARTICIPANT];
    
    MT_TIMEOUTS_PER_PARTICIPANT = [];
    GT_TIMEOUTS_PER_PARTICIPANT = [];

    MT_NO_TIMEOUTS_PER_PARTICIPANT = [];
    GT_NO_TIMEOUTS_PER_PARTICIPANT = [];
end

%% get total number of successes and fails in all traiing levels per participant

MT_TOTAL_SUCCESSES = sum(MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS');
GT_TOTAL_SUCCESSES = sum(GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS');

MT_TOTAL_FAILS = sum(MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS');
GT_TOTAL_FAILS = sum(GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS');

%% flag the rest of the trials as -1 after the 14 timeouts

max_manual_level = [];
max_gaze_level = [];

for i = 1: size(MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, 1)
   
    mt_timeout_record = MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :);
    gt_timeout_record = GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :);
    mt_no_timeout_record = MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :);
    gt_no_timeout_record = GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :);
    
    max_manual_level = [max_manual_level; find(mt_timeout_record == 14)];
    max_gaze_level = [max_gaze_level; find(gt_timeout_record == 14)];
    
    for j = max_manual_level(i) + 1:size(MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS,2)
        mt_timeout_record(j) = -1;
        mt_no_timeout_record(j) = -1;
    end
    
    for j = max_gaze_level(i) + 1:size(GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS,2)
        gt_timeout_record(j) = -1;
        gt_no_timeout_record(j) = -1;
    end
    
    MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :) = mt_timeout_record;
    GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :) = gt_timeout_record;
    MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :) = mt_no_timeout_record;
    GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, :) = gt_no_timeout_record;
    
end

%% plot MT timeouts
figure;
for i = 1: size(MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, 1)
   
    record = MT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, 1:max_manual_level(i));
    
    h(i) = plot(record, 'Color',rand(1,3));
    
    legend(h(1:i))
    
    hold on;
    
end
set(gca,'XTick',(1:1:max(max_manual_level)))
ylim([1 15])
xlabel('Level');
ylabel('No. timeouts');
title('FZ Manual Training: Number of timeouts per level per participant');


%% plot GT timeouts
figure;
for i = 1: size(GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, 1)
   
    record = GT_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, 1:max_gaze_level(i));
    
    h(i) = plot(record, 'Color',rand(1,3));
    
    legend(h(1:i))
    
    hold on;
    
end
set(gca,'XTick',(1:1:max(max_gaze_level)))
ylim([1 15])
xlabel('Level');
ylabel('No. timeouts');
title('FZ Gaze Training: Number of timeouts per level per participant');


%% plot MT successful trials
figure;
for i = 1: size(MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, 1)
   
    record = MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, 1:max_manual_level(i));
    
    h(i) = plot(record, 'Color',rand(1,3));
    
    legend(h(1:i))
    
    hold on;
    
end
set(gca,'XTick',(1:1:max(max_gaze_level)))
ylim([1 max(max(MT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS)) + 1])
xlabel('Level');
ylabel('No. timeouts');
title('FZ Manual Training: Number of succesful trials per level per participant');

%% plot GT successful trials
figure;
for i = 1: size(GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS, 1)
   
    record = GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS(i, 1:max_manual_level(i));
    
    h(i) = plot(record, 'Color',rand(1,3));
    
    legend(h(1:i))
    
    hold on;
    
end
set(gca,'XTick',(1:1:max(max_gaze_level)))
ylim([1 max(max(GT_NO_TIMEOUTS_PER_PARTICIPANT_ALL_LEVELS)) + 1])
xlabel('Level');
ylabel('No. timeouts');
title('FZ Gaze Training: Number of succesful trials per level per participant');


%% clear values not needed later
clear record;
clear h;
clear i;
clear j;
clear max_gaze_level;
clear max_manual_level;
clear mt_timeout_record;
clear gt_timeout_record;
clear mt_no_timeout_record;
clear gt_no_timeout_record;
clear index_level_n;
clear index_state_manual_training;
clear index_state_gaze_training;
clear mt_timeout_count;
clear gt_timeout_count;
clear mt_no_timeout_count;
clear gt_no_timeout_count;
clear user_id;
clear index_user_id;
clear index_no_timeouts;
clear index_timeouts;
clear user_id_AND_manual_training;
clear user_id_AND_manual_training_AND_timeout;
clear user_id_AND_manual_training_AND_no_timeout;
clear user_id_AND_gaze_training;
clear user_id_AND_gaze_training_AND_timeout;
clear user_id_AND_gaze_training_AND_no_timeout;
clear user_id_AND_gaze_training_AND_no_timeout_AND_level_n;
clear user_id_AND_gaze_training_AND_timeout_AND_level_n;
clear user_id_AND_manual_training_AND_no_timeout_AND_level_n;
clear user_id_AND_manual_training_AND_timeout_AND_level_n;
clear MT_TIMEOUTS_PER_PARTICIPANT;
clear GT_TIMEOUTS_PER_PARTICIPANT;
clear MT_NO_TIMEOUTS_PER_PARTICIPANT;
clear GT_NO_TIMEOUTS_PER_PARTICIPANT;
