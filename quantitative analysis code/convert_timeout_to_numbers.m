TIMEOUT_INT = [];

if isa(TIMEOUT(1), 'cell')

    for i = 1: size(TIMEOUT, 1)

        if strcmp(TIMEOUT(i), 'TRUE') || strcmp(TIMEOUT(i), 'True')
            TIMEOUT_INT(i) = 1;
        else
            TIMEOUT_INT(i) = 0;
        end
    end

    TIMEOUT = TIMEOUT_INT;

    clear TIMEOUT_INT;

    TIMEOUT = TIMEOUT';

    clear i;
end