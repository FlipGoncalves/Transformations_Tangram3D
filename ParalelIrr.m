function [P,F]=ParalelIrr(scale, x, y)

    if nargin < 1
        scale=1;
    end

    lp = sqrt(50)/2;
    x1 = sqrt(50);
    
    P = scale*[ x y 0
                x+lp y 0
                x+x1 y+lp 0
                x+lp y+lp 0
                x y 1
                x+lp y 1
                x+x1 y+lp 1
                x+lp y+lp 1]';
    
    F = [   1 2 3 4
            5 6 7 8
            1 2 6 5
            3 4 8 7
            1 4 8 5
            2 3 7 6];

   
    P = [P; ones(1,size(P,2))];


end

