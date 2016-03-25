function [ lift ] = lift3DOF( vx, vz, alpha, wind )
% drag calculates the drag for a 3DOF model given a velocity

% Rocket Body Diameter - Diameter of main part of rocket
% Cross-sectional circular area of rocket
ROCK_LENGTH = 1.2; % m
DIAMETER = 0.0483; % m
AREA = ROCK_LENGTH*DIAMETER;
% AREA = pi*(0.5*DIAMETER)^2;

% Coefficient of lift approximation that works well for small angles
C_L = 1.2;% 2*pi*alpha;

% Average Air density
RHO = 1.15; % kg/m^3

% Find the total velocity of all wind
wind_v = sqrt((vx-wind)^2 + vz^2);

% Find the total velocity of all wind going past the rocket (parallel to it)
lift = sign(wind_v*sin(alpha))*0.5*AREA*C_L*RHO*(wind_v*sin(alpha))^2;

end

