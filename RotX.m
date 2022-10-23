function M=RotX(alpha)

    % Returns homogenious 3D transformation
    % M - return Matrix
    % alpha - rotation value

    M = [ 1     0           0           0
          0     cos(alpha)  -sin(alpha) 0
          0     sin(alpha)  cos(alpha)  0
          0     0           0           1
        ];

end