% to animate two disks at once
function animate_this2(tarray,qarray,tarray2,qarray2,x_drawer0,y_drawer0,z_drawer0,steps,r)

        e1 = [1 0 0]';
        e2 = [0 1 0]';
        e3 = [0 0 1]';

        figure(1);
        set(gcf,'color','white');
        F = [];
        contact_positions = [qarray(:,1) , qarray(:,2)] + r*[-sin(qarray(:,5)).*cos(qarray(:,4)) , -sin(qarray(:,5)).*sin(qarray(:,4))];
        contact_positions2 = [qarray2(:,1) , qarray2(:,2)] + r*[-sin(qarray2(:,5)).*cos(qarray2(:,4)) , -sin(qarray2(:,5)).*sin(qarray2(:,4))];
        
        for i=1:steps

            rG_t_r           = qarray(i,1:3)';
            EulerAngs_t_r    = qarray(i,4:6)';

            rG_t_s           = qarray2(i,1:3)';
            EulerAngs_t_s    = qarray2(i,4:6)';

            R1_r = getRotMat(e3,EulerAngs_t_r(1));
            R2_r = getRotMat(e2,EulerAngs_t_r(2));
            R3_r = getRotMat(e1,EulerAngs_t_r(3));

            R1_s = getRotMat(e3,EulerAngs_t_s(1));
            R2_s = getRotMat(e2,EulerAngs_t_s(2));
            R3_s = getRotMat(e1,EulerAngs_t_s(3));

            R_t_r = R1_r*R2_r*R3_r;
            R_t_s = R1_s*R2_s*R3_s;

            hold off;
            draw_r = R_t_r*[x_drawer0                         ; y_drawer0                         ; z_drawer0] ...
                     + [rG_t_r(1)*ones(1,size(x_drawer0,2)) ; rG_t_r(2)*ones(1,size(x_drawer0,2)) ; rG_t_r(3)*ones(1,size(x_drawer0,2))];
            draw_s = R_t_s*[x_drawer0                         ; y_drawer0                         ; z_drawer0] ...
                     + [rG_t_s(1)*ones(1,size(x_drawer0,2)) ; rG_t_s(2)*ones(1,size(x_drawer0,2)) ; rG_t_s(3)*ones(1,size(x_drawer0,2))];

            s = 400;
            fill3([-s s s -s],[-s -s s s],[0 0 0 0],'white');
            hold on;
            plot3(draw_r(1,:),draw_r(2,:),draw_r(3,:),'black'); % plot moved disk
            fill3(draw_r(1,3:102),draw_r(2,3:102),zeros(1,100),'black','FaceAlpha', 0.5); % plot shadow (light straight above)          
            fill3(draw_r(1,3:102),draw_r(2,3:102),draw_r(3,3:102),'yellow');
            fill3(draw_r(1,104:203),draw_r(2,104:203),draw_r(3,104:203),'green');
            plot3(contact_positions(1:i,1),contact_positions(1:i,2),zeros(i,1));
            
            plot3(draw_s(1,:),draw_s(2,:),draw_s(3,:),'black'); % plot moved disk
            fill3(draw_s(1,3:102),draw_s(2,3:102),zeros(1,100),'black','FaceAlpha', 0.5); % plot shadow (light straight above)          
            fill3(draw_s(1,3:102),draw_s(2,3:102),draw_s(3,3:102),'c');
            fill3(draw_s(1,104:203),draw_s(2,104:203),draw_s(3,104:203),'m');
            plot3(contact_positions2(1:i,1),contact_positions2(1:i,2),zeros(i,1));
            axis equal; grid on; axis([-s s -s s 0 s/2]);
            xlabel('e1'); ylabel('e2'); zlabel('e3');
            shg;
            
            F = [F getframe(1)];

        end
        
        v = VideoWriter('disk_animation.avi','Motion JPEG AVI');
        v.FrameRate = 40;
        open(v);
        writeVideo(v,F);

end