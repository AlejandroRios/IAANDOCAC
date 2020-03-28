%Ensure EngineSim and the helper folder are visible on Matlab path
addpath(genpath(fileparts(mfilename('fullpath'))));

ES =  engineSim();

%Load the data for the CF6 turbine - see https://en.wikipedia.org/wiki/General_Electric_CF6
ES.loadCF6();



N = 10;
[MachGrid, AltGrid] = meshgrid(linspace(0, 0.8, N), linspace(0, 10000 ,N));
NetThrust = zeros(size(MachGrid));
FuelFlow  = zeros(size(MachGrid));

for i = 1:numel(MachGrid)
    %Set Mach and Altitude values
    ES.setMach_Altitude(MachGrid(i), AltGrid(i));
    ES.setThrottleSafe(1);
    %Get Net Thrust
    NetThrust(i) = ES.getNetThrust();
    FuelFlow(i)  = ES.getFuelFlow();
end

figure; 
ax1 = subplot(1,2,1);
surf(MachGrid,AltGrid, NetThrust./1000);
shading interp
xlabel 'Mach Number'
ylabel 'Altitude [m]'
zlabel 'Net Thrust [kN]'

ax2 = subplot(1,2,2);
surf(MachGrid,AltGrid, FuelFlow);
shading interp
xlabel 'Mach Number'
ylabel 'Altitude [m]'
zlabel 'Fuel Flow [kg/s]'

linkprop([ax1 ax2],'View');
