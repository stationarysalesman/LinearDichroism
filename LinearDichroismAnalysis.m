% Assign variables to analyze
ref = ch2buffer450V;
sample = ch2DiO250wash10min450V;

% Analyze the reference
time = ref(1,:);
dc = ref(2,:);
r = ref(3,:);
theta = ref(4,:);
freq = ref(5,:);
avg_dc = mean(dc);
avg_r = mean(r);
% Apply correction factor to go from rms voltage to peak-peak
v_pp = 2.9405 * avg_r;
I0_par = avg_dc + 0.5 * v_pp;
I0_perp = avg_dc - 05 * v_pp;

% Analyze the sample
time_sample = sample(1,:);
dc_sample = sample(2,:);
r_sample = sample(3,:);
theta_sample = sample(4,:);
freq_sample = sample(5,:);
avg_dc_sample = mean(dc_sample);
avg_r_sample = mean(r_sample);
% Apply correction factor to go from rms voltage to peak-peak
v_pp_sample = 2.9405 * avg_r_sample;
Ipar = avg_dc_sample + 0.5 * v_pp_sample;
Iperp = avg_dc_sample - 05 * v_pp_sample;

A_par = -log10(Ipar/I0_par);
A_perp = -log10(Iperp/I0_perp);

% From Bohn, et al: The dichroic ratio is defined as the ratio of 
% absorbance of 'transverse electric' to absorbance of 'transverse
% magnetic'; here, transverse is with respect to the plane of 
% incidence. Therefore, light polarized perpendicular to the z-axis, 
% which has its electric vector in the xy-plane, has its electric vector
% oriented transverse to the plane of incidence (the xz-plane), and thus
% A parallel = A transverse electric.
ratio = A_perp/A_par;
fprintf("I0_par: %fV\n", I0_par);
fprintf("I0_perp: %fV\n", I0_perp);
fprintf("Ipar: %fV\n", Ipar);
fprintf("Iperp: %fV\n", Iperp);
fprintf("Apar: %f\n", A_par);
fprintf("Aperp: %f\n", A_perp);
fprintf("Dichroic ratio: %f\n", ratio);

% Using the known angle of incidence, calculate the angle the transition 
% moment subtends with the z-axis
% Adapted from Mark McLean's code
n1=1.55222;
n2=1.335;
n=n2/n1;
theta_i = 63;
E_x = abs(2*sqrt(power(sind(theta_i),2) - power(n,2)) * cosd(theta_i) / ... 
    sqrt(1-power(n,2)) / sqrt((1+power(n,2)) * power(sind(theta_i),2) - ... 
    power(n,2)));
E_y = abs(2*cosd(theta_i) / sqrt(1 - power(n,2)));
E_z = abs(2*cosd(theta_i) * sind(theta_i) / sqrt(1-power(n,2)) / ...
    sqrt((1+power(n,2)) * power(sind(theta_i),2) - power(n,2)));

numerator = (power(E_y, 2) / ratio) - power(E_x, 2);
denom = 2 * power(E_z, 2);
frac = numerator / denom;
theta = acotd(sqrt(frac));
fprintf("Dipole orientation angle: %f\n", theta);
