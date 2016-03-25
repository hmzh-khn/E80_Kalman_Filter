function [ drag ] = drag1DOF( v )
% drag calculates the drag for a 1DOF model given a velocity

% Rocket Body Diameter - Diameter of main part of rocket
% Cross-sectional circular area of rocket
DIAMETER = 0.0483; % m
AREA = pi*(0.5*DIAMETER)^2;

% Average Coefficient of Drag - Provided
C_D = 0.57;

% Average Air density
RHO = 1.15; % kg/m^3

drag = sign(v)*0.5*AREA*C_D*RHO*v^2;

end

