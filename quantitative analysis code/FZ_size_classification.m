TARGET_SIZE = [];

for i = 1: size(TARGET_W, 1)
    if TARGET_W(i) >= 100 && TARGET_W(i) <= 149
        s = 1;
    else if TARGET_W(i) >= 150 && TARGET_W(i) <= 199
            s = 2;
        else if TARGET_W(i) >= 200 && TARGET_W(i) <= 249
                s = 3;
            else if TARGET_W(i) >= 250 && TARGET_W(i) <= 299
                    s = 4;
                end
            end
        end
    end
    
    TARGET_SIZE(i) = s;
end

TARGET_SIZE = TARGET_SIZE';

clear s;

    