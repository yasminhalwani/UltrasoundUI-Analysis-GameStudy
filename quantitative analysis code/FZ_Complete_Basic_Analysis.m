%% Before running this script, make sure you import all the data through uiopen %%

convert_timeout_to_numbers;
distance_from_center_caluclation
FZ_distance_from_center_classification
TARGET_SHAPE = categorical(TARGET_SHAPE);
classify_target_position;

disp('###################### TARGET SHAPES DESCRIPTION ######################');

%% target size
string_target_size_stats = sprintf('\n[Target Width]\nMinimum = %f\nMaximum = %f\nMean = %f, SD = %f\n', min(TARGET_W), max(TARGET_W), mean(TARGET_W), std(TARGET_W));
disp(string_target_size_stats)

%% target distance from center
figure;
histogram(DISTANCE_FROM_CENTER)
title('Targets distance from center');
xlabel('distance (pixels)');
string_target_distance_from_center_stats = sprintf('[Target Distance From Center]\nMinimum  = %f\nMaximum = %f\nMean = %f, SD = %d\n', min(DISTANCE_FROM_CENTER), max(DISTANCE_FROM_CENTER), mean(DISTANCE_FROM_CENTER), std(DISTANCE_FROM_CENTER));
disp(string_target_distance_from_center_stats);

%% target shape
disp('[Target Shape]');
summary(TARGET_SHAPE)

%% target location
figure;
histogram(TARGET_CENTER_LOCATION_CLASS);
xlabel('area number');
title('Target location on screen');

figure;
plot(TARGET_CENTER_LOCATION_CLASS, DISTANCE_FROM_CENTER_CLASS, 'o');
set(gca,'XTick',(1:1:9))
ylim([1 4])
set(gca,'YTick',(1:1:4))
xlabel('target region number');
ylabel('target distance from center (classification)');
title('Target location on screen with respect to distance from center class');


%% target size compared to distance from center
figure;
plot(TARGET_W, DISTANCE_FROM_CENTER, 'o');
ylabel('distance from center');
xlabel('target size')
title('Target size compared to distance from center')

disp(sprintf('\n###################### RECORDED SESSION STATISTICS ######################'));
plot_recorded_trials_wrt_target_size_distance
string_trial_success_target_char = sprintf('\n[Recorded Session: Total Trials Statistics]\nNo. successful manual-based trials = %d\nNo. failed manual-based trials = %d\nNo. successful gaze-supported trials = %d\nNo. failed gaze-supported trials = %d\n', size(TARGET_W_MR_SUCCESSFUL, 1), size(TARGET_W_MR_FAILED, 1), size(TARGET_W_GR_SUCCESSFUL, 1), size(TARGET_W_GR_FAILED, 1));
disp(string_trial_success_target_char)


clear string_target_size_stats;
clear string_target_distance_from_center_stats;
clear string_trial_success_target_char;
clear string_trial_success_target_char;