%% find correlations

SIG_MANUAL_CORRELATIONS = [];
SIG_GAZE_CORRELATIONS = [];
SIG_DIFFERENCES = [];

disp('============== SIGNIFICANT CORRELATION VALUES [MANUAL] ==============');

for i = 1: size(keys, 1)
   
    for j = i + 1:size(keys, 1)
       
        [rho, p] = corr(manual(keys{i}), manual(keys{j}), 'type', 'Pearson');
        
        if (p <= 0.05)
            
            text_to_disp = sprintf('(%24s, %24s) = %f', keys{i}, keys{j}, p);
            disp(text_to_disp);
            SIG_MANUAL_CORRELATIONS = [SIG_MANUAL_CORRELATIONS; {keys{i}, keys{j}, p}];
        end
        
    end
    
end
if size(SIG_MANUAL_CORRELATIONS, 1) == 0
    disp('No significant correlations for any manual properties');
end

disp('============== SIGNIFICANT CORRELATION VALUES [GAZE] ==============');

for i = 1: size(keys, 1)
   
    for j = i + 1:size(keys, 1)
       
        [rho, p] = corr(gaze(keys{i}), gaze(keys{j}), 'type', 'Pearson');
        
        if (p <= 0.05)
            text_to_disp = sprintf('(%24s, %24s) = %f', keys{i}, keys{j}, p);
            disp(text_to_disp);
            SIG_GAZE_CORRELATIONS = [SIG_GAZE_CORRELATIONS; {keys{i}, keys{j}, p}];
        end
        
    end
    
end
if size(SIG_GAZE_CORRELATIONS, 1) == 0
    disp('No significant correlations for any gaze properties');
end

disp('============== U-TEST [MANUAL vs GAZE] ==============');
for i = 1: size(keys, 1)
   
    p = ranksum(manual(keys{i}), gaze(keys{i}));
    
    if (p <= 0.05)
        SIG_DIFFERENCES = [SIG_DIFFERENCES; {keys{i}, p}];
    end
        
end

if size(SIG_DIFFERENCES, 1) == 0
    disp('No significant differecnes for any properties');
end

for j = 1:size(SIG_DIFFERENCES, 1)
    text_to_disp = sprintf('%24s, p = %f', SIG_DIFFERENCES{j ,1}, SIG_DIFFERENCES{j, 2});
    disp(text_to_disp);
    
    for i = 1:size(SIG_MANUAL_CORRELATIONS, 1)
        x = find(strcmp(SIG_MANUAL_CORRELATIONS(i,1), SIG_DIFFERENCES(j, 1)));
        if x == 1
            text_to_disp = sprintf('%24s correlation found with %24s', SIG_DIFFERENCES{j, 1}, SIG_MANUAL_CORRELATIONS{i,2});
            disp(text_to_disp)
        end
    end
    disp('-----------------------------------------------------')
end



clear i j p rho text_to_disp