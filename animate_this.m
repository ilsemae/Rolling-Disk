function animate_this(tarray,qarray,x_drawer0,y_drawer0,z_drawer0,steps,r)

        e1 = [1 0 0]';
        e2 = [0 1 0]';
        e3 = [0 0 1]';

        figure(1);
        set(gcf,'color','white');
        F = [];
        contact_positions = [qarray(:,1) , qarray(:,2)] + r*[-sin(qarray(:,5)).*cos(qarray(:,4)) , -sin(qarray(:,5)).*sin(qarray(:,4))];

        for i=1:steps

            rG_t           = qarray(i,1:3)';
            EulerAngs_t    = qarray(i,4:6)';
            
            R1 = getRotMat(e3,EulerAngs_t(1));
            R2 = getRotMat(e2,EulerAngs_t(2));
            R3 = getRotMat(e1,EulerAngs_t(3));

            R_t = R1*R2*R3;

            hold off;
            draw = R_t*[x_drawer0                         ; y_drawer0                         ; z_drawer0] ...
                     + [rG_t(1)*ones(1,size(x_drawer0,2)) ; rG_t(2)*ones(1,size(x_drawer0,2)) ; rG_t(3)*ones(1,size(x_drawer0,2))];

            s = 1200;
            fill3([-s s s -s],[-s -s s s],[0 0 0 0],'white');
            hold on;
            plot3(draw(1,:),draw(2,:),draw(3,:),'black'); % plot moved disk
            fill3(draw(1,3:102),draw(2,3:102),zeros(1,100),'black','FaceAlpha', 0.5); % plot shadow (light straight above)          
            fill3(draw(1,3:102),draw(2,3:102),draw(3,3:102),'green');
            fill3(draw(1,104:203),draw(2,104:203),draw(3,104:203),'yellow');
            
            plot3(contact_positions(1:i,1),contact_positions(1:i,2),zeros(i,1));
            %plot3(qarray(:,1),qarray(:,2),zeros(steps,1),'r');

            axis equal; grid on; axis([-s s -s s 0 s/6]);
            xlabel('e1'); ylabel('e2'); zlabel('e3');
            shg;
            
            F = [F getframe(1)];
        end
        v = VideoWriter('disk_animation.avi','Motion JPEG AVI');
        v.FrameRate = 40;
        open(v);
        writeVideo(v,F);
        
        
end