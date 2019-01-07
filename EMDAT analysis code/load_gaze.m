% copy and paste the variables and values from excel to workspace
%% IMPORTANT NOTE: in excel, change the field names "length" to "len" and "numsamples" to "numbersamples"
%% this is because 'length' and 'numsamples' are reserved names in MATLAB

keys = {string('abspathanglesrate'); string('eyemovementvelocity'); string('fixationrate'); string('len'); string('meanabspathangles'); string('meanfixationduration'); string('meanpathdistance'); string('meanrelpathangles'); string('numfixations'); string('numbersamples'); string('numsegments'); string('relpathanglesrate'); string('stddevabspathangles'); string('stddevfixationduration'); string('stddevpathdistance'); string('stddevrelpathangles'); string('sumabspathangles'); string('sumfixationduration'); string('sumpathdistance'); string('sumrelpathangles')};
gaze = containers.Map;
gaze = fill_container_with_emdat_values(gaze);

clearvars -except manual gaze;