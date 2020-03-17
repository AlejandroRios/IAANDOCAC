clc
clear
% --------------------- Load Trained Neural Networks ----------------------

netCDI  = importdata('ANN_WLET_4_57000_60_40.mat');
netCDW  = importdata('ANN_WLET_5_57000_100_60.mat');
netCD0  = importdata('ANN_WLET_3_57000_100_60.mat');
netCL   = importdata('ANN_WLET_2_57000_80_40.mat');

%--------------------------------------------------------------------------
IDes=156218;

fprintf('\n Desired Airplane ID: %i \n',IDes)

fileID = fopen('output_comwinglet.txt','r');
formatSpec = '%d\t';
for i=1:70
    formatSpec = strcat(formatSpec,'%f\t');
end

sizeData = [71 Inf];

Data = fscanf(fileID,formatSpec,sizeData);
Data = Data';

nPlanes=size(Data,1);

i=1;
while Data(i,1) ~= IDes 
i=i+1;
end

% ******* Stop processing if desired ID is not found ***************
if i >= nPlanes
    fprintf('\n No airplane found! \n')
    return
end

ifound=i;

X = [Data(ifound, 2:61) Data(ifound, 63:66)];

% X(1)=	0.803811;
% X(2)= 7698.;
% X(3)= 7.959361;
% X(4)=0.470155;
% X(5)=3.371042;
% X(6)=0.369913;
% X(7)=2.255718;
% X(8)=0.868351;
% X(9)=0.878675;
% X(10)=216.645942;
% X(11)=-2.000000;
% X(12)=31.070303;
% X(13)=1.879346;
% X(14)=0.376459;
% X(15)=0.612493;
% X(16)=33.896758;
% X(17)=26.016483;
% X(18)=0.482050;
% X(19)=0.000000;
% X(20)=0.000000;
% X(21)=	0.229181;	
% X(22)=0.000000;
% X(23)=0.000000;
% X(24)=0.418876;	
% X(25)=0.000000;	
% X(26)=0.000000;	
% X(27)=0.223956;	
% X(28)=0.000000;	
% X(29)=0.127987;
% X(30)=0.000000;	
% X(31)=0.000000;
% X(32)=0.000000;	
% X(33)=0.000000;	
% X(34)=0.062095;	
% X(35)=0.000000;	
% X(36)=0.000000;	
% X(37)=0.294174;	
% X(38)=0.000000;	
% X(39)=0.000000;	
% X(40)=0.024082;	
% X(41)=0.023514;	
% X(42)=0.270896;	
% X(43)=0.000000;	
% X(44)=0.000000;	
% X(45)=0.325240;	
% X(46)=0.000000;	
% X(47)=0.123840;	
% X(48)=0.128103;	
% X(49)=0.068617;	
% X(50)=0.000000;	
% X(51)=0.000000;	
% X(52)=0.000000;	
% X(53)=0.113418;	
% X(54)=0.234490;	
% X(55)=0.000000;	
% X(56)=0.000000;	
% X(57)=0.288046;	
% X(58)=0.000000;	
% X(59)=0.043487;	
% X(60)=0.000000;	
% 
% X(61)=48.515556;	
% X(62)=3.925426;
% X(63)=4.292255;
% X(64)=538.755352;	

winglet=true;

CLdes = 0.50;


[CL,CD, CD0,CDI,CDW]=Calc_ANN_CLCD_Alfa(X,winglet,netCDW,netCDI,netCD0,netCL)


