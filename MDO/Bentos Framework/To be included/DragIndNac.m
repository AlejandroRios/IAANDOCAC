%%%%%%%%%%%%%%%%%%%%%%%%CDLnac%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eq 4.33 pag 79
% CDLnac = 2a²Sbnac/S + n.Cdc.|a|³.Splnac/S

function CDLnac = DragIndNac(aircraftCL0,aircraftCLa,asaref,var,...
    englength,engde,CL,mach)

aircraftCLarad=aircraftCLa*180/pi;

Sbnac = 0; % Area da Base
if var == 1 || var == 4  
	a = ((CL - aircraftCL0)/aircraftCLarad) + 0;
else
	a = ((CL - aircraftCL0)/aircraftCLarad) + 2*pi/180;
end
%
Splnac = englength * engde;
%
% interpolacao fig 4.19 pag 80
le_de = englength/engde;
n_xv = [2.08797	3.16015	3.87494	5.1847	6.67241	7.80274	8.93277	10.1809	11.1323	12.5587	13.9841	15.3509	16.5981	18.0235	19.3894	20.9332	22.3584	23.7829	25.3265	27.7008];
n_yv = [0.559184	0.581348	0.596124	0.619747	0.643352	0.659568	0.6743	0.686049	0.697829	0.711044	0.719804	0.73154	0.738833	0.747593	0.754874	0.762136	0.76941	0.773715	0.779492	0.786665];
if le_de > max(n_xv)
    le_de = max(n_xv);
elseif le_de < min(n_xv)
    le_de = min(n_xv);
end
n = interp1(n_xv,n_yv,le_de);

% interpolacao fig 4.20 pag 80
Mc = mach*sin(abs(a));
cdc_xv = [0.0	0.101794	0.178716	0.264548	0.303062	0.353461	0.403966	0.442619	0.505132	0.56178	0.621492	0.666341	0.705151	0.729046	0.761799	0.797441	0.847876	0.898223	0.942601	0.986944];
cdc_yv = [1.20	1.20	1.20	1.20866	1.2174	1.23495	1.27019	1.30253	1.36724	1.44082	1.53209	1.6116	1.67049	1.70876	1.74407	1.76756	1.79101	1.79971	1.79958	1.79355];
cdc = interp1(cdc_xv,cdc_yv,Mc);

CDLnac = 2*(a^2)*Sbnac/asaref + n*cdc*((abs(a))^3)*Splnac/asaref;