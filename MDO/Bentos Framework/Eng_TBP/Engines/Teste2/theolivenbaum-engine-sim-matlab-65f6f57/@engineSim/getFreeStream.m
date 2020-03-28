function getFreeStream(this)
    %this.readVariables;
    D = this.DATA;
    
    D.rgas = 1718. ;                %{ft2/sec2 R }%
    if (D.inptype >= 2)
        D.ps0 = D.ps0 * 144. ;
    end
    if (D.inptype <= 1)            %{input altitude }%
        D.alt = D.altd / D.lconv1  ;
        if (D.alt < 36152. )
            D.ts0 = 518.6 - 3.56 * D.alt / 1000. ;
            D.ps0 = 2116. * pow(D.ts0/518.6, 5.256) ;
        end
        if (D.alt >= 36152. && D.alt <= 82345.) % Stratosphere
            D.ts0 = 389.98 ;
            D.ps0 = 2116. * .2236 * exp((36000.-D.alt)/(53.35*389.98)) ;
        end
        if (D.alt >= 82345.)
            D.ts0 = 389.98 + 1.645 * (D.alt-82345)/1000. ;
            D.ps0 = 2116. *.02456 * pow(D.ts0/389.98,-11.388) ;
        end
    end
    
    D.a0 = sqrt(D.gama*D.rgas*D.ts0) ;             %{speed of sound ft/sec }%
    if (D.inptype == 0 || D.inptype == 2)           %{input speed  }%
        D.u0 = D.u0d /D.lconv2 *5280./3600. ;           %{airspeed ft/sec }%
        D.fsmach = D.u0/D.a0 ;
        D.q0 = D.gama / 2.0*D.fsmach*D.fsmach*D.ps0 ;
    end
    if (D.inptype == 1 || D.inptype == 3)             %{input mach }%
        D.u0 = D.fsmach * D.a0 ;
        D.u0d = D.u0 * D.lconv2 / 5280.* 3600. ;      %{airspeed ft/sec }%
        D.q0 = D.gama / 2.0*D.fsmach*D.fsmach*D.ps0 ;
    end
    if (D.u0 > .0001)
        D.rho0 = D.q0 /(D.u0*D.u0) ;
    else
        D.rho0 = 1.0 ;
    end
    
    D.tt(1) = D.ts0*(1.0 + .5 * (D.gama -1.0) * D.fsmach * D.fsmach) ;
    D.pt(1) = D.ps0 * pow(D.tt(1)/D.ts0,D.gama/(D.gama-1.0)) ;
    D.ps0 = D.ps0 / 144. ;
    D.pt(1) = D.pt(1) / 144. ;
    D.cpair = getCp(D.tt(1),D.gamopt);              %BTU/lbm R }%
    D.tsout = D.ts0 ;
    D.psout = D.ps0 ;
    %this.packVariables;
    this.DATA = D;
end