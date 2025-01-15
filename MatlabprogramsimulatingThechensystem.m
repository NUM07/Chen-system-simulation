ti = 0; % set the initial value of t 
tf = 130; % set the final value of t 
dt = 0.01; 
% set the step size 
xo = 5.0; yo = 10.0; zo = 10.0; 
% set the initial conditions (arbitrarily) 
t = [ti : dt : tf]; 
% creating a vector of the nodal points 
N = length(t); 
% calculate the number of nodes 
r(:,1) = [xo ; yo ; zo]; 
% creating a vector with the initial conditions 
for i = 1: N-1 
    k1 = dt * f( t(i) , r(:,i) ); 
    k2 = dt * f( t(i)+dt/2 , r(:,i)+k1/2); 
    k3 = dt * f( t(i)+dt/2 , r(:,i)+k2/2);
    k4 = dt * f( t(i)+dt , r(:,i)+k3); 
    r(:,i+1) = r(:,i)+(k1+2*k2+2*k3+k4)/6; 
end 
figure(1),plot(t,r(1,:),t,r(2,:),t,r(3,:))
figure(2),plot3(r(1,:),r(2,:),r(3,:)),grid on 
clear t 
x=r(1,3002:N)'; 
y=r(2,3002:N)';
z=r(3,3002:N)'; 
clear r 
figure(3),plot3(x,y,z),grid on
function [rdot] = f (t, r)
    sigma   = -0.38; 
    alpha   = 5; 
    beta    = -10; 
    x       = r(1);     
    y       = r(2);
    z       = r(3);
    rdot    = zeros(3,1);
    rdot(1) = alpha * x - y * z;
    rdot(2) = beta * y + x * z;
    rdot(3) = sigma * z + (x * y) / 3;
end       

% existing code for chen system simulation  continues here followed by
% Compute Fractal Dimension (Capacity Dimension)
epsilon = 0.1:0.1:10; % Range of epsilon values
N_eps = length(epsilon); % Number of epsilon values
N_points = zeros(N_eps, 1); % Number of points within epsilon distance
for i = 1:N_eps
    for j = 1:length(x)
        dist = sqrt((x - x(j)).^2 + (y - y(j)).^2 + (z - z(j)).^2);
        N_points(i) = N_points(i) + sum(dist < epsilon(i));
    end
end
% Compute the capacity dimension
log_N = log(N_points);
log_eps = log(epsilon);
coeffs = polyfit(log_eps, log_N, 1);
fractal_dim = coeffs(1);
disp("Fractal Dimension (Capacity Dimension): " + fractal_dim);
epsilon = 0.1:0.1:10; % Range of epsilon values
N_eps = length(epsilon); % Number of epsilon values

N_points = zeros(N_eps, 1); % Number of points within epsilon distance
for i = 1:N_eps
    for j = 1:length(x)
        dist = sqrt((x - x(j)).^2 + (y - y(j)).^2 + (z - z(j)).^2);
        N_points(i) = N_points(i) + sum(dist < epsilon(i));
    end
end

% Compute the information dimension
log_N = log(N_points);
log_eps = log(epsilon);

coeffs = polyfit(log_eps, log_N, 1);
information_dim = -coeffs(1);
disp("Fractal Dimension (Information Dimension): " + information_dim);
