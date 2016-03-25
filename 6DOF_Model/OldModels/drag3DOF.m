function [ drag ] = drag3DOF( vx, vy, alpha, wind )
% drag calculates the drag for a 3DOF model given a velocity

% Rocket Body Diameter - Diameter of main part of rocket
% Cross-sectional circular area of rocket
DIAMETER = 0.0483; % m
AREA = pi*(0.5*DIAMETER)^2;

% Average Coefficient of Drag - Provided
C_D = 0.57;

% Average Air density
RHO = 1.15; % kg/m^3

% Find the total velocity of all wind
wind_v = sqrt((vx-wind)^2 + vy^2);

% Find the total velocity of all wind going past the rocket (parallel to it)
drag = sign(wind_v*cos(alpha))*0.5*AREA*C_D*RHO*(wind_v*cos(alpha))^2;

end

