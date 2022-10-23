function M=RotY(alpha)

    % Returns homogenious 3D transformation
    % M - return Matrix
    % alpha - rotation value

    M = [ cos(alpha)    0  sin(alpha)  0
          0             1  0           0  
          -sin(alpha)   0  cos(alpha)  0
          0             0  0           1
        ];

end