function [xy0 EulerAngs0 EulerAngsDot0] = rolling_in_circles_v2(R,radius,theta, mass, thickness)

    comR          = R-radius*sin(theta);
%     mass          = 5;
    g             = 10;
%     thickness     = .1;
%     tot_time      = 100;
%     steps         = 2e2;
    xy0           = [ -comR , 0  ];
    EulerAngs0    = [ 0 theta 0 ];    % [steer  tip  roll]
%     tolerance     = 1e-13;
%     xyz_plot      = false;

    [x_drawer0 , y_drawer0 , z_drawer0, I] = getShape(mass,'disk',[radius thickness]);

    psidot_sqrd = comR^2*mass*g*tan(theta)/(radius^2*comR*mass+I(1,1)*comR +radius*sin(theta)*I(3,3)-radius^3*mass*sin(theta)+radius*sin(theta)*I(1,1));
    psidot = psidot_sqrd^.5;
    phidot = psidot*radius/comR;
    
    EulerAngsDot0  = [ phidot  0 psidot  ];
    
%     [tarray  , qarray ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',EulerAngsDot0',false,true,false,tolerance,xyz_plot);
    
end