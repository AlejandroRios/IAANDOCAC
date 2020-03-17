clear
clc

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
XX=X;

wletAR= 2.9967;
wletTR=0.4887;
wletSweep=21.0524;
wletCant=61.1766;
wletTwist=-4.998;
%xtip=[0.00527063593126306,0.000166004171261627,0.999999718873761,0,0.000125484523318835,0.273963323794879,0.0229407425200868,0.0399743750286701,0.00396315462197663,0.0290174780370235,0.00692659256665422,1.03551528679084e-06,8.43149532495894e-06,4.14107297539258e-06];
xtip=[0.00207301514477187,0.00203507965857774,0.999153404997716,0.00339333095675520,0.00706985166513241,0.194875224168965,0.00712235043043419,0.00506723562486922,0.00435961550423758,0.000587734864288536,0.00597124094901058,0.00528811010107144,0.00320532285380692,0.00372193160071710];
soma=sum(xtip);
XX(47:60)=xtip/soma;

XX(1)=0.70;
XX(2)=12500;
XX(11)=1.5;
XX(13)=wletAR;
XX(14)=wletTR;
XX(16)=wletSweep;
XX(17)=wletCant;
XX(18)=wletTwist;

[CLCD,CD]=calc_ANN_WLET(XX);

CL=CLCD*CD;

clear X XX Data