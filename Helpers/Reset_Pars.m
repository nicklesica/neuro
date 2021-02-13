%% Default plot options
clear pars

try
pars.plot.all_colors = [con_color;nex_color;ha_color;0 0 0];
catch
pars.plot.all_colors = [0 0 0];
end
try    
pars.plot.all_colors_light = [con_color_light;nex_color_light;ha_color_light;0 0 0];
catch
pars.plot.all_colors_light = [0.7 0.7 0.7];
end
    

pars.plot.color = [0 0 0];
pars.plot.edge_color = [0 0 0];
pars.plot.fill_color = [0.7 0.7 0.7];
pars.plot.type = 'open';
pars.plot.marker_size = 12;

pars.centroids.colors = pars.plot.all_colors;
pars.centroids.colors_light = pars.plot.all_colors_light;
pars.centroids.plot_points = 1;
pars.centroids.log_flag = 0;
pars.centroids.group_by_x = 0;
pars.centroids.m_type = 'mean';
pars.centroids.eb_type = 'boot';
pars.centroids.ua_flag = 0;
pars.centroids.test = 'anova';
pars.centroids.scale_yax = 2;
pars.centroids.names = {'NH','HL','HA','HL+20dB'};

pars.hist.colors = pars.plot.all_colors;
pars.hist.n_bins = 10;
pars.hist.rng_end = 0.99;
pars.hist.log_flag = 0;
pars.hist.ua_flag = 0;

pars.read.sparse_to_full = 0;
pars.read.keep_only_successive = 0; %0 = ignore, 1 = var-by-var, 2 = across all vars
pars.read.successive_max_diff = 0;
pars.read.keep_only_valid = 1; %0 = ignore, 1 = var-by-var, 2 = across all vars, 3 = match NEX and HA
pars.read.ua_flag = 0;
