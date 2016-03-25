function [ drag ] = drag( v, w )
% mass calculates the mass of the rocket as the flight progresses.
% it uses a linear reduction of mass with time

% Rocket Mass - Motor-less weight of rocket
% Motor Mass - Motor Mass, including casing
% Propellant Mass - mass of propellant fuel
ROCK_MASS = 0.964; % kg
MOTOR_MASS = 0.158; % kg
PROP_MASS = 0.062; % kg

% total launched mass
TOTAL_MASS = ROCK_MASS + MOTOR_MASS;

% burn time of rocket motor to be modeled
BURN_TIME = 1.6; % s

if time < BURN_TIME
    mass = TOTAL_MASS - (time/BURN_TIME) * PROP_MASS;
else
    mass = TOTAL_MASS - PROP_MASS;
end

end

