function getDrawGeo(this) %get the drawing geometry
    D = this.DATA;
    %this.readVariables;
    
        D.lxhst = 5. ;
 
        D.scale = sqrt(D.acore/3.1415926) ;
        if (D.scale > 10.0)
            D.scale = D.scale / 10.0 ;
        end
    
        if (D.ncflag == 0)
           D.ncomp = round (1.0 + D.p3p2d / 1.5) ;
           if (D.ncomp > 15)
               D.ncomp = 15 ;
           end
           %in.comp.left.f3.setText(String.valueOf(ncomp)) ;
        end
        D.sblade = .02;
        D.hblade = sqrt(2.0/3.1415926);
        D.tblade = .2*D.hblade;
        D.r0 = sqrt(2.0*D.mfr/3.1415926);
        D.x0 = -4.0 * D.hblade ;
    
        D.radius = .3*D.hblade;
        D.rcowl = sqrt(1.8/3.1415926);
        D.liprad = .1*D.hblade ;
        D.xcowl = - D.hblade - D.liprad;
        D.xfan = 0.0 ;
        D.xcomp = D.ncomp*(D.tblade+D.sblade) ;
        D.ncompd = D.ncomp ;
        if (D.entype == 2) %fan geometry
            D.ncompd = D.ncomp + 3 ;
            D.fblade = sqrt(2.0*(1.0+D.byprat)/3.1415926);
            D.rcowl = D.fblade ;
            D.r0 = sqrt(2.0*(1.0+D.byprat)*D.mfr/3.1415926);
            D.xfan = 3.0 * (D.tblade+D.sblade) ;
            D.xcomp = D.ncompd*(D.tblade+D.sblade) ;
        end
        if (D.r0 < D.rcowl) 
          D.capc = (D.rcowl - D.r0)/((D.xcowl-D.x0)*(D.xcowl-D.x0)) ;
          D.capb = -2.0 * capc * D.x0 ;
          D.capa = D.r0 + D.capc * D.x0*D.x0 ;
        else
          D.capc = (D.r0 - D.rcowl)/((D.xcowl-D.x0)*(D.xcowl-D.x0)) ;
          D.capb = -2.0 * D.capc * D.xcowl ;
          D.capa = D.rcowl + D.capc * D.xcowl*D.xcowl ;
        end
        D.lcomp = D.xcomp ;
        D.lburn = D.hblade ;
        D.xburn = D.xcomp + D.lburn ;
        D.rburn = .2*D.hblade ;

        if (D.ntflag == 0) 
          D.nturb = 1 + D.ncomp/4 ;
          %in.turb.left.f3.setText(String.valueOf(nturb)) ;
          if (D.entype == 2)
              D.nturb = D.nturb + 1 ;
          end
        end
        D.lturb = D.nturb*(tblade+sblade) ;
        D.xturb = D.xburn + D.lturb ;
        D.xturbh = D.xturb - 2.0*(D.tblade+D.sblade) ;
        D.lnoz = D.lburn ;
        if (D.entype == 1)
            D.lnoz = 3.0 * D.lburn ;
        end
        if (D.entype == 3)
            D.lnoz = 3.0 * D.lburn ;
        end
        D.xnoz = D.xturb + D.lburn ;
        D.xflame = D.xturb + D.lnoz ;
        D.xit = D.xflame + D.hblade ;
        if (D.entype <=2) 
          D.rnoz = sqrt(D.a8rat*2.0/3.1415926);
          D.cepc = -D.rnoz/(D.lxhst*D.lxhst) ;
          D.cepb = -2.0*D.cepc*(D.xit + D.lxhst) ;
          D.cepa = D.rnoz - D.cepb*D.xit - D.cepc*D.xit*D.xit ;
        end
        if (D.entype == 3) 
          D.rnoz = sqrt(D.arthd*D.arexitd*2.0 / 3.1415926) ;
          D.rthroat = sqrt(D.arthd*2.0 / 3.1415926) ;
        end
       %animated flow field
%        for(i=0; i<=5; ++ i) {   // upstream
%            xg(5)[i] = xg(1)[i] = i * (xcowl - x0)/5.0 +x0  ;
%            yg(1)[i] = .9*hblade;
%            yg(5)[i] = 0.0 ;
%        }
%        for(i=6; i<=14; ++ i) {  // compress
%            xg(5)[i] = xg(1)[i] = (i-5) * (xcomp - xcowl)/9.0 + xcowl ;
%            yg(1)[i] = .9*hblade ;
%            yg(5)[i] = (i-5) * (1.5*radius)/9.0 ;
%        }
%        for(i=15; i<=18; ++ i) {  // burn
%            xg(1)[i] = (i-14) * (xburn - xcomp)/4.0 + xcomp ;
%            yg(1)[i] = .9*hblade ;
%            yg(5)[i] = .5*radius ;
%        }
%        for(i=19; i<=23; ++ i) {  // turb
%            xg(1)[i] = (i-18) * (xturb - xburn)/5.0 + xburn ;
%            yg(1)[i] = .9*hblade ;
%            yg(5)[i] = (i-18) * (-.5*radius)/5.0 + radius ;
%        }
%        for(i=24; i<=29; ++ i) { // nozzl
%            xg(1)[i] = (i-23) * (xit - xturb)/6.0 + xturb ;
%            if (entype != 3) {
%              yg(1)[i] = (i-23) * (rnoz - hblade)/6.0 + hblade ;
%            }
%            if (entype == 3) {
%              yg(1)[i] = (i-23) * (rthroat - hblade)/6.0 + hblade ;
%            }
%            yg(5)[i] = 0.0 ;
%        }
%        for(i=29; i<=34; ++ i) { // external
%            xg(1)[i] = (i-28) * (3.0)/3.0 + xit ;
%            if (entype != 3) {
%               yg(1)[i] = (i-28) * (rnoz)/3.0 + rnoz ;
%            }
%            if (entype == 3) {
%               yg(1)[i] = (i-28) * (rthroat)/3.0 + rthroat ;
%            }
%            yg(5)[i] = 0.0 ;
%        }
% 
%        for (j=1; j<=3; ++ j) { 
%            for(i=0; i<=34; ++ i) {
%              xg[j][i] = xg(1)[i] ;
%              yg[j][i] = (1.0 - .25 * j) * (yg(1)[i]-yg(5)[i]) + yg(5)[i] ;
%            }
%        }
%        for (j=5; j<=8; ++ j) { 
%            for(i=0; i<=34; ++ i) {
%               xg[j][i] = xg(1)[i] ;
%               yg[j][i] = -yg[8-j][i] ;
%            }
%        }
%        if (entype == 2) {  // fan flow
%            for(i=0; i<=5; ++ i) {   // upstream
%                xg(10)[i] = xg(1)[i] ;
%                xg(11)[i] = xg(1)[i] ;
%                xg(12)[i] = xg(1)[i] ;
%                xg(13)[i] = xg(1)[i] ;
%            }
%            for(i=6; i<=34; ++ i) {  // compress
%                xg(10)[i] = xg(11)[i] = xg(12)[i] = xg(13)[i] =
%                      (i-6) * (7.0 - xcowl)/28.0 + xcowl ;
%            }
%            for(i=0; i<=34; ++ i) {  // compress
%                yg(10)[i] = .5*(hblade + .9*rcowl) ;
%                yg(11)[i] = .9*rcowl ;
%                yg(12)[i] = -.5*(hblade + .9*rcowl) ;
%                yg(13)[i] = -.9*rcowl ;
%            }
%        }
%      }

%this.packVariables;
this.DATA = D;
end