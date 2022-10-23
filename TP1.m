function TP1(theta, phi)

close all

%% start confs
max_view = 30;
circle = linspace(-pi, pi-1, 7);
raio = 10;
NN = 20;

% 0 -> global , 1 -> self => in order

circ = [raio*cos(circle(1)) raio*sin(circle(1))
        raio*cos(circle(2)) raio*sin(circle(2))
        raio*cos(circle(3)) raio*sin(circle(3))
        raio*cos(circle(4)) raio*sin(circle(4))
        raio*cos(circle(5)) raio*sin(circle(5))
        raio*cos(circle(6)) raio*sin(circle(6))
        raio*cos(circle(7)) raio*sin(circle(7))];


%% Criacao das figuras
% paralelopipedo
[Pp, Fp] = Paralel(1, circ(1,1), circ(1,2));
p=patch('Vertices', Pp(1:3,:)', 'Faces', Fp, 'FaceColor', 'y');

grid on; axis equal; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
axis([-max_view max_view -max_view max_view -max_view max_view]);
view(120,30);

% prisma triangular 1 - small
[Pt1, Ft1] = Prisma(1, circ(2,1), circ(2,2));
t1=patch('Vertices', Pt1(1:3,:)', 'Faces', Ft1, 'FaceColor', 'r');

% prisma triangular 2 - small
[Pt2, Ft2] = Prisma(1, circ(3,1), circ(3,2));
t2=patch('Vertices', Pt2(1:3,:)', 'Faces', Ft2, 'FaceColor', 'b');

% prisma triangular 3 - big
[Ptb1, Ftb1] = Prisma(3, circ(4,1), circ(4,2));
tb1=patch('Vertices', Ptb1(1:3,:)', 'Faces', Ftb1, 'FaceColor', 'm');

% prisma triangular 4 - big
[Ptb2, Ftb2] = Prisma(3, circ(5,1), circ(5,2));
tb2=patch('Vertices', Ptb2(1:3,:)', 'Faces', Ftb2, 'FaceColor', '#A020F0');

% prisma triangular 5 - medium
[Ptm1, Ftm1] = Prisma(2, circ(6,1), circ(6,2));
tm1=patch('Vertices', Ptm1(1:3,:)', 'Faces', Ftm1, 'FaceColor', 'c');

% paralelograma irregular
[Ppir, Fpir] = ParalelIrr(1, circ(7,1), circ(7,2));
pir=patch('Vertices', Ppir(1:3,:)', 'Faces', Fpir, 'FaceColor', 'g');


pause()


% create Plane
[Pplane, Fplane] = Paralel(2, -100, -100);
plane = patch( 'Vertices', Pplane(1:3,:)', 'Faces', Fplane, 'FaceColor', '#808080');

% Plane
clear T

order = [1 0];
T(:,:,:,1) = mroty(linspace(0,pi/2,NN));
T(:,:,:,2) = mtrans(0,0,linspace(0,25,NN));

Tplane = eye(4,4);
for n=1:size(T,4)
    Tplane = manimate(plane, Pplane, Tplane, T(:,:,:,n), order(n));
end


pause(1);

%% Initial Position in plane

TcurrPp = eye(4,4);
TcurrPt1 = eye(4,4);
TcurrPt2 = eye(4,4);
TcurrPtb1 = eye(4,4);
TcurrPtb2 = eye(4,4);
TcurrPpir = eye(4,4);
TcurrPtm1 = eye(4,4);

% rotate with plane
clear T
order = [0 0 1 1];

t = [linspace(0,theta,NN)
    linspace(0,phi,NN)
    linspace(0,pi/2,NN)
    linspace(0, -2, NN)];

T(:,:,:,1) = mrotx(0);
T(:,:,:,2) = mroty(0);
T(:,:,:,3) = mroty(0);
T(:,:,:,4) = mtrans(0, 0, 0);
for n=1:size(t,1)+2
    if n > size(t,1)
        clear T
        order = [0 0];
        T(:,:,:,1) = mrotx(linspace(0,theta,NN));
        T(:,:,:,2) = mroty(linspace(0,phi,NN));
        Tplane = manimate(plane, Pplane, Tplane, T(:,:,:,n-size(t,1)), order(n-size(t,1)));
    else
        for k=1:NN-1
    
            if n == 1
                T(:,:,:,1) = mrotx(t(n,2));
            elseif n == 2
                T(:,:,:,2) = mroty(t(n,2));
            elseif n == 3
                T(:,:,:,3) = mroty(t(n,2));
            elseif n == 4
                T(:,:,:,4) = mtrans(0, 0, t(n,2));
            end
    
            TcurrPp = manimate(p, Pp, TcurrPp, T(:,:,:,n), order(n));
            TcurrPt1 = manimate(t1, Pt1, TcurrPt1, T(:,:,:,n), order(n));
            TcurrPt2 = manimate(t2, Pt2, TcurrPt2, T(:,:,:,n), order(n));
            TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, T(:,:,:,n), order(n));
            TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, T(:,:,:,n), order(n));
            TcurrPpir = manimate(pir, Ppir, TcurrPpir, T(:,:,:,n), order(n));
            TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, T(:,:,:,n), order(n));
        end
    end
end

pause(1)

%% Figura 1 - Quadrado

tp = [linspace(0,-raio*cos(circle(1)),NN*5/4)
      linspace(0,-raio*sin(circle(1)),NN*5/4)
      linspace(0,-4,NN*5/4)];

tt1 = [linspace(0,7.71077+3.53553,NN*5/4)
       linspace(0,2.83188+3.53553,NN*5/4)
       linspace(0,-5,NN*5/4)];

tt2 = [linspace(0,-pi/2,NN*5/4)
       linspace(0,-1.8912,NN*5/4)
       linspace(0,6.28401+3.53553,NN*5/4)
       linspace(0, -4, NN*5/4)];

ttb1 = [linspace(0,-1, NN)
        linspace(0,pi/2,NN)
        linspace(0,4.79426, NN)
        linspace(0,-8.77583,NN)
        linspace(0,1, NN)];

ttb2 = [linspace(0,pi,NN*5/4)
        linspace(0,-9.28468,NN*5/4)
        linspace(0,-3.71413,NN*5/4)
        linspace(0,2,NN*5/4)];

tpir = [linspace(0,-pi,NN*5/4)
        linspace(0,pi/2,NN*5/4)
        linspace(0,7.07107-1.66804,NN*5/4)
        linspace(0,-11.9502,NN*5/4)
        linspace(0,-1,NN*5/4)];

ttm1 = [linspace(0,pi/2,NN)
        linspace(0,1.04375+3.53553,NN)
        linspace(0,-12.4254-3.53553,NN)
        linspace(0,pi/4,NN)
        linspace(0,-3,NN)];

for n=1:(NN*5)-1

    % TB1 ; TM1
    if n < NN
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0,0,ttb1(1,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mrotz(ttm1(1,2)), 1);
    elseif (NN < n) && (n < NN*2)
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mrotz(ttb1(2,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(ttm1(2,2),0,ttm1(5,2)), 1);
    elseif (NN*2 < n) && (n < NN*3)
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0, ttb1(3,2), 0), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(0, ttm1(3,2),0), 1);
    elseif (NN*3 < n) && (n < NN*4)
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(ttb1(4,2),0,0), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mrotz(ttm1(4,2)), 1);
    elseif (NN*4 < n)
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0,0,ttb1(5,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(0,0,-ttm1(5,2)), 1);
    end

    % PIRR ; TB2 ; T1 ; T2 ; P
    if n < NN*5/4
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(0,0,tp(3,2)), 1);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,0,tt1(3,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(0,0,tt2(4,2)), 1);
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mrotx(tpir(1,2)), 1);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(0,0,-ttb2(4,2)), 1);
    elseif (NN*5/4 < n) && (n < NN*10/4)
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(tp(1,2),0,0), 1);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,tt1(1,2),0), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mrotz(tt2(1,2)), 1);
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mrotz(tpir(2,2)), 1);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mrotz(ttb2(1,2)), 1);
    elseif (NN*10/4 < n) && (n < NN*15/4)
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(0,tp(2,2),0), 1);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(tt1(2,2),0,0), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(tt2(2,2),tt2(3,2),0), 1);
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(tpir(3,2), tpir(4,2), 0), 1);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(ttb2(2,2),ttb2(3,2),0), 1);
    elseif (NN*15/4 < n)
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(0,0,-tp(3,2)), 1);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,0,-tt1(3,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(0,0,-tt2(4,2)), 1);
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(0,0, tpir(5,2)), 1);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(0,0,ttb2(4,2)), 1);
    end

