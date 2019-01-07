% Assign variables to analyze
ref_par = ReferenceVerticalR2;
ref_perp = ReferenceHorizontalR2;
sample_par = SampleVerticalS2;
sample_perp = SampleHorizontalS2;

% Analyze the reference
ref_par_dc = ref_par(2,:);
ref_par_diode = ref_par(3,:);
ref_perp_dc = ref_perp(2,:);
ref_perp_diode = ref_perp(3,:);

% Note: we are dividing by the diode voltage to account for laser drift
ref_par_normalized = mean(ref_par_dc) / mean(ref_par_diode);
ref_perp_normalized = mean(ref_perp_dc) / mean(ref_perp_diode);

% Analyze the sample
sample_par_dc = sample_par(2,:);
sample_par_diode = sample_par(3,:);
sample_perp_dc = sample_perp(2,:);
sample_perp_diode = sample_perp(3,:);

% Note: we are dividing by the diode voltage to account for laser drift
sample_par_normalized = mean(sample_par_dc) / mean(sample_par_diode);
sample_perp_normalized = mean(sample_perp_dc) / mean(sample_perp_diode);

A_par = -log10(sample_par_normalized / ref_par_normalized);
A_perp = -log10(sample_perp_normalized / ref_perp_normalized);

% From Bohn, et al: The dichroic ratio is defined as the ratio of 
% absorbance of 'transverse electric' to absorbance of 'transverse
% magnetic'; here, transverse is with respect to the plane of 
% incidence. Therefore, light polarized perpendicular to the z-axis, 
% which has its electric vector in the xy-plane, has its electric vector
% oriented transverse to the plane of incidence (the xz-plane), and thus
% A parallel = A transverse electric.
%
% Additional note: since we are dividing every voltage by the reference,
% all numbers are pure and thus have no units, except the orientation.

ratio = A_perp/A_par;

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