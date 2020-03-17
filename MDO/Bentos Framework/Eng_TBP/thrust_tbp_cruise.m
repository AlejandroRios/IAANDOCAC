function Tcruise=thrust_tbp_cruise(manete,P0,V,H,ISADEV)
% P0: Maximum engine shaft power in kW
% V:  Speed ]m/s]
% H:  Altitude [ft]
% ISADEV: ISA deviation 
%--------------------------------------------------------------------------
cd ..
atm=atmosfera(H,ISADEV);
cd Eng_TBP

sigma=atm(4);
vsound=atm(7);
MN=V/vsound;

Tcruise = 1.62*(P0^1.05)*(((sigma^0.883)/MN + 0.75*sigma^0.733));
Tcruise = manete*Tcruise;

end % function