end


%% same color and back again
sameColor(p, t1, t2, tb1, tb2, tm1, pir);

%% Figure 2

ttb2 = [linspace(0, 8.07107,NN*5/4)
        linspace(0,-7.07107,NN*5/4)
        linspace(0,-3.53553,NN*5/4)
        linspace(0, 4,NN*5/4)];

tpir = [linspace(0,10,NN)
        linspace(0, 4, NN)
        linspace(0, pi,NN)
        linspace(0,-6.46451-3.53553,NN)
        linspace(0,13.735+10.6066,NN)
        linspace(0, 3, NN)];

ttb1 = [linspace(0,-7.07107+3.53553,NN*5)];

ttm1 = [linspace(0,2.5,NN*5)];

for n=1:(NN*5)-1

    % TB1 ; TM1
    TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(ttb1(1,2),0,0), 1);
    TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(ttm1(1,2),-ttm1(1,2),0), 1);

    % PIRR
    if n < NN
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(0,0,tpir(2,2)), 1);
    elseif (NN < n) && (n < NN*2)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(tpir(1,2),tpir(1,2),0), 1);
    elseif (NN*2 < n) && (n < NN*3)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mroty(tpir(3,2)), 1);
    elseif (NN*3 < n) && (n < NN*4)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(tpir(5,2),tpir(4,2),0), 1);
    elseif (NN*4 < n)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(0,0,tpir(6,2)), 1);
    end

    % TB2
    if n < NN*5/4
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(ttb2(1,2),ttb2(4,2),0), 1);
    elseif (NN*5/4 < n) && (n < NN*10/4)
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(0, ttb2(2,2), 0), 1);
    elseif (NN*10/4 < n) && (n < NN*15/4)
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(0, ttb2(3,2), 0), 1);
    elseif (NN*15/4 < n)
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(-ttb2(1,2), -ttb2(4,2), 0), 1);
    end

