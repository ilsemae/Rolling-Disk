
%calculated in the body frame
function energyCheckDisk(t,q,p)

    % fixed frame basis vectors
    e1 = [1 0 0]';
    e2 = [0 1 0]';
    e3 = [0 0 1]';

    rG_t           = q(:,1:3);
    EulerAngs_t    = q(:,4:6);
    vG_t           = q(:,7:9);
    EulerAngsDot_t = q(:,10:12);
    steps = size(q,1);

    R10 = getRotMat(e3,EulerAngs_t(1,1));
    R20 = getRotMat(e2,EulerAngs_t(1,2));
    R30 = getRotMat(e1,EulerAngs_t(1,3));
    R0 = R10*R20*R30;
    
    e0_3        =         e3;
    e0_2_prime  =     R10*e2;
    e0_1_pprime = R10*R20*e1;
    e0_3_pprime = R10*R20*e3;
    A0 = [e0_3 , e0_2_prime , e0_1_pprime];

    omega0_F = A0*EulerAngsDot_t(1,:)';    
    omega_B0 = R0'*omega0_F;
    
    hG0 = p.r * dot(e3,e0_3_pprime);
    pe0 = p.m*p.g*hG0;
    ke0 = [1 1 1]*(1/2 * p.I_F0 * omega_B0.^2) + 1/2 * p.m * (vG_t(1,:)*vG_t(1,:)');
    
    pe  = zeros(1,steps);
    ke  = zeros(1,steps);
    
    for i=1:steps
        
        R1 = getRotMat(e3,EulerAngs_t(i,1));
        R2 = getRotMat(e2,EulerAngs_t(i,2));
        R3 = getRotMat(e1,EulerAngs_t(i,3));
        R = R1*R2*R3;
        
        e_3        =       e3;
        e_2_prime  =    R1*e2;
        e_1_pprime = R1*R2*e1;
        e_3_pprime = R1*R2*e3;
        A = [e_3 , e_2_prime , e_1_pprime];
        
        omega_F = A*EulerAngsDot_t(i,:)';    
        omega_B = R'*omega_F;
        
        hG = p.r * dot(e3,e_3_pprime);
        pe(i) = p.m*p.g*hG;
        ke(i) = [1 1 1]*(1/2 * p.I_F0 * omega_B.^2) + 1/2 * p.m * (vG_t(i,:)*vG_t(i,:)');
       
    end
    
    figure;
    plot(t,pe+ke-pe0*ones(1,steps)-ke0*ones(1,steps));
    title('Total Energy Minus Total Initial Energy Over Time');
    xlabel('Time');
    ylabel('Energy Difference');
    shg;

end
