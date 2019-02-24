mass          = 5;
radius        = 60;
thickness     = .1;
tot_time      = 30;
steps         = 2e2;
xy0           = [ 0 0 ];        % z0 calculated via initial tip angle
vxy0_sliding  = [ -10 -10 ];
EulerAngs0    = [ 0   .2   0 ];     % [steer  tip  roll]
EulerAngsDot0 = [ .2 0  2 ];
animate       = false;          % animate disk
eng_consv     = false;          % show energy plot
reload_derive = false;          % reload the derivation
tolerance     = 1e-10;
xyz_plot      = false;

[ t , q ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
%[t2 , q2] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',[1 -.1 -1]',animate,eng_consv,reload_derive,tolerance,xyz_plot);

%[ t , q ] = disk_sliding_on_ground(mass,[radius thickness],tot_time,steps,xy0,[vxy0_sliding 0]',EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
%[t2 , q2] = disk_sliding_on_ground(mass,[radius thickness],tot_time,steps,xy0+[150 0],[vxy0_sliding 0]',EulerAngs0',[0 0 2]',animate,eng_consv,reload_derive,tolerance,xyz_plot);

[x_draw , y_draw , z_draw, I] = getShape(mass,'disk',[radius thickness]);
animate_this(t,q,x_draw,y_draw,z_draw,steps,radius);
%animate_this2(t,q,t2,q2,x_draw,y_draw,z_draw,steps,radius);
