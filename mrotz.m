function T = mrotz(a)
    % mrot = multiple rotations
    % Function to obtain rotation around z-axis!
    % angle in radians
    % a: vector with angles
    % T: hypermatrix with a set of transformation
    
    T = zeros(4,4,length(a));
    
    for n=1:length(a)
        T(:,:,n) = RotZ(a(n));
    end

end