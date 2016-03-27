function [ out ] = quat_norm( Q )
% quat_norm normalizes a quaternion and returns the norm and normalized
% quaternion

% Decompose quaternion into elements
qw = Q(1);
qx = Q(2); 
qy = Q(3); 
qz = Q(4);

% Find the norm and normalized quaternion
n = sqrt(qw^2 + qx^2 + qy^2 + qz^2);
Qn = Q/n;

out = [ n Qn ];
end
