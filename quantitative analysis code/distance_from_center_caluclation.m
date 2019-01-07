DISTANCE_FROM_CENTER = [];

scene_width = 1092;
scene_height = 758;
scene_center_x = scene_width / 2;
scene_center_y = scene_height / 2;

for i = 1: size(TARGET_X, 1)
    
    DISTANCE_FROM_CENTER(i) = sqrt((TARGET_X(i) - scene_center_x)^2 + (TARGET_Y(i) - scene_center_y)^2);
    
end

DISTANCE_FROM_CENTER = DISTANCE_FROM_CENTER';

clear i
    
clear scene_width;
clear scene_height;
clear scene_center_x;
clear scene_center_y;