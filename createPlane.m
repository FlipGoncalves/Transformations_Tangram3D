function [Tplane, Pplane, plane] = createPlane(max_view, phi, theta, NN)
    [Pplane, Fplane] = Paralel(2, -100, -100);
    plane = patch( 'Vertices', Pplane(1:3,:)', 'Faces', Fplane, 'FaceColor', '#808080');
    
    grid on; axis equal; hold on;
    xlabel('X'); ylabel('Y'); zlabel('Z');
    axis([-max_view max_view -max_view max_view -max_view max_view]);
    view(120,30);
   
    % Plane
    clear T
    
    order = [1 0 0 0];
    T(:,:,:,1) = mroty(linspace(0,pi/2,NN));
    T(:,:,:,2) = mtrans(0,0,linspace(0,25,NN));
    T(:,:,:,3) = mrotx(linspace(0,theta,NN));
    T(:,:,:,4) = mroty(linspace(0,phi,NN));
    
    Tplane = eye(4,4);
    for n=1:size(T,4)
        Tplane = manimate(plane, Pplane, Tplane, T(:,:,:,n), order(n));
        pause(0.1);
    end
end

