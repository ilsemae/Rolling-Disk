function [tarray,qarray] = spinning_in_circles(radius,theta,phidot)

    mass          = 5;
    thickness     = 1;
    tot_time      = 170;
    steps         = 1e3;
    EulerAngs0    = [ 0 theta 0 ];    % [steer  tip  roll]
    tolerance     = 1e-10;
    xyz_plot      = true;
    
    [x_drawer0 , y_drawer0 , z_drawer0, I] = getShape(mass,'disk',[radius thickness]);
            
    psidot = (mass*radius*10*tan(theta) - phidot^2*sin(theta)*(I(1,1)+I(3,3)))/phidot/I(1,1);
    
    EulerAngsDot0 = [ phidot 0 psidot ];
        
    [tarray , qarray ] = disk_sliding_on_ground(mass,[radius thickness],tot_time,steps,[ 0  0 ],[ 0  0  0 ]',EulerAngs0',EulerAngsDot0',false,true,false,tolerance,xyz_plot);

    animate_this(tarray,qarray,x_drawer0,y_drawer0,z_drawer0,steps,radius);

end