function qdot = rolling_disk_rhs(tspan,q,flag,p) 
 
    EulerAngs1  = q(4); EulerAngs2  = q(5); EulerAngs3  = q(6); 
    rGdot1      = q(7); rGdot2      = q(8); rGdot3      = q(9); 
    EulerAngsDot1 = q(10); EulerAngsDot2 = q(11); EulerAngsDot3 = q(12); 
 
    m = p.m; g = p.g; r = p.r; 
 
    M = zeros(3,3); 
    I_B = p.I_F0; 
 
    I11 = I_B(1,1); I22 = I_B(2,2); I33 = I_B(3,3); 
 
    M(1,1) = -cos(EulerAngs2)*(I11*cos(EulerAngs1)*sin(EulerAngs2) - I22*cos(EulerAngs1)*sin(EulerAngs2) + I22*cos(EulerAngs1)*cos(EulerAngs3)^2*sin(EulerAngs2) - I33*cos(EulerAngs1)*cos(EulerAngs3)^2*sin(EulerAngs2) + I22*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) - I33*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) + m*r^2*cos(EulerAngs1)*sin(EulerAngs2)); 
    M(1,2) = I33*cos(EulerAngs3)^2*sin(EulerAngs1) - m*r^2*sin(EulerAngs1) - I22*cos(EulerAngs3)^2*sin(EulerAngs1) - I33*sin(EulerAngs1) + I22*cos(EulerAngs1)*cos(EulerAngs3)*sin(EulerAngs2)*sin(EulerAngs3) - I33*cos(EulerAngs1)*cos(EulerAngs3)*sin(EulerAngs2)*sin(EulerAngs3); 
    M(1,3) = cos(EulerAngs1)*cos(EulerAngs2)*(I11 + m*r^2); 
    M(2,1) = -cos(EulerAngs2)*(I11*sin(EulerAngs1)*sin(EulerAngs2) - I22*sin(EulerAngs1)*sin(EulerAngs2) + m*r^2*sin(EulerAngs1)*sin(EulerAngs2) + I22*cos(EulerAngs3)^2*sin(EulerAngs1)*sin(EulerAngs2) - I33*cos(EulerAngs3)^2*sin(EulerAngs1)*sin(EulerAngs2) - I22*cos(EulerAngs1)*cos(EulerAngs3)*sin(EulerAngs3) + I33*cos(EulerAngs1)*cos(EulerAngs3)*sin(EulerAngs3)); 
    M(2,2) = I33*cos(EulerAngs1) + m*r^2*cos(EulerAngs1) + I22*cos(EulerAngs1)*cos(EulerAngs3)^2 - I33*cos(EulerAngs1)*cos(EulerAngs3)^2 + I22*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs2)*sin(EulerAngs3) - I33*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs2)*sin(EulerAngs3); 
    M(2,3) = cos(EulerAngs2)*sin(EulerAngs1)*(I11 + m*r^2); 
    M(3,1) = I11 + m*r^2 - I11*cos(EulerAngs2)^2 + I22*cos(EulerAngs2)^2 - m*r^2*cos(EulerAngs2)^2 - I22*cos(EulerAngs2)^2*cos(EulerAngs3)^2 + I33*cos(EulerAngs2)^2*cos(EulerAngs3)^2; 
    M(3,2) = (sin(2*EulerAngs3)*cos(EulerAngs2)*(I22 - I33))/2; 
    M(3,3) = -sin(EulerAngs2)*(I11 + m*r^2); 
    rhs(1,1) = EulerAngsDot1*EulerAngsDot2*I22*cos(EulerAngs1) - EulerAngsDot1*EulerAngsDot2*I11*cos(EulerAngs1) + EulerAngsDot1*EulerAngsDot2*I33*cos(EulerAngs1) - g*m*r*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot1^2*I11*cos(EulerAngs2)*sin(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot1^2*I22*cos(EulerAngs2)*sin(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot1*EulerAngsDot3*I11*cos(EulerAngs2)*sin(EulerAngs1) + EulerAngsDot2*EulerAngsDot3*I11*cos(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs2)*sin(EulerAngs1) + EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs2)*sin(EulerAngs1) - EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs1)*sin(EulerAngs2) + 2*EulerAngsDot1*EulerAngsDot2*I11*cos(EulerAngs1)*cos(EulerAngs2)^2 - 2*EulerAngsDot1*EulerAngsDot2*I22*cos(EulerAngs1)*cos(EulerAngs2)^2 + EulerAngsDot1^2*I22*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs3) - EulerAngsDot2^2*I22*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs3) - EulerAngsDot1^2*I33*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs3) + EulerAngsDot2^2*I33*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs3) - 2*EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) + 2*EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) - EulerAngsDot1^2*m*r^2*cos(EulerAngs2)*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot1^2*I22*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot1^2*I33*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot1*EulerAngsDot3*m*r^2*cos(EulerAngs2)*sin(EulerAngs1) + 2*EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs1) - 2*EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs1)*cos(EulerAngs3)^2*sin(EulerAngs2) - 2*EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs1) + 2*EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs1)*cos(EulerAngs3)^2*sin(EulerAngs2) + 2*EulerAngsDot1*EulerAngsDot2*m*r^2*cos(EulerAngs1)*cos(EulerAngs2)^2 + 2*EulerAngsDot1*EulerAngsDot2*I22*cos(EulerAngs1)*cos(EulerAngs2)^2*cos(EulerAngs3)^2 - 2*EulerAngsDot1*EulerAngsDot2*I33*cos(EulerAngs1)*cos(EulerAngs2)^2*cos(EulerAngs3)^2 - 2*EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs2)*sin(EulerAngs3) + 2*EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs2)*sin(EulerAngs3); 
    rhs(2,1) = EulerAngsDot1*EulerAngsDot2*I22*sin(EulerAngs1) - EulerAngsDot1*EulerAngsDot2*I11*sin(EulerAngs1) + EulerAngsDot1*EulerAngsDot2*I33*sin(EulerAngs1) + g*m*r*cos(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot1^2*I11*cos(EulerAngs1)*cos(EulerAngs2)*sin(EulerAngs2) - EulerAngsDot1^2*I22*cos(EulerAngs1)*cos(EulerAngs2)*sin(EulerAngs2) - EulerAngsDot1*EulerAngsDot3*I11*cos(EulerAngs1)*cos(EulerAngs2) + EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs1)*cos(EulerAngs2) - EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs1)*cos(EulerAngs2) + EulerAngsDot2*EulerAngsDot3*I11*sin(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot2*EulerAngsDot3*I22*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot2*EulerAngsDot3*I33*sin(EulerAngs1)*sin(EulerAngs2) + 2*EulerAngsDot1*EulerAngsDot2*I11*cos(EulerAngs2)^2*sin(EulerAngs1) - 2*EulerAngsDot1*EulerAngsDot2*I22*cos(EulerAngs2)^2*sin(EulerAngs1) + EulerAngsDot1^2*I22*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) - EulerAngsDot2^2*I22*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) - EulerAngsDot1^2*I33*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) + EulerAngsDot2^2*I33*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs3) + 2*EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs1)*cos(EulerAngs3)*sin(EulerAngs3) - 2*EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs1)*cos(EulerAngs3)*sin(EulerAngs3) + EulerAngsDot1^2*m*r^2*cos(EulerAngs1)*cos(EulerAngs2)*sin(EulerAngs2) + EulerAngsDot1^2*I22*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs2) - EulerAngsDot1^2*I33*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs2) - EulerAngsDot1*EulerAngsDot3*m*r^2*cos(EulerAngs1)*cos(EulerAngs2) - 2*EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)^2 + 2*EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs1)*cos(EulerAngs2)*cos(EulerAngs3)^2 - 2*EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs3)^2*sin(EulerAngs1)*sin(EulerAngs2) + 2*EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs3)^2*sin(EulerAngs1)*sin(EulerAngs2) + 2*EulerAngsDot1*EulerAngsDot2*m*r^2*cos(EulerAngs2)^2*sin(EulerAngs1) + 2*EulerAngsDot1*EulerAngsDot2*I22*cos(EulerAngs2)^2*cos(EulerAngs3)^2*sin(EulerAngs1) - 2*EulerAngsDot1*EulerAngsDot2*I33*cos(EulerAngs2)^2*cos(EulerAngs3)^2*sin(EulerAngs1) - 2*EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs2)*sin(EulerAngs3) + 2*EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs2)*cos(EulerAngs3)*sin(EulerAngs1)*sin(EulerAngs2)*sin(EulerAngs3); 
    rhs(3,1) = EulerAngsDot1*EulerAngsDot2*I22*sin(2*EulerAngs2) - EulerAngsDot1*EulerAngsDot2*I11*sin(2*EulerAngs2) + EulerAngsDot2*EulerAngsDot3*I11*cos(EulerAngs2) + EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs2) - EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs2) - EulerAngsDot1*EulerAngsDot2*m*r^2*sin(2*EulerAngs2) + EulerAngsDot2^2*I22*cos(EulerAngs3)*sin(EulerAngs2)*sin(EulerAngs3) - EulerAngsDot2^2*I33*cos(EulerAngs3)*sin(EulerAngs2)*sin(EulerAngs3) - 2*EulerAngsDot2*EulerAngsDot3*I22*cos(EulerAngs2)*cos(EulerAngs3)^2 + 2*EulerAngsDot2*EulerAngsDot3*I33*cos(EulerAngs2)*cos(EulerAngs3)^2 - 2*EulerAngsDot1*EulerAngsDot2*I22*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs2) - 2*EulerAngsDot1*EulerAngsDot3*I22*cos(EulerAngs2)^2*cos(EulerAngs3)*sin(EulerAngs3) + 2*EulerAngsDot1*EulerAngsDot2*I33*cos(EulerAngs2)*cos(EulerAngs3)^2*sin(EulerAngs2) + 2*EulerAngsDot1*EulerAngsDot3*I33*cos(EulerAngs2)^2*cos(EulerAngs3)*sin(EulerAngs3); 
 
    EulerAngsDot     = [EulerAngsDot1 EulerAngsDot2 EulerAngsDot3]'; 
    EulerAngsDotDot  = M\rhs; 
    EulerAngsDotDot1 = EulerAngsDotDot(1); 
    EulerAngsDotDot2 = EulerAngsDotDot(2); 
    EulerAngsDotDot3 = EulerAngsDotDot(3); 
 
    rGdot     = [rGdot1 rGdot2 rGdot3]'; 
    rGdotdot1 = r*sin(EulerAngs1)*sin(EulerAngs2)*(EulerAngsDotDot3*sin(EulerAngs2) - EulerAngsDotDot1 + EulerAngsDot3*(EulerAngsDot2*cos(EulerAngs1)^2*cos(EulerAngs2) + EulerAngsDot2*cos(EulerAngs2)*sin(EulerAngs1)^2)) - r*(EulerAngsDot2*cos(EulerAngs1)^2*sin(EulerAngs2) + EulerAngsDot2*sin(EulerAngs1)^2*sin(EulerAngs2))*(EulerAngsDot2*cos(EulerAngs1) + EulerAngsDot3*cos(EulerAngs2)*sin(EulerAngs1)) - r*cos(EulerAngs2)*(EulerAngsDot3*(EulerAngsDot2*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot1*cos(EulerAngs1)*cos(EulerAngs2)) - EulerAngsDotDot2*cos(EulerAngs1) - EulerAngsDotDot3*cos(EulerAngs2)*sin(EulerAngs1) + EulerAngsDot1*EulerAngsDot2*sin(EulerAngs1)) - r*(EulerAngsDot1 - EulerAngsDot3*sin(EulerAngs2))*(EulerAngsDot1*cos(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot2*cos(EulerAngs2)*sin(EulerAngs1)); 
    rGdotdot2 = r*cos(EulerAngs2)*(EulerAngsDot3*(EulerAngsDot1*cos(EulerAngs2)*sin(EulerAngs1) + EulerAngsDot2*cos(EulerAngs1)*sin(EulerAngs2)) + EulerAngsDotDot2*sin(EulerAngs1) + EulerAngsDot1*EulerAngsDot2*cos(EulerAngs1) - EulerAngsDotDot3*cos(EulerAngs1)*cos(EulerAngs2)) - r*(EulerAngsDot2*cos(EulerAngs1)^2*sin(EulerAngs2) + EulerAngsDot2*sin(EulerAngs1)^2*sin(EulerAngs2))*(EulerAngsDot2*sin(EulerAngs1) - EulerAngsDot3*cos(EulerAngs1)*cos(EulerAngs2)) - r*(EulerAngsDot1 - EulerAngsDot3*sin(EulerAngs2))*(EulerAngsDot1*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot2*cos(EulerAngs1)*cos(EulerAngs2)) - r*cos(EulerAngs1)*sin(EulerAngs2)*(EulerAngsDotDot3*sin(EulerAngs2) - EulerAngsDotDot1 + EulerAngsDot3*(EulerAngsDot2*cos(EulerAngs1)^2*cos(EulerAngs2) + EulerAngsDot2*cos(EulerAngs2)*sin(EulerAngs1)^2)); 
    rGdotdot3 = r*(EulerAngsDot1*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot2*cos(EulerAngs1)*cos(EulerAngs2))*(EulerAngsDot2*cos(EulerAngs1) + EulerAngsDot3*cos(EulerAngs2)*sin(EulerAngs1)) - r*(EulerAngsDot1*cos(EulerAngs1)*sin(EulerAngs2) + EulerAngsDot2*cos(EulerAngs2)*sin(EulerAngs1))*(EulerAngsDot2*sin(EulerAngs1) - EulerAngsDot3*cos(EulerAngs1)*cos(EulerAngs2)) - r*sin(EulerAngs1)*sin(EulerAngs2)*(EulerAngsDot3*(EulerAngsDot1*cos(EulerAngs2)*sin(EulerAngs1) + EulerAngsDot2*cos(EulerAngs1)*sin(EulerAngs2)) + EulerAngsDotDot2*sin(EulerAngs1) + EulerAngsDot1*EulerAngsDot2*cos(EulerAngs1) - EulerAngsDotDot3*cos(EulerAngs1)*cos(EulerAngs2)) + r*cos(EulerAngs1)*sin(EulerAngs2)*(EulerAngsDot3*(EulerAngsDot2*sin(EulerAngs1)*sin(EulerAngs2) - EulerAngsDot1*cos(EulerAngs1)*cos(EulerAngs2)) - EulerAngsDotDot2*cos(EulerAngs1) - EulerAngsDotDot3*cos(EulerAngs2)*sin(EulerAngs1) + EulerAngsDot1*EulerAngsDot2*sin(EulerAngs1)); 
    rGdotdot  = [ rGdotdot1 rGdotdot2 rGdotdot3 ]'; 
 
    qdot = [ rGdot ; EulerAngsDot ; rGdotdot ; EulerAngsDotDot ];
 
end 
