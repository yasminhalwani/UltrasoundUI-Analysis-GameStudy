SHAPE_DECRIPTION_NUMBER = [];

for i = 1: size(USER_ID,1)
    
    SHAPE_DECRIPTION_NUMBER = [SHAPE_DECRIPTION_NUMBER; TARGET_SIZE(i), DISTANCE_FROM_CENTER_CLASS(i), TARGET_CENTER_LOCATION_CLASS(i), TIMEOUT(i)];
    
end


clear i;