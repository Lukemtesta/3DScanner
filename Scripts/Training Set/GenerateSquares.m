
%% Creates 1000 square images for training set

mkdir('Test Images')
cd('Test Images')

p = [0.5 0.5 -0.5 -0.5 0.5; 0.5 -0.5 -0.5 0.5 0.5;];
i = -1;

Sy = 1; Rz = 0;
for Sx=0.1:0.1:1
            R = [cos(Rz) -sin(Rz); sin(Rz) cos(Rz)];
            S = [Sx 0; 0 Sy];
            
            q = S*R*p;
            
            figure(1)
            fill(q(1,:),q(2,:),'b')
            axis([-1 1 -1 1])
            axis off
          
            i = i + 1;
            drawnow;
            pause(0.5)
            saveas(figure(1), ['Square ' num2str(i)], 'png')
            close all          
end

Sx = 1; Rz = 0;
for Sy=0.1:0.1:1
            R = [cos(Rz) -sin(Rz); sin(Rz) cos(Rz)];
            S = [Sx 0; 0 Sy];
            
            q = S*R*p;
            
            figure(1)
            fill(q(1,:),q(2,:), 'b')
            axis([-1 1 -1 1])
            axis off
          
            i = i + 1;
            drawnow;
            pause(0.5)
            saveas(figure(1), ['Square ' num2str(i)], 'png')
            close all          
end

Sx = 1; Sy = 1;
for Rz=0:(pi/20):(pi/2)
            R = [cos(Rz) -sin(Rz); sin(Rz) cos(Rz)];
            S = [Sx 0; 0 Sy];
            
            q = S*R*p;
            
            figure(1)
            fill(q(1,:),q(2,:),'b')
            axis([-1 1 -1 1])
            axis off
          
            i = i + 1;
            drawnow;
            pause(0.5)
            saveas(figure(1), ['Square ' num2str(i)], 'png')
            close all          
end
    
cd ..