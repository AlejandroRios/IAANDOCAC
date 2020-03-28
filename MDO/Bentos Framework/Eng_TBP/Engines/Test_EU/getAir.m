function number = getAir(mach, gamma)
%{Utility to get the corrected airflow per area given the Mach number }%
     fac2 = (gamma+1.0)/(2.0*(gamma-1.0)) ;
     fac1 = pow((1.0+.5*(gamma-1.0)*mach*mach),fac2);
     number =  .50161*sqrt(gamma) * mach/ fac1 ;
end