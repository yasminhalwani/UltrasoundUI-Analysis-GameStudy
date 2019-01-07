MR_TIME_LIMITS_PER_PARTICIPANT = [];
GR_TIME_LIMITS_PER_PARTICIPANT = [];

MR_NO_TIME_LIMITS_PER_PARTICIPANT = [];
GR_NO_TIME_LIMITS_PER_PARTICIPANT = [];


PPT_NUMBERS = unique(USER_ID);

index_state_manual_training = strcmp(STATE(:), 'MANUAL_TRAINING');
index_state_gaze_training = strcmp(STATE(:), 'GAZE_TRAINING');

for i = 1: size(PPT_NUMBERS,1)
% for i = 1: 1
   
    user_id = PPT_NUMBERS(i); 

    index_user_id = USER_ID(:) == user_id; 

    %% count time limits in MR

    user_id_AND_manual_training = and(index_user_id, index_state_manual_training);
    
    levels = LEVEL(find(user_id_AND_manual_training));
    
    max_level = max(levels);
    
    target_level = max_level - 2;
    
    if target_level < 1
        target_level = 1;
    end
    
    index_target_level = LEVEL(:) == target_level;
    
    user_id_And_manual_training_AND_target_level = and(user_id_AND_manual_training, index_target_level);
    
    target_level_time_limits = TIME_ELAPSED(find(user_id_And_manual_training_AND_target_level));
    
    average_time_limit = mean(target_level_time_limits);
    
    MR_TIME_LIMITS_PER_PARTICIPANT = [MR_TIME_LIMITS_PER_PARTICIPANT; average_time_limit];
    
    %% count time limits in GR
    
    user_id_AND_gaze_training = and(index_user_id, index_state_gaze_training);
    
    levels = LEVEL(find(user_id_AND_gaze_training));
    
    max_level = max(levels);
    
    target_level = max_level - 2;
    
    if target_level < 1
        target_level = 1;
    end
    
    index_target_level = LEVEL(:) == target_level;
    
    user_id_And_gaze_training_AND_target_level = and(user_id_AND_gaze_training, index_target_level);
    
    target_level_time_limits = TIME_ELAPSED(find(user_id_And_gaze_training_AND_target_level));
    
    average_time_limit = mean(target_level_time_limits);
    
    GR_TIME_LIMITS_PER_PARTICIPANT = [GR_TIME_LIMITS_PER_PARTICIPANT; average_time_limit];

end

%% generate a fancy boxplot and a fancier MW calculation
disp('Timeouts U-Test');
myBoxPlotter(MR_TIME_LIMITS_PER_PARTICIPANT,GR_TIME_LIMITS_PER_PARTICIPANT,'time_limits_MW_fig')
legend('manual-based', 'gaze-supported')
xlabel('modality')
ylabel('time limit')
title('Time limits in recorded sessions');

%% generate a fancy plot
figure;
plot(1:size(PPT_NUMBERS,1), MR_TIME_LIMITS_PER_PARTICIPANT, 'b-', 1:size(PPT_NUMBERS,1), GR_TIME_LIMITS_PER_PARTICIPANT, 'r--')
set(gca,'XTick',(1:1:size(PPT_NUMBERS,1)))
ylim([0 max(max(MR_TIME_LIMITS_PER_PARTICIPANT, GR_TIME_LIMITS_PER_PARTICIPANT)) + 1 ])
set(gca,'YTick',(0:1:max(max(MR_TIME_LIMITS_PER_PARTICIPANT, GR_TIME_LIMITS_PER_PARTICIPANT)) + 1))
xlabel('participant number');
ylabel('time limits (s)');
legend('manual-based interface', 'gaze-supported interface')
title('Time limits in recorded sessions');


%% clear values not needed later
clear i;
clear average_time_limit;
clear target_level_time_limits;
clear index_state_manual_training;
clear index_state_gaze_training;
clear user_id_And_gaze_training_AND_target_level;
clear user_id_And_manual_training_AND_target_level;
clear index_target_level;
clear max_level;
clear target_level;
clear levels;
clear user_id;
clear index_user_id;
clear user_id_AND_manual_training;
clear user_id_AND_gaze_training;