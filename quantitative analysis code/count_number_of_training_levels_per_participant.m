NUMBER_OF_MANUAL_TRAINING_LEVELS = [];
NUMBER_OF_GAZE_TRAINING_LEVELS = [];

number_of_ppts = size(unique(USER_ID),1);
ppt_numbers = unique(USER_ID);

manual_training_list = strcmp('MANUAL_TRAINING', STATE);
gaze_training_list = strcmp('GAZE_TRAINING', STATE);

for i = 1: number_of_ppts
   
    ppt_list = USER_ID == ppt_numbers(i);
    
    ppt_AND_manual_training = and(ppt_list, manual_training_list);
    ppt_AND_gaze_training = and(ppt_list, gaze_training_list);
    
    indexes_manual_training = find(ppt_AND_manual_training);
    indexes_gaze_training = find(ppt_AND_gaze_training);
    
    manual_levels = [];
    gaze_levels = [];
    
    for j = 1: size(indexes_manual_training)
        manual_levels = [manual_levels LEVEL(indexes_manual_training(j))]; 
    end
    
    for j = 1: size(indexes_gaze_training)
        gaze_levels = [gaze_levels LEVEL(indexes_gaze_training(j))]; 
    end
    
    manual_levels = unique(manual_levels);
    gaze_levels = unique(gaze_levels);
    
    NUMBER_OF_MANUAL_TRAINING_LEVELS = [NUMBER_OF_MANUAL_TRAINING_LEVELS size(manual_levels, 2)];
    NUMBER_OF_GAZE_TRAINING_LEVELS = [NUMBER_OF_GAZE_TRAINING_LEVELS, size(gaze_levels, 2)];
end

plot(1:number_of_ppts, NUMBER_OF_MANUAL_TRAINING_LEVELS, 'o', 1:number_of_ppts, NUMBER_OF_GAZE_TRAINING_LEVELS, '*');
ylim([0 10]);
xlim([0 number_of_ppts + 1]);
set(gca,'XTick',(1:1:number_of_ppts + 1));
xlabel('participant number');
ylabel('number of training levels');
legend('manual-based', 'gaze-supported');

clear number_of_ppts;
clear ppt_numbers;
clear manual_training_list;
clear gaze_training_list;
clear ppt_list;
clear ppt_AND_manual_training
clear ppt_AND_gaze_training;
clear indexes_manual_training;
clear indexes_gaze_training;
clear manual_levels;
clear gaze_levels;
clear j;
clear i;