function [ CG ] = CG( t )
% CG calculates center of gravity of the rocket

% Rocket Mass - Motor-less weight of rocket
% Motor Mass - Motor Mass, including casing
ROCK_MASS = 0.964; % kg

FMASS = 0.109;
GMASS = 0.158;

% Lengths on the rocket
ROCK_LENGTH = 1.2; % m

FMOTOR_LENGTH = 0.099;
GMOTOR_LENGTH = 0.149;

INIT_MOTOR_MASS = FMASS; % kg
MOTOR_LENGTH = FMOTOR_LENGTH; % m

% Total launched mass
TOTAL_MASS = ROCK_MASS + INIT_MOTOR_MASS;

% motor mass at any point
motor_mass = INIT_MOTOR_MASS - TOTAL_MASS + mass(t);

% Rocket Body Diameter - Diameter of main part of rocket
% Cross-sectional circular area of rocket
DIAMETER = 0.0483; % m
AREA = pi*(0.5*DIAMETER)^2;

% center of gravity from bottom
CG = (0.5*ROCK_MASS*ROCK_LENGTH + 0.5*motor_mass*MOTOR_LENGTH)/mass(t);

% center of gravity from top
CG = ROCK_LENGTH - CG;
end

