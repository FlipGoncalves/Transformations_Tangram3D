function M=Trans(x, y, z)

    % Returns homogenious 3D transformation
    % M - return Matrix
    % x, y, z - translation values

    M = [ 1   0   0   x
          0   1   0   y
          0   0   1   z
          0   0   0   1
        ];

end