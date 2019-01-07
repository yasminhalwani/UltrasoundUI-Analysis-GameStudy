function [container] = fill_container_with_emdat_values( container )
keys = {string('abspathanglesrate'); string('eyemovementvelocity'); string('fixationrate'); string('len'); string('meanabspathangles'); string('meanfixationduration'); string('meanpathdistance'); string('meanrelpathangles'); string('numfixations'); string('numbersamples'); string('numsegments'); string('relpathanglesrate'); string('stddevabspathangles'); string('stddevfixationduration'); string('stddevpathdistance'); string('stddevrelpathangles'); string('sumabspathangles'); string('sumfixationduration'); string('sumpathdistance'); string('sumrelpathangles')};

container(char(keys{1})) = evalin('base', 'abspathanglesrate');
container(char(keys{2})) = evalin('base', 'eyemovementvelocity');
container(char(keys{3})) = evalin('base', 'fixationrate');
container(char(keys{4})) = evalin('base', 'len');
container(char(keys{5})) = evalin('base', 'meanabspathangles');
container(char(keys{6})) = evalin('base', 'meanfixationduration');
container(char(keys{7})) = evalin('base', 'meanpathdistance');
container(char(keys{8})) = evalin('base', 'meanrelpathangles');
container(char(keys{9})) = evalin('base', 'numfixations');
container(char(keys{10})) = evalin('base', 'numbersamples');
container(char(keys{11})) = evalin('base', 'numsegments');
container(char(keys{12})) = evalin('base', 'relpathanglesrate');
container(char(keys{13})) = evalin('base', 'stddevabspathangles');
container(char(keys{14})) = evalin('base', 'stddevfixationduration');
container(char(keys{15})) = evalin('base', 'stddevpathdistance');
container(char(keys{16})) = evalin('base', 'stddevrelpathangles');
container(char(keys{17})) = evalin('base', 'sumabspathangles');
container(char(keys{18})) = evalin('base', 'sumfixationduration');
container(char(keys{19})) = evalin('base', 'sumpathdistance');
container(char(keys{20})) = evalin('base', 'sumrelpathangles');

end

