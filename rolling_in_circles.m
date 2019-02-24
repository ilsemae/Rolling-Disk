function [tarray,qarray] = rolling_in_circles(R,radius,theta,R2,radius2,theta2)

    mass          = 5;
    thickness     = .1;
    tot_time      = 100;
    steps         = 2e2;
    xy0           = [ -R-radius*sin(theta)   ,   0  ];
    xy02          = [ -R2-radius2*sin(theta2),   0  ];
    EulerAngs0    = [ 0 -theta 0 ];    % [steer  tip  roll]
    tolerance     = 1e-13;
    xyz_plot      = false;

    [x_drawer0 , y_drawer0 , z_drawer0, I] = getShape(mass,'disk',[radius thickness]);

    psidot_sqrd = R^2*mass*10*tan(theta)/(-radius^2*R*mass -I(1,1)*R+radius*sin(theta)*I(3,3)-radius^3*mass*sin(theta)+radius*sin(theta)*I(1,1));
    psidot = psidot_sqrd^.5;
    phidot = psidot*radius/R;
    
    psidot_sqrd2 = R2^2*mass*10*tan(theta2)/(-radius2^2*R2*mass -I(1,1)*R2+radius2*sin(theta2)*I(3,3)-radius2^3*mass*sin(theta2)+radius2*sin(theta2)*I(1,1));
    psidot2 = psidot_sqrd2^.5;
    phidot2 = psidot2*radius2/R2;

    EulerAngsDot0  = [ phidot  0 psidot  ];
    EulerAngsDot20 = [ phidot2 0 psidot2 ];
    
    [tarray  , qarray ] = disk_rolling_on_ground(mass,[radius thickness],tot_time,steps,xy0,EulerAngs0',EulerAngsDot0',false,true,false,tolerance,xyz_plot);
    [tarray2  , qarray2 ] = disk_rolling_on_ground(mass,[radius2 thickness],tot_time,steps,xy02,EulerAngs0',EulerAngsDot20',false,false,false,tolerance,xyz_plot);
    %[tarray2 , qarray2] = disk_sliding_on_ground(mass,[radius thickness],tot_time,steps,xy02,[ 0  0  0 ]',EulerAngs0',EulerAngsDot0',false,false,false,tolerance,xyz_plot);
    animate_this(tarray,qarray,x_drawer0,y_drawer0,z_drawer0,steps,radius);
    %animate_this2(tarray,qarray,tarray2,qarray2,x_drawer0,y_drawer0,z_drawer0,steps,radius);
    
end