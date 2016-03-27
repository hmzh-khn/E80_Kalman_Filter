function [ Qc ] = quat_conj( Q )
% quat_norm returns the conjugate of the quaternion

% Decompose quaternion into elements
qw = Q(1);
qx = Q(2); 
qy = Q(3); 
qz = Q(4);

% Negate i, j, and k coefficients and return
Qc = [qw -qx -qy -qz];
end
