TARGET_CENTER_LOCATION_CLASS = [];

x1 = 0;
x2 = 364;
x3 = 728;
x4 = 1092;

y1 = 0;
y2 = 253;
y3 = 506;
y4 = 759;

class = 0;

for i = 1: size(TARGET_X,1)
    
    if TARGET_X(i)>= x1 && TARGET_X(i) < x2
        
        if TARGET_Y(i)>= y1 && TARGET_Y(i) < y2
            class = 7;
        end
        
        if TARGET_Y(i)>= y2 && TARGET_Y(i) < y3
            class = 4;
        end
        
        if TARGET_Y(i)>= y3 && TARGET_Y(i) < y4
            class = 1;
        end
        
    end
    
    if TARGET_X(i)>= x2 && TARGET_X(i) < x3
        
        if TARGET_Y(i)>= y1 && TARGET_Y(i) < y2
            class = 8;
        end
        
        if TARGET_Y(i)>= y2 && TARGET_Y(i) < y3
            class = 5;
        end
        
        if TARGET_Y(i)>= y3 && TARGET_Y(i) < y4
            class = 2;
        end
        
    end
    
    if TARGET_X(i)>= x3 && TARGET_X(i) < x4
        
        if TARGET_Y(i)>= y1 && TARGET_Y(i) < y2
            class = 9;
        end
        
        if TARGET_Y(i)>= y2 && TARGET_Y(i) < y3
            class = 6;
        end
        
        if TARGET_Y(i)>= y3 && TARGET_Y(i) < y4
            class = 3;
        end
        
    end
    
    TARGET_CENTER_LOCATION_CLASS = [TARGET_CENTER_LOCATION_CLASS class];
    
end

clear i;
clear x1;
clear x2;
clear x3;
clear x4;
clear y1;
clear y2;
clear y3;
clear y4;
clear class;