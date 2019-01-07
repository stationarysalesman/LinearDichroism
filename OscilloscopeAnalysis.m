% Grab the data
path = '/home/tyler/data/060218/50nMscope.CSV';
dat_x = csvread(path, 0,3,[0,3,2499,3]);
dat_y = csvread(path, 0,4,[0,4,2499,4]);


f=figure;
plot(dat_x,dat_y);
waitfor(f);

maxima = findpeaks(dat_y, 'MinPeakDistance', 200);
minima = -1 * findpeaks(-1 * dat_y, 'MinPeakDistance', 200);
disp(mean(maxima));
disp(mean(minima));
pp_V = mean(maxima) - mean(minima);
pp_voltages = pp_V;
rms_voltages = pp_V * 2 * sqrt(2);
disp(pp_V);