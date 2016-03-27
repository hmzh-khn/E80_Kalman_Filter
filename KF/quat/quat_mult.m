function [ Q ] = quat_mult( Q1, Q2 )
% quat_mult multiplies two quaternions in vector form [w x y z]' to form a new
% quaternion

% Decompose quaternion 1 into elements
qw = Q1(1);
qx = Q1(2); 
qy = Q1(3); 
qz = Q1(4);

% Construct the multiplication matrix
Q1mat = ...
[ qw -qx -qy -qz;
  qx  qw -qz  qy;
  qy  qz  qw -qx;
  qz -qy  qx  qw;];

% Multiply the matrices together to find the new rotation
Q = Q1mat*Q2';

% Retranspose quaternion into horizontal vector
Q = Q';
end

