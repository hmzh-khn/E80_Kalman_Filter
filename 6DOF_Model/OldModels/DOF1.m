% 1-DOF Model for static motor and flight modeling lab
% Helpers:

% Mass function - mass(time): calculates mass at time t; uses
% burn_time/mass consants

% Drag function - drag1DOF(velocity): calculates drag given velocity
% air density, coefficient of drag (constant), reference area (circular
% cross-section)

% Time step - for numerical steps
TIME_STEP = 0.005;

% Gravitational acceleration
g = 9.80665; % m/s^2

% time creation from 0 to 15 seconds
t = 0:TIME_STEP:10;
data_pts = size(t,2);

% Forces

% Thrust
% data from motor thrust test
measured_thrust = csvread('Factual.csv');
thrust = zeros(1,data_pts);
k=1;
for i=1:size(measured_thrust,1)
    if mod(measured_thrust(i,3),TIME_STEP) == 0
        thrust(k+1) = measured_thrust(i,4);
        k=k+1;
    end
end

net_force = zeros(1,data_pts);

% Outputs
h = zeros(1,data_pts);
v = zeros(1,data_pts);
a = zeros(1,data_pts);

for n=2:size(t,2)
    % Calculate total force and position/derivative data
    net_force(n) = thrust(n) - drag1DOF(v(n-1)) - g*mass(t(n));
	a(n) = net_force(n)/mass(t(n));
	v(n) = v(n-1) + a(n)*TIME_STEP;
	h(n) = h(n-1) + v(n)*TIME_STEP;
    
    if (a(n) < 0 && h(n) < 0) % on the ground
        v(n) = 0;
        h(n) = 0;        
    end
end

% outputs
[apogee_height, apogee_index] = max(h)
apogee_time = t(apogee_index)

subplot(2,2,1);
plot(t, h);
title('Time v. Height');
xlabel('Time (s)');
ylabel('Height (m)');

subplot(2,2,2);
plot(t, v);
title('Time v. Velocity');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

subplot(2,2,3);
plot(t, a);
title('Time v. Acceleration');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

subplot(2,2,4);
plot(t, net_force);
title('Time v. Net Force');
xlabel('Time (s)');
ylabel('Net Force (N)');