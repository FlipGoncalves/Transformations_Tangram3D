function TT = mtrans(x,y,z)
    % Function to obtain multiple translation matrices!
    % x, y and z are vectors

    m = max([length(x) length(y) length(z)]);
    x(end:m) = x(end);
    y(end:m) = y(end);
    z(end:m) = z(end);

    TT = zeros(4,4,m);
    for n=1:m
        TT(:,:,n) = Trans(x(n),y(n),z(n));
    end

end