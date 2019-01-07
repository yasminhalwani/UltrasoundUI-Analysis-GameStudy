%%%%%%%%%%%%%%%%%%%%%
% LOGIC
%%%%%%%%%%%%%%%%%%%%%

data_init_FZ
data_init_DZ

% initialize variables based on participant and experiment

MT_s = DZ_P3_MT_s;
MT_e = DZ_P3_MT_e;

MR_s = DZ_P3_MR_s;
MR_e = DZ_P3_MR_e;

GT_s = DZ_P3_GT_s;
GT_e = DZ_P3_GT_e;

GR_s = DZ_P3_GR_s;
GR_e = DZ_P3_GR_e;

%%%%%%%%%%%%%%%%%%%%%
% CREATE MATRICES
%%%%%%%%%%%%%%%%%%%%%

P = combine_csv(CNT, FPOGID, FPOGD, FPOGV);


MT = get_sub_matrix(P, MT_s, MT_e);
MR = get_sub_matrix(P, MR_s, MR_e);
GT = get_sub_matrix(P, GT_s, GT_e);
GR = get_sub_matrix(P, GR_s, GR_e);

%%%%%%%%%%%%%%%%%%%%%
% FIND VALIDITIES + FIX DURATIONS
%%%%%%%%%%%%%%%%%%%%%

[MT_fix_duration, MT_valid] = find_average_fixation_duration(MT);
[MR_fix_duration, MR_valid] = find_average_fixation_duration(MR);
[GT_fix_duration, GT_valid] = find_average_fixation_duration(GT);
[GR_fix_duration, GR_valid] = find_average_fixation_duration(GR);

%%%%%%%%%%%%%%% PRINT
MT_fix_duration
MR_fix_duration
GT_fix_duration
GR_fix_duration