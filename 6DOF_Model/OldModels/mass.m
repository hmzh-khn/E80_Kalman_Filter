function [ mass ] = mass( t )
% mass calculates the mass of the rocket as the flight progresses.
% it uses a linear reduction of mass with time

% Rocket Mass - Motor-less weight of rocket
% Motor Mass - Motor Mass, including casing
% Propellant Mass - mass of propellant fuel
ROCK_MASS = 0.964; % kg
FMASS = 0.109;
GMASS = 0.158;



FPROP_MASS = 0.0305;
GPROP_MASS = 0.062;

% burn time of rocket motor to be modeled

F_BURN_TIME = 1.0;
F_ACTUAL_TIME = 1.0; %CHANGE!!!
G_BURN_TIME = 1.4;
G_ACTUAL_BURN_TIME = 1.6;

MOTOR_MASS = FMASS; % kg
PROP_MASS = FPROP_MASS; % kg
BURN_TIME = F_BURN_TIME; % s

% total launched mass
TOTAL_MASS = ROCK_MASS + MOTOR_MASS;

if t < BURN_TIME
    mass = TOTAL_MASS - (t/BURN_TIME) * PROP_MASS;
else
    mass = TOTAL_MASS - PROP_MASS;
end

end

