function setUnits(this)% Switching Units
    this.readVariables;
       alts  = altd / lconv1 ;
       alm1s = altmin / lconv1 ;
       alm2s = altmax / lconv1 ;
       ars   = a2d / aconv ;
       arm1s = a2min / aconv ;
       arm2s = a2max / aconv ;
       diars = diameng/ lconv1 ;
       dim1s = diamin / lconv1 ;
       dim2s = diamax / lconv1 ;
       u0s   = u0d / lconv2 ;
       pmxs  = pmax / pconv ;
       tmns  = tmin / tconv ;
       tmxs  = tmax / tconv ;
       t4s   = tt4d / tconv ;
       t4m1s = t4min / tconv ;
       t4m2s = t4max / tconv ;
       t7s   = tt7d / tconv ;
       t7m1s = t7min / tconv ;
       t7m2s = t7max / tconv ;
       fhvs = fhvd / flconv ;
       switch (lunits) 
          case 0 % English Units
                 lconv1 = 1.0 ; lconv2 = 1.0 ; fconv = 1.0 ; econv = 1.0 ;
                 mconv1 = 1.0 ; pconv  = 1.0 ; tconv = 1.0 ; mconv2= 1.0 ;
                 econv2 = 1.0 ;
                 tref = 459.7 ;
%                  out.vars.lpa.setText("Pres-psi") ;
%                  out.vars.lpb.setText("Pres-psi") ;
%                  out.vars.lta.setText("Temp-R") ;
%                  out.vars.ltb.setText("Temp-R") ;
%                  in.flight.right.l2.setText("lb/sq in") ;
%                  in.flight.right.l3.setText("F") ;
%                  in.flight.left.l1.setText("Speed-mph") ;
%                  in.flight.left.l2.setText("Altitude-ft") ;
%                  in.size.left.l2.setText("Weight-lbs") ;
%                  in.size.left.l1.setText("Area-sq ft") ;
%                  in.size.left.l3.setText("Diameter-ft") ;
%                  in.burn.left.l1.setText("Tmax -R") ;
%                  in.burn.left.l4.setText("FHV BTU/lb") ;
%                  in.nozl.left.l1.setText("Tmax -R") ;
%                  in.inlet.right.lmat.setText("lbm/ft^3");
%                  in.fan.right.lmat.setText("lbm/ft^3");
%                  in.comp.right.lmat.setText("lbm/ft^3");
%                  in.burn.right.lmat.setText("lbm/ft^3");
%                  in.turb.right.lmat.setText("lbm/ft^3");
%                  in.nozl.right.lmat.setText("lbm/ft^3");
%                  in.nozr.right.lmat.setText("lbm/ft^3");
%                  in.inlet.left.lmat.setText("T lim -R");
%                  in.fan.left.lmat.setText("T lim -R");
%                  in.comp.left.lmat.setText("T lim -R");
%                  in.burn.left.lmat.setText("T lim -R");
%                  in.turb.left.lmat.setText("T lim -R");
%                  in.nozl.left.lmat.setText("T lim -R");
%                  in.nozr.left.lmat.setText("T lim -R");
                 u0max = 1500. ;
                 if (entype == 3) 
                     u0max = 4500. ;
                 end
                 g0d = 32.2 ;
          case 1 % Metric Units
                 lconv1 = .3048 ; lconv2 = 1.609 ; fconv = 4.448 ; 
                 econv = 1055.; econv2 = 1.055 ;
                 mconv1 = .4536 ; pconv  = 6.891 ; tconv = 0.555555 ; 
                 mconv2 = 14.59;    tref = 273.1 ;
%                  out.vars.lpa.setText("Pres-kPa") ;
%                  out.vars.lpb.setText("Pres-kPa") ;
%                  out.vars.lta.setText("Temp-K") ;
%                  out.vars.ltb.setText("Temp-K") ;
%                  in.flight.right.l2.setText("k Pa") ;
%                  in.flight.right.l3.setText("C") ;
%                  in.flight.left.l1.setText("Speed-kmh") ;
%                  in.flight.left.l2.setText("Altitude-m") ;
%                  in.size.left.l2.setText("Weight-N") ;
%                  in.size.left.l1.setText("Area-sq m") ;
%                  in.size.left.l3.setText("Diameter-m") ;
%                  in.burn.left.l1.setText("Tmax -K") ;
%                  in.burn.left.l4.setText("FHV kJ/kg") ;
%                  in.nozl.left.l1.setText("Tmax -K") ;
%                  in.inlet.right.lmat.setText("kg/m^3");
%                  in.fan.right.lmat.setText("kg/m^3");
%                  in.comp.right.lmat.setText("kg/m^3");
%                  in.burn.right.lmat.setText("kg/m^3");
%                  in.turb.right.lmat.setText("kg/m^3");
%                  in.nozl.right.lmat.setText("kg/m^3");
%                  in.nozr.right.lmat.setText("kg/m^3");
%                  in.inlet.left.lmat.setText("T lim -K");
%                  in.fan.left.lmat.setText("T lim -K");
%                  in.comp.left.lmat.setText("T lim -K");
%                  in.burn.left.lmat.setText("T lim -K");
%                  in.turb.left.lmat.setText("T lim -K");
%                  in.nozl.left.lmat.setText("T lim -K");
%                  in.nozr.left.lmat.setText("T lim -K");
                 u0max = 2500. ;
                 if (entype == 3)
                     u0max = 7500. ;
                 end
                 g0d = 9.81 ;
          case 2 %Percent Change .. convert to English
                 lconv1 = 1.0 ; lconv2 = 1.0 ; fconv = 1.0 ; econv = 1.0 ;
                 mconv1 = 1.0 ; pconv  = 1.0 ; tconv = 1.0 ; mconv2= 1.0 ;
                 tref = 459.7 ;
