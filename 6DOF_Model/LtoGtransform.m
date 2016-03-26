function [ output ] = LtoGtransform( M , T)
%Takes an input M that is a matrix of accelerations and angular velocities
%measured from an accelerometer and transforms these values from the local
%frame to the global frame. 
%   M = [axL ayL azL wxL wyL wzL; ...]
%   output = [axG ayG azG; ...]

R = [1 0 0; 0 1 0; 0 0 1]; % Initially local and global frame are the same
s = size(M);
dt = T/s(1);    % Total time divided by the number of samples
g = 9.8;    % gravitational acceleration

output = ones(s(1),3);  % Create matrix with same number of rows as M but only 3 columns

for t = 1:1:s(1)    % for loop transforms each set accelerations
    axL= M(t,1);
    ayL= M(t,2);
    azL= M(t,3);
    wxL= M(t,4);
    wyL= M(t,5);
    wzL= M(t,6);
    
    aL = [axL ayL azL]';    % accelerations in global frame
    aG = R*aL;              % rotation transformation to global frame
    aG(3) = aG(3) - g;      % correct for gravitational acceleration
    output(t,:) = aG;       % store in output matrix
    
    Om = [0 -wzL wyL; wzL 0 -wxL; -wyL wxL 0];  % angular velocity matrix
    
    angleShift = eye(3,3) + Om*dt;  % calculates the shift of the rotation matrix
    
    R = R*angleShift;   % new transformation matrix based on how rocket has rotated
    
end



end

