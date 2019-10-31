function DCDLDG=DCD_LDG(MTOW_kg,wS,DFLAP,DFLAP_MAX)

K=(0.57 - 0.26*DFLAP/DFLAP_MAX)*0.001;

DCDLDG = K*((MTOW_kg)^0.785)/wS;
end % function