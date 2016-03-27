function [ Pout ] = quat_rot( Pin, Q )
% quat_rot rotates a vector given a NORMALIZED quaternion

% Extract normalized quaternion and norm
normQinfo = quat_norm(Q);
n = normQinfo(1); % <= Is this necessary?
Qn = normQinfo(2:5);

% Decompose quaternion into elements
qw = Qn(1);
qx = Qn(2); 
qy = Qn(3); 
qz = Qn(4);

% Define the rotation matrix
R = ...
[ 1-2*qy^2-2*qz^2   2*qx*qy-2*qz*qw   2*qx*qz+2*qy*qw; ...
  2*qx*qy+2*qz*qw   1-2*qx^2-2*qz^2	  2*qy*qz-2*qx*qw; ...
  2*qx*qz-2*qy*qw	2*qy*qz+2*qx*qw	  1-2*qx^2-2*qy^2; ];

% Apply rotation transformation
Pout = R*Pin;
end