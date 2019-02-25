mass          = 5;
radius        = 60;
thickness     = .1;
switch_expression = 'tri_pretty_2'; % flower, tri_pretty, wobble_roll, or tri_pretty_2

switch switch_expression
    case 'flower'
        num_disks     = 1;
        tot_time      = 30;
        steps         = 2e2;
        xy0           = [ -50 -100 ];   % z0 calculated via initial tip angle
        vxy0_sliding  = [ -10 -10 ];
        EulerAngs0    = [ 0 .1 0 ];     % [steer  tip  roll]
        EulerAngsDot0 = [ .5 .5 .1 ];
    case 'tri_pretty'
        num_disks     = 1;
        tot_time      = 3;
        steps         = 2e2;
        xy0           = [ 0 0 ];        % z0 calculated via initial tip angle
        vxy0_sliding  = [ -10 -10 ];
        EulerAngs0    = [ 0 .5 0 ];     % [steer  tip  roll]
        EulerAngsDot0 = [ 5 .5 .1 ]; 
    case 'wobble_roll'
        num_disks     = 1;
        tot_time      = 5;
        steps         = 1.3e2;
        xy0           = [ -350 350 ];   % z0 calculated via initial tip angle
        vxy0_sliding  = [ -10 -10 ];
        EulerAngs0    = [ pi/4 .3 0 ];  % [steer  tip  roll]
        EulerAngsDot0 = [ 2  1 4 ];
    case 'tri_pretty_2'
        num_disks     = 2;
        tot_time      = 3;
        steps         = 2e2;
        xy0           = [ -100  100 ];        % z0 calculated via initial tip angle
        xy02          = [  100 -100 ];
        vxy0_sliding  = [ -10 -10 ];
        EulerAngs0    = [ 0 .5 0 ];     % [steer  tip  roll]
        EulerAngsDot0 = [ 5 .5 .1 ]; 
end

animate       = false;          % animate disk
eng_consv     = false;          % show energy plot
reload_derive = false;          % reload the derivation
tolerance     = 1e-10;
xyz_plot      = false;

[x_draw , y_draw , z_draw, I] = getShape(mass,'disk',[radius thickness]);
if num_disks == 1 
    [ t , q ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
    animate_this(t,q,x_draw,y_draw,z_draw,steps,radius);
elseif num_disks == 2 
    [ t , q ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
    [t2 , q2] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy02,EulerAngs0',EulerAngsDot0',animate,eng_consv,reload_derive,tolerance,xyz_plot);
    animate_this2(t,q,t2,q2,x_draw,y_draw,z_draw,steps,radius);
end
