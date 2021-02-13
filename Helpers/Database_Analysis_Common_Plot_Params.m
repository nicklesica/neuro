my_green = [50 150 50] / 255;
my_blue = [56 110 210] / 255;
my_red = [210 56 56] / 255;
my_orange = [230 159 0]/ 255;
my_pink = [204 121 167] / 255;
my_skyblue = [86 180 233] / 255;
my_gray = [0.7 0.7 0.7];
my_black = [0 0 0];

my_blue_light = min(1,1.5*my_blue);
my_red_light = min(1,1.5*my_red);
my_green_light = min(1,1.5*my_green);

% Consonant colors
fric_color = my_orange;
stop_color = my_pink;
pvowel_color = my_skyblue;
wy_color = [0 0 0];
nasal_color = my_skyblue;
vxd_color = [0.7 0.7 0.7];

consonant_colors(1,:) = fric_color;
consonant_colors(2,:) = stop_color;
consonant_colors(3,:) = nasal_color;
consonant_colors(4,:) = wy_color;
consonant_colors(5,:) = vxd_color;


con_color = my_blue;
con_color_light = min(1,1.5*con_color);

nex_color = my_red;
nex_color_light = min(1,1.5*nex_color);
nex_color_light = min(1,1.5*nex_color_light);

ha_color = my_green;
ha_color_light = min(1,1.5*ha_color);

sum_color = [0.2 0.2 0.2];
sum_color_light = min(1,1.5*sum_color);

sum_few_color = [0.7 0.7 0.7];
sum_few_color_light = min(1,1.5*sum_few_color);

diff_color = [0.1 0.1 0.1];

coh_line_thickness = 3;

hist_line_thickness = 3;

%Male
male_color = my_blue;
male_color_light = min(1,1.5*male_color);
male_color_dark = 0.66*male_color;

%Female
female_color = my_red;
female_color_light = min(1,1.5*female_color);
female_color_dark = 0.66*female_color;

%Noise
noise_color = [0 0 0];
noise_color_light = [0.5 0.5 0.5];

%Contra
contra_color = my_green;
contra_color_light = min(1,1.5*contra_color);
contra_color_dark = 0.66*contra_color;

%Ipsi
ipsi_color = [200 152 0] / 255;
ipsi_color_light = min(1,1.5*ipsi_color);

%Shuffled
shuff_color = [0.7 0.7 0.7];
shuff_style = '-';
shuff_thickness = 3;

%?
hlc=[0.7 0.7 0.7];

%Gray
gray=[0.7 0.7 0.7];

% Speech
speech_color = my_blue;
speech_color_light = min(1,1.5*speech_color);
speech_color_dark = 0.66*speech_color;

% Music
music_color = my_red;
music_color_light = min(1,1.5*music_color);
music_color_dark = 0.66*music_color;



% set(0,'DefaultFigureUnits','centimeters');
% set(0,'DefaultFigurePosition',[0 0 21 21]);
set(0,'DefaultAxesFontSize',8);
set(0,'DefaultAxesTickDir','out');
set(0,'DefaultAxesFontWeight','normal');
set(0,'DefaultAxesFontName','Arial');
set(0,'DefaultLineLineWidth',2);
set(0,'DefaultLineColor','k');

Reset_Pars