% Get file list and length
stem = 'ls -m ';

% Define the two directories where the data from the oscilloscope and 
% LabView program are stored
oscilloscope_dir = '/home/tyler/data/050418/scope';
labview_dir = '/home/tyler/data/050418/LabView';
oscilloscope_arg = [stem oscilloscope_dir];
labview_arg = [stem labview_dir];
[status, oscilloscope_cmdout] = system(oscilloscope_arg);
if status ~= 0
    disp('your oscilloscope directory is bad and you should feel bad!')
    return
end
[status, labview_cmdout] = system(labview_arg);
if status ~= 0
    disp('your labview directory is bad and you should feel bad!')
    return
end

oscilloscope_flist = strsplit(oscilloscope_cmdout, ',');
labview_flist = strsplit(labview_cmdout, ',');
len = length(oscilloscope_flist); % must be same length!
voltages = [300, 320, 340, 360, 380, 400, 420, 440, 460, 480]';
pp_voltages = zeros(length(voltages),1);
rms_voltages = zeros(length(voltages),1);
for i=1:len
    % Calculate the average peak to peak voltage based on the oscilloscope
    % data
    oscilloscope_fname = strip(oscilloscope_flist(i));
    oscilloscope_path = char(fullfile(oscilloscope_dir, ...
        oscilloscope_fname));
    
    % Start grabbing params from the file
    params_1 = csvread(oscilloscope_path, 0, 1, [0,1,3,1]);
    record_length = params_1(1);
    sample_interval = params_1(2);
    trigger_point = params_1(3);
    params_2 = csvread(oscilloscope_path, 8, 1, [8,1,9,1]);
    vertical_scale = params_2(1);
    vertical_offset = params_2(2);
    params_3 = csvread(oscilloscope_path, 11,1,[11,1,11,1]);
    horizontal_scale = params_3(1);
    params_4 = csvread(oscilloscope_path, 13,1,[13,1,14,1]);
    y_zero = params_4(1);
    probe_atten = params_4(2);
    
    % Grab the data  
    dat_x = csvread(oscilloscope_path, 0,3,[0,3,2499,3]);
    dat_y = csvread(oscilloscope_path, 0,4,[0,4,2499,4]);

    % Compute the minima and maxima
    [maxima, maxidx] = findpeaks(dat_y, 'MinPeakDistance', 200);
    [minima, minidx] = findpeaks(-1 * dat_y, 'MinPeakDistance', 200);
    minima = minima * -1;
    pp_V = mean(maxima) - mean(minima);
    pp_voltages(i) = pp_V;
    
    % Plotting and display
    %{
    f = figure;
    hold on;
    plot(dat_x,dat_y);
    scatter(dat_x(maxidx), maxima);
    scatter(dat_x(minidx), minima);
    hold off;
    %}
    
    % Now grab the average RMS voltage from the LabView data
    labview_fname = strip(labview_flist(i));
    labview_path = char(fullfile(labview_dir, labview_fname));
    i_rms = csvread(labview_path, 2, 0, [2, 0, 2, 59]);
    rms_voltages(i) = mean(i_rms);
end

% Determine the correction factor that transforms the RMS voltage to the 
% observed peak to peak voltage from the oscilloscope
scatter(rms_voltages, pp_voltages);