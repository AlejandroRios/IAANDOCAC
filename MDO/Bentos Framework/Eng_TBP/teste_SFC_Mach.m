clear all
close all
clc

M0 = linspace(0.1,0.5,100);

j = 0;

for i = M0
    j = j + 1;
    SFC(j) = Specific_Fuel_Consumption(i);
end


plot(M0,SFC)