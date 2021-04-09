clear;clc;
ht = 10;        % Transmitter Height
hr = 3;         % Reciever Height
d = 1:2000;     % Distance between Tx & Rx
F = 2e9;        % Frequency
G_l = 1;        % in square root value 
G_r = 1;        % in square root value 
Er = 15;        % dielectric constant

lambda = 3e8/F;                     % Wavelength       
L = sqrt((ht-hr)^2 + d.^2);         % LOS distance 
x_x1 = sqrt((ht+hr)^2 + d.^2);      % Reflected Ray distance
x = x_x1./(1+ ht/hr);               % distance to incident 
theta = ht./x;                      % angle of incident
Z= sqrt(Er - cos(theta).^2);        % Polarization Factor
R = (sin(theta)- Z)/(sin(theta)+ Z);% Reflection coefficient 
Phi = 2*pi*(x_x1-L)/lambda;         % change in Phase

T1 = 20*log(lambda/4*pi);
T2 = 20*log(abs((G_l./L)+(R.*G_r.*exp(-1i*Phi)./x_x1)));

Path_Loss = T1 + T2;

subplot(2,1,1)
plot(log(d),Path_Loss);
xlabel("distance");
ylabel("Path Loss");
subplot(2,1,2);
plot(log(d),theta.*(180/pi));
xlabel("distance");
ylabel("Phase Change");

% Notes 
% As the frequency increases the constructive and destructive interference
% increases.
% Phase change tends to 0 as the distance increases.
% Antenna height also affects the Path Loss 
% attenuation of the signal is reduced if the antenna size in increased
% the gain due to beam forming has a significat effect 

