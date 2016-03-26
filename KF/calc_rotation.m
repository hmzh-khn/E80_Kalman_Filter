function [ out ] = calc_rotation( wxL, wyL, wzL, dt )
% calc_rotation outputs a magnitude and direction (normalized quaternion) 
% for a rotation in dt time

% calculates local alpha, beta, and gamma
dalphaL = wxL * dt;
dbetaL = wyL * dt;
dgammaL = wzL * dt;

axis_of_rot = [dalphaL dbetaL dgammaL];

% find magnitude of angles - dtheta is angle change about the rocket axis
dtheta = sqrt(dalphaL^2 + dbetaL^2 + dgammaL^2);

% create quaternion to represent rotation
Q = [ cos(dtheta/2) sin(dtheta/2)*axis_of_rot ];

% calculate norm of quaternion, then normalize quaternion
n = sqrt(sum(Q.^2));
Q = Q/n;
out = [ n Q ];

end

