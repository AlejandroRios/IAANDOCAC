% This optiization uses ANNs to optimize winglet only
clear
clc

tic

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

PopSize=50;

lb=[1.5;0.2;20;10;-5];
ub=[3;0.5;35;80;0];

for i=1:14
lb=[lb;0];
ub=[ub; 1];
end

options=gaoptimset('TolFun',1e-08,'TolCon',1e-08,'PopulationSize',PopSize,...
    'Generations',35,'CrossoverFraction',0.70,'Display','iter',...
    'PlotFcns',{@gaplotbestindiv,@gaplotbestf,@gaplotscorediversity });

[x,~,~,output,population]=ga({@Fobjetivo2,X},19,[],[],[],[],lb,ub,...
    @ThicknessConstraint,[],options);

optimal_airplane=x

wletAR=x(1);
wletTR=x(2);
wletSweep=x(3);
wletCant=x(4);
wletTwist=x(5);
soma=sum(x(6:19));
X(47:60)=x(6:19)/soma;

X(1) = 0.70;
X(2) = 12500;
X(11)= 1.5;
X(13)= wletAR;
X(14)= wletTR;
X(16)= wletSweep;
X(17)= wletCant;
X(18)= wletTwist;

[CLCD, ~]=calc_ANN_WLET(X);

fprintf('\n Lift-to-Drag ratio of Optimal Airplane: %5.2f \n',CLCD)

toc
%