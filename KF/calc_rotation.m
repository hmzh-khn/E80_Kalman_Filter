function [ Q, n ] = calc_rotation( wxL, wyL, wzL, dt )
% calc_rotation outputs a magnitude and direction (normalized quaternion) 
% for a rotation in dt time

% calculates local alpha, beta, and gamma
dalphaL = wxL * dt;
dbetaL = wyL * dt;
dgammaL = wzL * dt;

% find magnitude of angles - dtheta is angle change about the rocket axis
dtheta = sqrt(dalphaL^2 + dbetaL^2 + dgammaL^2);

% create quaternion to represent rotation
Q = [ cos(dtheta/2) sin(dtheta/2)*dalphaL sin(dtheta/2)*dbetaL sin(dtheta/2)*dgammaL ];

% calculate norm of quaternion, then normalize quaternion
n = quatnorm(Q);
Q = Q/n;

end

