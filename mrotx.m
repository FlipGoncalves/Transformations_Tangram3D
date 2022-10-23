function T = mrotx(a)
    % mrot = multiple rotations
    % Function to obtain rotation around x-axis!
    % angle in radians
    % a: vector with angles
    % T: hypermatrix with a set of transformation
    
    T = zeros(4,4,length(a));
    
    for n=1:length(a)
        T(:,:,n) = RotX(a(n));
    end

end