end

%% same color and back again
sameColor(p, t1, t2, tb1, tb2, tm1, pir);

%% Figure 3

tp = [linspace(0,-3.03553,NN*5/2)
      linspace(0,-0.5,NN*5/2)];

tt1 = [linspace(0,-5,NN*5/4)
       linspace(0,-3.53553-5,NN*5/4)
       linspace(0,5,NN*5/4)
       linspace(0,5,NN*5/4)];

ttb1 = [linspace(0,-8.07107,NN)
        linspace(0, -pi/2, NN)
        linspace(0, -7.07107-12.0526, NN)
        linspace(0,7.07107+20.6412,NN)
        linspace(0, -3, NN)];

ttm1 = [linspace(0,-pi/2,NN)
        linspace(0,-17.0047/sqrt(2),NN)
        linspace(0,-(11.3816-3.53553)/sqrt(2),NN)
        linspace(0, -2,NN)];

tpir = [linspace(0,10,NN)
        linspace(0,pi,NN)
        linspace(0,pi/2,NN)
        linspace(0,13.8177+(3.53553*2),NN)
        linspace(0,-17.3533,NN)
        linspace(0,11,NN)];

tt2 = [linspace(0,5,NN)
       linspace(0,-pi/2,NN)
       linspace(0,12.9283+3.53553,NN)
       linspace(0,8.17521,NN)
       linspace(0,1,NN)];