%                  in.flight.right.l2.setText("lb/sq in") ;
%                  in.flight.right.l3.setText("F") ;
%                  in.flight.left.l1.setText("Speed-%") ;
%                  in.flight.left.l2.setText("Altitude-%") ;
%                  in.size.left.l2.setText("Weight-lbs") ;
%                  in.size.left.l1.setText("Area-%") ;
%                  in.burn.left.l1.setText("Tmax -%") ;
%                  in.nozl.left.l1.setText("Tmax -%") ;
%                  in.inlet.right.lmat.setText("<-lbm/ft^3 -Rankine");
%                  in.fan.right.lmat.setText("<-lbm/ft^3 -Rankine");
%                  in.comp.right.lmat.setText("<-lbm/ft^3 -Rankine");
%                  in.burn.right.lmat.setText("<-lbm/ft^3 -Rankine");
%                  in.turb.right.lmat.setText("<-lbm/ft^3 -Rankine");
%                  in.nozl.right.lmat.setText("<-lbm/ft^3 -Rankine");
%                  in.nozr.right.lmat.setText("<-lbm/ft^3 -Rankine");
                 u0max = 1500. ;
                 if (entype == 3)
                     u0max = 4500. ;
                 end
                 g0d = 32.2 ;
                 pt2flag = 1 ;
%                  in.inlet.right.inltch.select(pt2flag) ;
                 arsched = 1 ;
%                  in.nozl.right.arch.select(arsched) ;
                 athsched = 1 ;
%                  in.nozr.right.atch.select(athsched) ;
                 aexsched = 1 ;
%                  in.nozr.right.aech.select(aexsched) ;
       end
       aconv = lconv1 * lconv1 ;
        bconv = econv / tconv / mconv1 ;
        dconv = mconv1/ aconv / lconv1 ;
        flconv = econv2 / mconv1 ;
     
        altd    = alts  * lconv1 ;
        altmin  = alm1s * lconv1 ;
        altmax  = alm2s * lconv1 ;
        a2d     = ars * aconv ;
        a2min   = arm1s * aconv ;
        a2max   = arm2s * aconv ;
        diameng = diars * lconv1 ;
        diamin  = dim1s * lconv1 ;
        diamax  = dim2s * lconv1 ;
        u0d     = u0s * lconv2 ;
        pmax   = pmxs * pconv ;
        tmax   = tmxs * tconv ;
        tmin   = tmns * tconv ;
        tt4d   = t4s * tconv ;
        t4min  = t4m1s * tconv ;
        t4max  = t4m2s * tconv ;
        tt7d   = t7s * tconv ;
        t7min  = t7m1s * tconv ;
        t7max  = t7m2s * tconv ;
        fhvd   = fhvs * flconv ;

        if (lunits == 2) %initialization of reference variables
           if (u0d <= 10.0)
               u0d = 10.0 ;
           end
           u0ref = u0d;  
           if (altd <= 10.0)
               altd = 10.0 ;
           end
           altref = altd;   
           thrref = throtl ;
           a2ref = a2d;  et2ref = eta(3) ; fpref = p3fp2d ;
           et13ref = eta(14); bpref = byprat ; cpref = p3p2d ;
           et3ref  = eta(4);  et4ref = eta(5);  et5ref = eta(6) ;
           t4ref = tt4d ;  p4ref = prat(5) ; t7ref = tt7d;
           et7ref = eta(8); a8ref = a8rat ; 
           fnref = fnlb; fuelref = fuelrat; sfcref = sfc;
           airref = eair ; epref = epr; etref=etr; faref = fa ;
           wtref = weight ; wfref = fnlb/weight;
        end
    this.packVariables;
        
end