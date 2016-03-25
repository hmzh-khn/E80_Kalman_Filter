function [ t_drag ] = t_drag( omega )
% t_drag calculates the torsional drag of the rocket given time and angular
% velocity

% Coefficient of Torsional Drag - Provided
T_D = 1.2;

t_drag = T_D*omega;

end

