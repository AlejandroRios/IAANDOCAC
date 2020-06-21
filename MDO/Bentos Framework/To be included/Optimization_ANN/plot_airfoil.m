function plot_airfoil
clc
clear

%X=[0.00527063593126306,0.000166004171261627,0.999999718873761,0,0.000125484523318835,0.273963323794879,0.0229407425200868,0.0399743750286701,0.00396315462197663,0.0290174780370235,0.00692659256665422,1.03551528679084e-06,8.43149532495894e-06,4.14107297539258e-06];
X=[0.00207301514477187,0.00203507965857774,0.999153404997716,0.00339333095675520,0.00706985166513241,0.194875224168965,0.00712235043043419,0.00506723562486922,0.00435961550423758,0.000587734864288536,0.00597124094901058,0.00528811010107144,0.00320532285380692,0.00372193160071710];
[xp, ypl, ypu]=gerar_aerofolio_opt(X);
np=size(xp,2);

thick=0;
for i=1:np
    thick_p=ypu(i)-ypl(i);
    if thick_p > thick
        thick = thick_p;
    end
end

fprintf('\n Max. relative thickness of airfoil no. 1: %5.2f \n',thick*100)

hold on


plot([xp xp(np:-1:1)],[ypu ypl(np:-1:1)],'-sk','MarkerFaceColor','k','MarkerSize',3)
%plot(xp,ypl,'-sk','MarkerFaceColor','k','MarkerSize',3)

Y=[0.000000,	0.402316,	0.002270,	0.000000,	0.000000,	0.017075,	0.173794,	0.348988,	0.000000,	0.000000,	0.000000,	0.000000,	0.000000,	0.055558];

[xp, ypl, ypu]=gerar_aerofolio_opt(Y);

thick=0;
for i=1:np
    thick_p=ypu(i)-ypl(i);
    if thick_p > thick
        thick = thick_p;
    end
end

fprintf('\n Max. relative thickness of airfoil no. 2: %5.2f \n',thick*100)
%----------------- Plot Airfoils
plot([xp xp(np:-1:1)],[ypu ypl(np:-1:1)],'-ob','MarkerFaceColor','b','MarkerSize',3)
%plot(xp,ypl,'-ob','MarkerFaceColor','b','MarkerSize',3)
xlim([-0.01,1.01])

lgd=legend('Optimized','Original');
lgd.Title.String = 'Airfoil';
end % function