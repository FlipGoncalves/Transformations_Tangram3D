function [P,F]=Prisma(scale, x, y)

    if nargin < 1
        scale=1;
    end

    if scale == 1
        % small
        l = sqrt(25/2);
    elseif scale == 2
        % medium
        l = 5;
    elseif scale == 3
        % big
        l = sqrt(50);
    end


    
    P = [ x y 0
        x y+l 0
        x+l y 0
        x y 1
        x y+l 1
        x+l y 1
        ]';

   F = [1 2 3 3
       4 5 6 6
       1 2 5 4
       1 3 6 4
       2 3 6 5];
   
    P = [P; ones(1,size(P,2))];
    
end