for n=1:(NN*5)-1
    
    % P 
    if n < NN*5/2
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(tp(1,2),0,0), 1);
    elseif n > NN*5/2 
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(tp(2,2),0,0), 1);
    end

    % T1
    if n < NN*5/4
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,0,tt1(1,2)), 1);
    elseif (NN*5/4 < n) && (n < NN*10/4)
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,tt1(2,2),0), 1);
    elseif (NN*10/4 < n) && (n < NN*15/4)
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,0,tt1(3,2)), 1);
    elseif (NN*15/4 < n)
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,tt1(4,2),0), 1);
    end

    % T2 ; PIRR ; TB1 ; TM1
    if n < NN
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(0,0,-tpir(1,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(0,tt2(1,2),0), 1);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0, 0, ttb1(5,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(0,0,ttm1(4,2)), 1);
    elseif (NN < n) && (n < NN*2)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mroty(tpir(2,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(0,0,-tt2(5,2)), 1);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0, ttb1(1,2),0), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mrotz(ttm1(1,2)), 1);
    elseif (NN*2 < n) && (n < NN*3)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mrotz(tpir(3,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mrotz(tt2(2,2)), 1);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mrotz(ttb1(2,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(ttm1(2,2),ttm1(2,2),0), 1);
    elseif (NN*3 < n) && (n < NN*4)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(tpir(4,2),tpir(5,2),0), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(tt2(3,2),tt2(4,2),0), 1);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(ttb1(3,2), ttb1(4,2),0), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(ttm1(3,2),-ttm1(3,2),0), 1);
    elseif (NN*4 < n)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(0,0,-tpir(6,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(0,0,tt2(5,2)), 1);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0, 0, -ttb1(5,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(0,0,-ttm1(4,2)), 1);
    end
end


%% same color and back again
sameColor(p, t1, t2, tb1, tb2, tm1, pir);

%% Return

% pir
tpir = [linspace(0,-pi/2,NN*5/4)
    linspace(0,-phi,NN*5/4)
    linspace(0,pi-theta,NN*5/4)
    linspace(0,-8.93852,NN*5/4)
    linspace(0,2.66804+circ(7,1),NN*5/4)
    linspace(0,3.53553+circ(7,2),NN*5/4)];

% everyone else
t = [linspace(0,-pi/2,NN)
    linspace(0,-phi,NN)
    linspace(0,-theta,NN)];

tp = [linspace(0,6.464447,NN)
    linspace(0,2,NN)];

tt1 = [linspace(0,6.36741,NN)
    linspace(0,8.36742+circ(2,1),NN)
    linspace(0,circ(2,2),NN)];

tt2 = [linspace(0,pi-theta,NN)
    linspace(0,-1.64429,NN)
    linspace(0,0.108804+circ(3,1),NN)
    linspace(0,3.53553+circ(3,2),NN)];

ttm1 = [linspace(0,-theta-pi/4,NN)
    linspace(0,-1.04806+circ(6,1),NN)
    linspace(0,2.50003+circ(6,2),NN)
    linspace(0,-0.548026,NN)];

ttb1 = [linspace(0,15.8469,NN)
    linspace(0,-6.77583+circ(4,1),NN)
    linspace(0,-12.6066+circ(4,2),NN)];

ttb2 = [linspace(0,pi-theta,NN)
    linspace(0,-9.28468,NN)
    linspace(0,-2,NN)    
    linspace(0,8.6066+circ(5,2),NN)];

% plane
Tplane = manimate(plane, Pplane, Tplane, mroty(linspace(0,-phi,NN)), 0);
Tplane = manimate(plane, Pplane, Tplane, mrotx(linspace(0,-theta,NN)), 0);

for n=1:(NN*5)-1

    % PIRR
    if n < NN*5/4
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mroty(tpir(1,2)), 1);
    elseif (NN*5/4 < n) && (n < NN*10/4)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mroty(tpir(2,2)), 0);
    elseif (NN*10/4 < n) && (n < NN*15/4)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mrotx(tpir(3,2)), 0);
    elseif (NN*15/4 < n)
        TcurrPpir = manimate(pir, Ppir, TcurrPpir, mtrans(tpir(5,2), tpir(6,2),-tpir(4,2)), 0);
    end

    % P ; T1 ; T2 ; TM1 ; TB1 ; TB2
    if n < NN
        TcurrPp = manimate(p, Pp, TcurrPp, mroty(t(1,2)), 1);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mroty(t(1,2)), 1);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mroty(t(1,2)), 1);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mroty(t(1,2)), 1);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mroty(t(1,2)), 1);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mroty(t(1,2)), 1);
    elseif (NN < n) && (n < NN*2)
        TcurrPp = manimate(p, Pp, TcurrPp, mroty(t(2,2)), 0);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mroty(t(2,2)), 0);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mroty(t(2,2)), 0);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mroty(t(2,2)), 0);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mroty(t(2,2)), 0);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mroty(t(2,2)), 0);
    elseif (NN*2 < n) && (n < NN*3)
        TcurrPp = manimate(p, Pp, TcurrPp, mrotx(t(3,2)), 0);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mrotx(t(3,2)), 0);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mrotx(tt2(1,2)), 0);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mrotx(t(3,2)), 0);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mrotx(ttb2(1,2)), 0);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mrotx(ttm1(1,2)), 0);
    elseif (NN*3 < n) && (n < NN*4)
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(0,0,tp(1,2)), 0);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(0,0,tt1(1,2)), 0);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(0,0,-tt2(2,2)), 0);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(0,0,-ttb1(1,2)), 0);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(0,0,ttb2(2,2)), 0);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(0,0,0), 0);
    elseif (NN*4 < n)
        TcurrPp = manimate(p, Pp, TcurrPp, mtrans(tp(2,2),0,0), 0);
        TcurrPt1 = manimate(t1, Pt1, TcurrPt1, mtrans(tt1(2,2),tt1(3,2),0), 0);
        TcurrPt2 = manimate(t2, Pt2, TcurrPt2, mtrans(tt2(3,2),tt2(4,2),0), 0);
        TcurrPtb1 = manimate(tb1, Ptb1, TcurrPtb1, mtrans(ttb1(2,2),ttb1(3,2),0), 0);
        TcurrPtb2 = manimate(tb2, Ptb2, TcurrPtb2, mtrans(-ttb2(3,2),ttb2(4,2),0), 0);
        TcurrPtm1 = manimate(tm1, Ptm1, TcurrPtm1, mtrans(ttm1(2,2),ttm1(3,2),0), 0);
    end
end

end


