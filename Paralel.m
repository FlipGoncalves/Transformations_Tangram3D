function [P,F]=Paralel(scale, x, y)

    if scale == 1
        l = sqrt(50)/2;
        h = 1;
    elseif scale == 2
        l = 2*abs(x);
        h = -1;
    end
    
    P = [ x y 0
            x y+l 0
            x+l y+l 0
            x+l y 0
            x y h
            x y+l h
            x+l y+l h
            x+l y h
                ]';

   F = [1 2 3 4
       5 6 7 8
       1 2 6 5
       3 4 8 7
       1 4 8 5
       2 3 7 6];

   P = [P; ones(1,size(P,2))];
   

end