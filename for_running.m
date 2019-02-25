mass          = 5;
radius        = 60;
thickness     = .1;
tot_time      = 30;
steps         = 5e2;
xy0           = [ -1100 1100 ]; % z0 calculated via initial tip angle
vxy0_sliding  = [ -10 -10 ];
EulerAngs0    = [  pi/4 pi/6  0 ]; % initial angular position [steer  tip  roll]
EulerAngsDot0 = [ 2  0  5 ];    % initial angular velocity [steer  tip  roll]
animate       = false;          % always false(need to remove it) moved this to a separate function animate_this
eng_consv     = false;          % show energy plot
reload_derive = false;          % reload the derivation
tolerance     = 1e-10;
xyz_plot      = false;

% get trajectories
[ t , q ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
% [ t2 , q2 ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,-xy0,-EulerAngs0',-EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
% [ t , q ] = disk_sliding_on_ground(mass,[radius thickness],tot_time,steps,xy0,[vxy0_sliding 0]',EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);

[x_draw , y_draw , z_draw, I] = getShape(mass,'disk',[radius thickness]);
animate_this(t,q,x_draw,y_draw,z_draw,steps,radius);
% animate_this2(t,q,t2,q2,x_draw,y_draw,z_draw,steps,radius);
