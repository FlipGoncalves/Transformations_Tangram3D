function Tlast = manimate(h,P,Tcurr,Tset,ord)
    % Function to animate objects!
    % h: handle
    % P: object in base frame
    % Tcurr: starting position (geometric transformation)
    % Tset: set of geometric transformations to apply
    % ord: vector of 0's and 1's with the order of multiplication

    m = size(Tset,3);

    % didn't provide 'ord'
    if nargin < 5
        % so we give a default value (all global):
        ord = zeros(1,m);
    end

    % if we only say '1' or '0' for the org, assume all the rest are the
    % same as the first (all global or all local)
    ord(end:m) = ord(end);

    for n=1:size(Tset,3)

        if ord(n) == 0              % global
            TT = Tset(:,:,n)*Tcurr;
        else                        % local
            TT = Tcurr*Tset(:,:,n);
        end

        P2 = TT*P;
        h.Vertices = P2(1:3,:)';

        pause(0.05); % pause 50ms

    end

    Tlast = TT;

end