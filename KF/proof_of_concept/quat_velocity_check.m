addpath('../quat/');

Q0 = [0 1 0 0];
Qw = quat_norm([0 0.5 1 2]);
Qw = Qw(2:5);
STEPS = 100;
TOTAL_TIME = 12;
PTS = STEPS*TOTAL_TIME;
dt = TOTAL_TIME/STEPS;

Qprev = quat_norm(Q0);
Qprev = Qprev(2:5);

X = zeros(1,PTS);
Y = zeros(1,PTS);
Z = zeros(1,PTS);

for k=1:STEPS
    Qprev = quat_norm(Qprev);
    Q = Qprev(2:5) + dt*Qw
    Qprev = Q
%     Qprev1 = quat_norm(Qprev);
%     Qprev1(2:5)
    X(k) = Qprev(2);
	Y(k) = Qprev(3);
    Z(k) = Qprev(4);
end

scatter3(X,Y,Z)
