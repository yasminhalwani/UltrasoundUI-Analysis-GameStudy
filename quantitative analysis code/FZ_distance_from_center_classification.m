DISTANCE_FROM_CENTER_CLASS = [];

for i = 1: size(DISTANCE_FROM_CENTER, 1)
    if DISTANCE_FROM_CENTER(i) >= 0 && DISTANCE_FROM_CENTER(i) <= 99
        s = 1;
    else if DISTANCE_FROM_CENTER(i) >= 100 && DISTANCE_FROM_CENTER(i) <= 199
            s = 2;
        else if DISTANCE_FROM_CENTER(i) >= 200 && DISTANCE_FROM_CENTER(i) <= 299
                s = 3;
            else if DISTANCE_FROM_CENTER(i) >= 300 && DISTANCE_FROM_CENTER(i) <= 399
                    s = 4;
                end
            end
        end
    end
    
    DISTANCE_FROM_CENTER_CLASS(i) = s;
end

DISTANCE_FROM_CENTER_CLASS = DISTANCE_FROM_CENTER_CLASS';

clear s;
clear i;

    