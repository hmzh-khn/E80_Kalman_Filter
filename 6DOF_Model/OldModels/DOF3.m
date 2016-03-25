% 3-DOF Model for static motor and flight modeling lab
% Helpers:

% Mass function - mass(time): calculates mass at time t; uses
% burn_time/mass consants

% CG function - CG(time): calculates CG from top of rocket at time t; uses
% rocket and motor mass/length constants

% Drag function - drag3DOF(velocity): calculates drag given velocity
% air density, coefficient of drag (constant), reference area (circular
% cross-section)

% Torsional Drag function - t_drag(angular velocity): calculates drag given
% angular velocity
% use T_D torsional drag constant

% Time step - for numerical steps
TIME_STEP = 0.005;

% Rocket Info
ROCK_LENGTH = 1.2; % m

% Gravitational acceleration
g = 9.80665; % m/s^2

% Center of Pressure - center of pressure from top of rocket
CP = 1; % m

% Wind speed
w = -1.34112; % m/s = -3 mph
% w=0;

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

% Angle of Attack
alpha = zeros(1,data_pts);

% Outputs
% X Force
force_x = zeros(1,data_pts);
x = zeros(1,data_pts);
vx = zeros(1,data_pts);
ax = zeros(1,data_pts);

% Z Force
force_z = zeros(1,data_pts);
z = zeros(1,data_pts);
vz = zeros(1,data_pts);
az = zeros(1,data_pts);

% Angular
I = (1/12)*mass(0)*ROCK_LENGTH^2*0.5; % initial 

torque = zeros(1,data_pts);
theta = zeros(1,data_pts);
theta(1) = pi/2; % rocket starts upright
omega = zeros(1,data_pts);
ang_accel = zeros(1,data_pts);

for n=2:size(t,2)
    I = (1/12)*mass(t(n))*ROCK_LENGTH^2*0.5; % approximation of rod spinning about center
    r = (CP - CG(t(n)));
    
    % Calculate total force and position/derivative data
    force_x(n) = thrust(n)*cos(theta(n-1)) ...
                - drag3DOF(vx(n-1), vz(n-1), alpha(n-1), w)*cos(theta(n-1)) ...
                - lift3DOF(vx(n-1), vz(n-1), alpha(n-1), w)*sin(theta(n-1));
	ax(n) = force_x(n)/mass(t(n));
	vx(n) = vx(n-1) + ax(n)*TIME_STEP;
	x(n) = x(n-1) + vx(n)*TIME_STEP;
    
    force_z(n) = thrust(n)*sin(theta(n-1)) ...
                - mass(t(n))*g ...
                - drag3DOF(vx(n-1), vz(n-1), alpha(n-1), w)*sin(theta(n-1)) ...
                + lift3DOF(vx(n-1), vz(n-1), alpha(n-1), w)*cos(theta(n-1));
	az(n) = force_z(n)/mass(t(n));
    vz(n) = vz(n-1) + az(n)*TIME_STEP;
    z(n) = z(n-1) + vz(n)*TIME_STEP;
    
    if (az(n) < 0 && z(n) < 0) % on the ground
        vz(n) = 0;
        z(n) = 0;        
    end
    
    torque(n) = - t_drag(omega(n-1)) ...
                - r*lift3DOF(vx(n-1), vz(n-1), alpha(n-1), w);
	ang_accel(n) = torque(n)/I;
	omega(n) = omega(n-1) + ang_accel(n)*TIME_STEP;
	theta(n) = theta(n-1) + omega(n)*TIME_STEP;
    
    alpha(n) = theta(n) - atan2(vz(n),vx(n)-w);
end

% outputs
[apogee_height, apogee_index] = max(z)
apogee_time = t(apogee_index)

subplot(3,2,1);
plot(t, z);
title('Time v. Height');
xlabel('Time (s)');
ylabel('Height (m)');

subplot(3,2,2);
plot(t, vz);
title('Time v. Vertical Velocity');
xlabel('Time (s)');
ylabel('Vertical Velocity (m/s)');

subplot(3,2,3);
plot(t, az);
title('Time v. Vertical Acceleration');
xlabel('Time (s)');
ylabel('Vertical Acceleration (m/s^2)');

subplot(3,2,4);
plot(t, x);
 title('Time v. X Position');
 xlabel('Time (s)');
ylabel('X Position (m)');
% 
% subplot(2,2,2);
% plot(t, vx);
% title('Time v. X Velocity');
% xlabel('Time (s)');
% ylabel('X Velocity (m/s)');
% 
% subplot(2,2,3);
% plot(t, ax);
% title('Time v. X Acceleration');
% xlabel('Time (s)');
% ylabel('X Acceleration (m/s^2)');
% 
 subplot(3,2,5);
 plot(t, theta);
 title('Time v. Angle Theta');
 xlabel('Time (s)');
 ylabel('Theta (rad)');
 
  subplot(3,2,6);
 plot(t, alpha);
 title('Time v. Angle of Attack');
 xlabel('Time (s)');
 ylabel('Alpha (rad)');
% 
% subplot(2,2,2);
% plot(t, vx);
% title('Time v. Rotational Velocity');
% xlabel('Time (s)');
% ylabel('X Velocity (m/s)');
% 
% subplot(2,2,3);
% plot(t, ax);
% title('Time v. X Acceleration');
% xlabel('Time (s)');
% ylabel('X Acceleration (m/s^2)');