% Euler angles represent rotations about e3, e2', e1''
% omega0 and omega are the angular velocities in the fixed frame.
% B frame basis vectors:
% e1' = rolling axis "n_hat"
% e2' = tipping axis "e_t_hat"
% e3' = steerin axis "lambda_hat"

function [tarray , qarray] = disk_rolling_on_ground(m,dimensions,tot_time,steps,xy0,EulerAngs0,EulerAngsDot0,animate,eng_consv,reload_derive,tolerance,xyz_plot)

    p.m = m;
    p.g = 10;
    p.r = dimensions(1);

    % fixed frame basis vectors
    e1 = [1 0 0]';
    e2 = [0 1 0]';
    e3 = [0 0 1]';
    
    R1 = getRotMat(e3,EulerAngs0(1));
    R2 = getRotMat(e2,EulerAngs0(2));
    
    % angular velocity vector
    e2_prime  = R1*e2;
    e1_pprime = R1*R2*e1;
    omega     = EulerAngsDot0(1)*e3 + EulerAngsDot0(2)*e2_prime + EulerAngsDot0(3)*e1_pprime;
    
    % calculate initial velocity and height of COM using initial Euler angs
    e3_pprime = R1*R2*e3;
    z0        = p.r * e3'*e3_pprime;
    rGc0      = p.r*e3_pprime;
    rG0       = [ xy0 z0 ]';
    vG0       = cross(omega,rGc0) + [0 0 0]';
    
    q0 = [ rG0 ; EulerAngs0 ; vG0 ; EulerAngsDot0 ];
    
    if reload_derive, EOM_rolling_disk_derive; end
    
    [x_drawer0 , y_drawer0 ,z_drawer0, p.I_F0] = getShape(m,'disk',dimensions);

    tspan = linspace(0,tot_time,steps);
    options = odeset('reltol',tolerance,'abstol',tolerance);
    
    [tarray , qarray] = ode45('rolling_disk_rhs',tspan,q0,options,p);

    if eng_consv, energyCheckDisk(tarray,qarray,p); end
        
    if animate, animate_this(tarray,qarray,x_drawer0,y_drawer0,z_drawer0,steps);  end

    if xyz_plot
        figure;
        plot(tarray,qarray(:,1:3));
        title('X, Y, and Z Positions of COM Over Time');
        xlabel('Time');
        ylabel('Position');
        legend('X','Y','Z');
        figure;
        plot(tarray,qarray(:,4:6));
        title('Angles Over Time');
        xlabel('Time');
        ylabel('Angle');
        legend('phi','theta','psi');
    end
    
end

