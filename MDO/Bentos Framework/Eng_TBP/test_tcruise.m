
P0=1450;
ISADEV=0;
V=90;

i=0;
for H=1500:100:27000
    i=i+1;
hplot(i)=H;
Tcruise(i)=thrust_tbp_cruise(P0,H,V,ISADEV);
end

plot(hplot,Tcruise,'b')