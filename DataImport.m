
%% Import a bunch of data files at once according to their filenames.

% Get file list and length
stem = 'ls -m ';

% Define the two directories where the data from the oscilloscope and 
% LabView program are stored
dir = '/home/tyler/data/050918/';

arg = [stem dir];
[status, cmdout] = system(arg);
if status ~= 0
    disp('your directory is bad and you should feel bad!')
    return
end

flist = strsplit(cmdout, ',');
len = length(flist); % must be same length!
for i=1:len
    % Calculate the average peak to peak voltage based on the oscilloscope
    % data
    fname = strip(flist(i));
    s = genvarname(extractBefore(fname, '__.csv'));
    path = (char(fullfile(dir, fname)));
    data = importdata(path);
    eval([s{1,1} '=data;']);
end
