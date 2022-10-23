function T = mroty(a)
    % mrot = multiple rotations
    % Function to obtain rotation around y-axis!
    % angle in radians
    % a: vector with angles
    % T: hypermatrix with a set of transformation
    
    T = zeros(4,4,length(a));
    
    for n=1:length(a)
        T(:,:,n) = RotY(a(n));
    end

end