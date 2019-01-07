% this code depends on the script convert_timeout_to_numbers

MR_TIMEOUTS_PER_PARTICIPANT = [];
GR_TIMEOUTS_PER_PARTICIPANT = [];

MR_NO_TIMEOUTS_PER_PARTICIPANT = [];
GR_NO_TIMEOUTS_PER_PARTICIPANT = [];


PPT_NUMBERS = unique(USER_ID);

index_state_manual_recorded = strcmp(STATE(:), 'MANUAL_RECORDED');
index_state_gaze_recorded = strcmp(STATE(:), 'GAZE_RECORDED');
index_timeouts = TIMEOUT(:) == 1;
index_no_timeouts = not(index_timeouts);

mr_timeout_count = 0;
gr_timeout_count = 0;

mr_no_timeout_count = 0;
gr_no_timeout_count = 0;

for i = 1: size(PPT_NUMBERS,1)
   
    user_id = PPT_NUMBERS(i); 

    index_user_id = USER_ID(:) == user_id;

    %% count timeouts and no timeouts in MR

    user_id_AND_manual_recorded = and(index_user_id, index_state_manual_recorded);

    user_id_AND_manual_recorded_AND_timeout = and(user_id_AND_manual_recorded, index_timeouts);
    mr_timeout_count = size(find(user_id_AND_manual_recorded_AND_timeout));
    MR_TIMEOUTS_PER_PARTICIPANT = [MR_TIMEOUTS_PER_PARTICIPANT; mr_timeout_count(1)];

    user_id_AND_manual_recorded_AND_no_timeout = and(user_id_AND_manual_recorded, index_no_timeouts);
    mr_no_timeout_count = size(find(user_id_AND_manual_recorded_AND_no_timeout));
    MR_NO_TIMEOUTS_PER_PARTICIPANT = [MR_NO_TIMEOUTS_PER_PARTICIPANT; mr_no_timeout_count(1)];


    %% count timeouts and no timeouts in GR

    user_id_AND_gaze_recorded = and(index_user_id, index_state_gaze_recorded);

    user_id_AND_gaze_recorded_AND_timeout = and(user_id_AND_gaze_recorded, index_timeouts);
    gr_timeout_count = size(find(user_id_AND_gaze_recorded_AND_timeout));
    GR_TIMEOUTS_PER_PARTICIPANT = [GR_TIMEOUTS_PER_PARTICIPANT; gr_timeout_count(1)];

    user_id_AND_gaze_recorded_AND_no_timeout = and(user_id_AND_gaze_recorded, index_no_timeouts);
    gr_no_timeout_count = size(find(user_id_AND_gaze_recorded_AND_no_timeout));
    GR_NO_TIMEOUTS_PER_PARTICIPANT = [GR_NO_TIMEOUTS_PER_PARTICIPANT; gr_no_timeout_count(1)];

end

%% generate a fancy boxplot and a fancier MW calculation
myBoxPlotter(MR_TIMEOUTS_PER_PARTICIPANT,GR_TIMEOUTS_PER_PARTICIPANT,'timouts_MW_fig');
legend('manual-based', 'gaze-supported');
xlabel('modality');
ylabel('number of timeouts');
title('No. timeouts in recorded sessions');

%% generate a fancy plot
figure;
plot_timeouts = plot(1:size(PPT_NUMBERS,1), MR_TIMEOUTS_PER_PARTICIPANT, 'b-', 1:size(PPT_NUMBERS,1), GR_TIMEOUTS_PER_PARTICIPANT, 'r--');
set(gca,'XTick',(1:1:size(PPT_NUMBERS,1)));
ylim([0 max(max(MR_TIMEOUTS_PER_PARTICIPANT, GR_TIMEOUTS_PER_PARTICIPANT)) + 1]);
set(gca,'YTick',(0:1:max(max(MR_TIMEOUTS_PER_PARTICIPANT, GR_TIMEOUTS_PER_PARTICIPANT)) + 1));
xlabel('participant number');
ylabel('number of timeouts');
legend('manual-based interface', 'gaze-supported interface');
title('No. timeouts in recorded sessions');



%% clear values not needed later
clear i;
clear plot_timeouts;
clear index_state_manual_recorded;
clear index_state_gaze_recorded;
clear mr_timeout_count;
clear gr_timeout_count;
clear mr_no_timeout_count;
clear gr_no_timeout_count;
clear user_id;
clear index_user_id;
clear index_no_timeouts;
clear index_timeouts;
clear user_id_AND_manual_recorded;
clear user_id_AND_manual_recorded_AND_timeout;
clear user_id_AND_manual_recorded_AND_no_timeout;
clear user_id_AND_gaze_recorded;
clear user_id_AND_gaze_recorded_AND_timeout;
clear user_id_AND_gaze_recorded_AND_no_timeout;