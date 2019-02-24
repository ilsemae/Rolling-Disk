function EOM_rolling_disk_derive() 

    syms EulerAngs1 EulerAngs2 EulerAngs3 EulerAngsDot1 EulerAngsDot2 EulerAngsDot3 real;
    syms N EulerAngsDotDot1 EulerAngsDotDot2 EulerAngsDotDot3 real;
    syms omega I11 I22 I33 real;
    syms m g r real;
    
    I_B = [I11  0   0 ;
            0  I22  0 ;
            0   0  I33];

    e1 = [1 0 0]'; e2 = [0 1 0]'; e3 = [0 0 1]';
        
    %R1 = getRotMat(e3,EulerAngs1);
    %R2 = getRotMat(e2,EulerAngs2);
    
    R1 = [ cos(EulerAngs1) -sin(EulerAngs1) 0; %rotation about z
           sin(EulerAngs1)  cos(EulerAngs1) 0;
           0 0 1];
       
    R2 = [ cos(EulerAngs2) 0  sin(EulerAngs2); %rotation about y
           0 1 0;
          -sin(EulerAngs2) 0  cos(EulerAngs2)];
       
    R3 = [ 1 0 0;                              %rotation about x
           0  cos(EulerAngs3) -sin(EulerAngs3);
           0  sin(EulerAngs3)  cos(EulerAngs3)];

    R = R1*R2*R3;

    e2_prime  =    R1*e2;
    e1_pprime = R1*R2*e1;
    e3_pprime = R1*R2*e3;
    
    omega_B_F = EulerAngsDot1*e3 + EulerAngsDot2*e2_prime + EulerAngsDot3*e1_pprime;
    omega_T_F = EulerAngsDot1*e3 + EulerAngsDot2*e2_prime;
    
    S_omega_B_F = skew_symmetric(omega_B_F);
    S_omega_T_F = skew_symmetric(omega_T_F);

    e2_prime_dot  = cross(EulerAngsDot1*e3,e2_prime);
    e1_pprime_dot = S_omega_T_F*e1_pprime;
    e3_pprime_dot = S_omega_T_F*e3_pprime;

    alpha = EulerAngsDotDot1*e3 + EulerAngsDotDot2*e2_prime + EulerAngsDot2*e2_prime_dot + EulerAngsDotDot3*e1_pprime + EulerAngsDot3*e1_pprime_dot;
    
    I_F = R*I_B*R';

    r_G_c = r*e3_pprime;
     
    vG     = cross(omega_B_F,r_G_c)
    aG     = cross(alpha,r_G_c) + S_omega_B_F*(r*e3_pprime_dot);
    
    M_c    = cross(r_G_c,-m*g*e3);
    Hdot_c = cross(r_G_c,m*aG) + I_F*alpha + S_omega_B_F*(I_F*omega_B_F);

    EoM =  simple(Hdot_c - M_c);
    M   =  simple(jacobian(EoM, [EulerAngsDotDot1 EulerAngsDotDot2 EulerAngsDotDot3]));
    rhs = -simple(EoM - M*[EulerAngsDotDot1 EulerAngsDotDot2 EulerAngsDotDot3]');  % for use in ODE45 rhs function
    
    rhs_file = fopen('MAE_6700/final_project/rolling_disk_rhs.m','w');
    fprintf(rhs_file,'function qdot = rolling_disk_rhs(tspan,q,flag,p) \n');
    fprintf(rhs_file,' \n');
    %unpacking
    %fprintf(rhs_file,'    rG1         = q(1); rG2         = q(2); rG3         = q(3); \n');
    fprintf(rhs_file,'    EulerAngs1  = q(4); EulerAngs2  = q(5); EulerAngs3  = q(6); \n');
    fprintf(rhs_file,'    rGdot1      = q(7); rGdot2      = q(8); rGdot3      = q(9); \n');
    fprintf(rhs_file,'    EulerAngsDot1 = q(10); EulerAngsDot2 = q(11); EulerAngsDot3 = q(12); \n');
    
    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'    m = p.m; g = p.g; r = p.r; \n');
 
    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'    M = zeros(3,3); \n');
    fprintf(rhs_file,'    I_B = p.I_F0; \n');

    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'    I11 = I_B(1,1); I22 = I_B(2,2); I33 = I_B(3,3); \n');

    fprintf(rhs_file,' \n');
    
    for i = 1:size(M,1)
        for j = 1:size(M,2)
            fprintf(rhs_file,['    M(' num2str(i) ',' num2str(j) ') = ' char(M(i,j)) '; \n']);
        end
    end
    for i = 1:size(rhs,1)
        for j = 1:size(rhs,2)
            fprintf(rhs_file,['    rhs(' num2str(i) ',' num2str(j) ') = ' char(rhs(i,j)) '; \n']);
        end
    end

    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'    EulerAngsDot     = [EulerAngsDot1 EulerAngsDot2 EulerAngsDot3]''; \n');
    fprintf(rhs_file,'    EulerAngsDotDot  = M\\rhs; \n');
    fprintf(rhs_file,'    EulerAngsDotDot1 = EulerAngsDotDot(1); \n');
    fprintf(rhs_file,'    EulerAngsDotDot2 = EulerAngsDotDot(2); \n');
    fprintf(rhs_file,'    EulerAngsDotDot3 = EulerAngsDotDot(3); \n');
    
    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'    rGdot     = [rGdot1 rGdot2 rGdot3]''; \n');
    fprintf(rhs_file,['    rGdotdot1 = ' char(aG(1)) '; \n']);
    fprintf(rhs_file,['    rGdotdot2 = ' char(aG(2)) '; \n']);
    fprintf(rhs_file,['    rGdotdot3 = ' char(aG(3)) '; \n']);
    fprintf(rhs_file,'    rGdotdot  = [ rGdotdot1 rGdotdot2 rGdotdot3 ]''; \n');
    
    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'    qdot = [ rGdot ; EulerAngsDot ; rGdotdot ; EulerAngsDotDot ];\n');
    fprintf(rhs_file,' \n');
    fprintf(rhs_file,'end \n');

end