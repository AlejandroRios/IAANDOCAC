function getThermo(this)
    %this.readVariables;
    D = this.DATA;
    %{  inlet recovery  }%
    if (D.pt2flag == 0)                     %{    mil spec      }%
        if (D.fsmach > 1.0 )           %{supersonic }%
            D.prat(3) = 1.0 - .075*pow(D.fsmach - 1.0, 1.35) ;
        else
            D.prat(3) = 1.0 ;
        end
        D.eta(3) = D.prat(3) ;
        D.i1 = (((D.prat(3) - D.etmin)/(D.etmax-D.etmin))*1000.) ;
    else                        %{enter value }%
        D.prat(3) = D.eta(3) ;
    end
    %{protection for overwriting input }%
    if (D.eta(4) < .5)
        D.eta(4) = .5 ;
    end
    if (D.eta(6) < .5)
        D.eta(6) = .5 ;
    end
    D.trat(8) = 1.0 ;
    D.prat(8) = 1.0 ;
    D.tt(3) = D.tt(1) ;
    D.tt(2) = D.tt(1) ;
    D.pt(2) = D.pt(1) ;
    D.gam(3) = getGama(D.tt(3),D.gamopt) ;
    D.cp(3)  = getCp(D.tt(3),D.gamopt);
    D.pt(3) = D.pt(2) * D.prat(3) ;
    
    %{design - p3p2 specified - D.tt4 specified }%
    if(D.inflag == 0)
        
        if (D.entype <= 1)               %{turbojet }%
            D.prat(4) = D.p3p2d ;                      %{core compressor }%
            if (D.prat(4) < .5)
                D.prat(4) = .5 ;
            end
            D.delhc = (D.cp(3)*D.tt(3)/D.eta(4))*...
                         (pow(D.prat(4),(D.gam(3)-1.0)/D.gam(3))-1.0);
            D.deltc = D.delhc / D.cp(3) ;
            D.pt(4) = D.pt(3) * D.prat(4) ;
            D.tt(4) = D.tt(3) + D.deltc ;
            D.trat(4) = D.tt(4)/D.tt(3) ;
            D.gam(4) = getGama(D.tt(4),D.gamopt) ;
            D.cp(4)  = getCp(D.tt(4),D.gamopt);
            D.tt(5) = D.tt4 * D.throtl/100.0 ;
            D.gam(5) = getGama(D.tt(5),D.gamopt) ;
            D.cp(5)  = getCp(D.tt(5),D.gamopt);
            D.trat(5) = D.tt(5) / D.tt(4) ;
            D.pt(5) = D.pt(4) * D.prat(5) ;
            D.delhht = D.delhc ;
            D.deltht = D.delhht / D.cp(5) ;
            D.tt(6) = D.tt(5) - D.deltht ;
            D.gam(6) = getGama(D.tt(6),D.gamopt) ;
            D.cp(6)  = getCp(D.tt(6),D.gamopt);
            D.trat(6) = D.tt(6)/D.tt(5) ;
            D.prat(6) = pow((1.0-D.delhht/D.cp(5)/D.tt(5)/D.eta(6)),(D.gam(5)/(D.gam(5)-1.0))) ;
            D.pt(6) = D.pt(5) * D.prat(6) ;
            %{fan conditions }%
            D.prat(14) = 1.0 ;
            D.trat(14) = 1.0 ;
            D.tt(14)   = D.tt(3) ;
            D.pt(14)   = D.pt(3) ;
            D.gam(14)  = D.gam(3) ;
            D.cp(14)   = D.cp(3) ;
            D.prat(16) = 1.0 ;
            D.pt(16)   = D.pt(6) ;
            D.trat(16) = 1.0 ;
            D.tt(16)   = D.tt(6) ;
            D.gam(16)  = D.gam(6) ;
            D.cp(16)   = D.cp(6) ;
        end
        
        if(D.entype == 2)                         %{turbofan }%
            D.prat(14) = D.p3fp2d ;
            if (D.prat(14) < .5)
                D.prat(14) = .5 ;
            end
            D.delhf = (D.cp(3)*D.tt(3)/D.eta(14))*...
                    (pow(D.prat(14),(D.gam(3)-1.0)/D.gam(3))-1.0) ;
            D.deltf = D.delhf / D.cp(3) ;
            D.tt(14) = D.tt(3) + D.deltf ;
            D.pt(14) = D.pt(3) * D.prat(14) ;
            D.trat(14) = D.tt(14)/D.tt(3) ;
            D.gam(14) = getGama(D.tt(14),D.gamopt) ;
            D.cp(14)  = getCp(D.tt(14),D.gamopt);
            D.prat(4) = D.p3p2d ;                      %{core compressor }%
            if (D.prat(4) < .5)
                D.prat(4) = .5 ;
            end
            D.delhc = (D.cp(14)*D.tt(14)/D.eta(4))* ...
                      (pow(D.prat(4),(D.gam(14)-1.0)/D.gam(14))-1.0) ;
            D.deltc = D.delhc / D.cp(14) ;
            D.tt(4) = D.tt(14) + D.deltc ;
            D.pt(4) = D.pt(14) * D.prat(4) ;
            D.trat(4) = D.tt(4)/D.tt(14) ;
            D.gam(4) = getGama(D.tt(4),D.gamopt) ;
            D.cp(4)  = getCp(D.tt(4),D.gamopt);
            D.tt(5) = D.tt4 * D.throtl/100.0 ;
            D.pt(5) = D.pt(4) * D.prat(5) ;
            D.gam(5) = getGama(D.tt(5),D.gamopt) ;
            D.cp(5)  = getCp(D.tt(5),D.gamopt);
            D.trat(5) = D.tt(5)/D.tt(4) ;
            D.delhht = D.delhc ;
            D.deltht = D.delhht / D.cp(5) ;
            D.tt(6) = D.tt(5) - D.deltht ;
            D.gam(6) = getGama(D.tt(6),D.gamopt) ;
            D.cp(6)  = getCp(D.tt(6),D.gamopt);
            D.trat(6) = D.tt(6)/D.tt(5) ;
            D.prat(6) = pow((1.0-D.delhht/D.cp(5)/D.tt(5)/D.eta(6)),(D.gam(5)/(D.gam(5)-1.0))) ;
            D.pt(6) = D.pt(5) * D.prat(6) ;
            D.delhlt = (1.0 + D.byprat) * D.delhf ;
            D.deltlt = D.delhlt / D.cp(6) ;
            D.tt(16) = D.tt(6) - D.deltlt ;
            D.gam(16) = getGama(D.tt(16),D.gamopt) ;
            D.cp(16)  = getCp(D.tt(16),D.gamopt);
            D.trat(16) = D.tt(16)/D.tt(6) ;
            D.prat(16) = pow((1.0-D.delhlt/D.cp(6)/D.tt(6)/D.eta(6)),(D.gam(6)/(D.gam(6)-1.0))) ;
            D.pt(16) = D.pt(6) * D.prat(16) ;
        end
        
        if (D.entype == 3)              %{ramjet }%
            D.prat(4) = 1.0 ;
            D.pt(4) = D.pt(3) * D.prat(4) ;
            D.tt(4) = D.tt(3) ;
            D.trat(4) = 1.0 ;
            D.gam(4) = getGama(D.tt(4),D.gamopt) ;
            D.cp(4)  = getCp(D.tt(4),D.gamopt);
            D.tt(5) = D.tt4 * D.throtl/100.0 ;
            D.gam(5) = getGama(D.tt(5),D.gamopt) ;
            D.cp(5)  = getCp(D.tt(5),D.gamopt);
            D.trat(5) = D.tt(5) / D.tt(4) ;
            D.pt(5) = D.pt(4) * D.prat(5) ;
            D.tt(6) = D.tt(5) ;
            D.gam(6) = getGama(D.tt(6),D.gamopt) ;
            D.cp(6)  = getCp(D.tt(6),D.gamopt);
            D.trat(6) = 1.0 ;
            D.prat(6) = 1.0 ;
            D.pt(6) = D.pt(5) ;
            %{fan conditions }%
            D.prat(14) = 1.0 ;
            D.trat(14) = 1.0 ;
            D.tt(14)   = D.tt(3) ;
            D.pt(14)   = D.pt(3) ;
            D.gam(14)  = D.gam(3) ;
            D.cp(14)   = D.cp(3) ;
            D.prat(16) = 1.0 ;
            D.pt(16)   = D.pt(6) ;
            D.trat(16) = 1.0 ;
            D.tt(16)   = D.tt(6) ;
            D.gam(16)  = D.gam(6) ;
            D.cp(16)   = D.cp(6) ;
        end
        
        D.tt(8) = D.tt7 ;
        %{analysis -assume flow choked at both turbine entrances }%
        %{and nozzle throat ... then}%
    else
        D.tt(5) = D.tt4 * D.throtl/100.0 ;
        D.gam(5) = getGama(D.tt(5),D.gamopt) ;
        D.cp(5)  = getCp(D.tt(5),D.gamopt);
        if (D.a4 < .02)
            D.a4 = .02 ;
        end
        
        if (D.entype <= 1)               %{turbojet }%
            D.dela = .2 ;                           %{iterate to get t5t4 }%
            D.trat(6) = 1.0 ;
            D.t5t4n = .5 ;
            D.itcount = 0 ;
            while(abs(D.dela) > .001 && D.itcount < 20)
                D.itcount = D.itcount +1;
                D.delan = D.a8d/D.a4 - sqrt(D.t5t4n)*...
                    pow((1.0-(1.0/D.eta(6))*(1.0-D.t5t4n)),...
                         -D.gam(5)/(D.gam(5)-1.0)) ;
                D.deriv = (D.delan-D.dela)/(D.t5t4n-D.trat(6)) ;
                D.dela = D.delan ;
                D.trat(6) = D.t5t4n ;
                D.t5t4n = D.trat(6) - D.dela/D.deriv ;
            end
            D.tt(6) = D.tt(5) * D.trat(6) ;
            D.gam(6) = getGama(D.tt(6),D.gamopt) ;
            D.cp(6)  = getCp(D.tt(6),D.gamopt);
            D.deltht = D.tt(6)- D.tt(5) ;
            D.delhht  = D.cp(5) * D.deltht ;
            D.prat(6) = pow((1.0-(1.0/D.eta(6))*(1.0-D.trat(6))), D.gam(5)/(D.gam(5)-1.0)) ;
            D.delhc = D.delhht  ;           %{compressor work }%
            D.deltc = -D.delhc / D.cp(3) ;
            D.tt(4) = D.tt(3) + D.deltc ;
            D.gam(4) = getGama(D.tt(4),D.gamopt) ;
            D.cp(4)  = getCp(D.tt(4),D.gamopt);
            D.trat(4) = D.tt(4)/D.tt(3) ;
            D.prat(4) = pow((1.0+D.eta(4)*(D.trat(4)-1.0)),D.gam(3)/(D.gam(3)-1.0)) ;
            D.trat(5) = D.tt(5)/D.tt(4) ;
            D.pt(4)   = D.pt(3) * D.prat(4) ;
            D.pt(5)   = D.pt(4) * D.prat(5) ;
            D.pt(6)   = D.pt(5) * D.prat(6) ;
            %{fan conditions }%
            D.prat(14) = 1.0 ;
            D.trat(14) = 1.0 ;
            D.tt(14)   = D.tt(3) ;
            D.pt(14)   = D.pt(3) ;
            D.gam(14)  = D.gam(3) ;
            D.cp(14)   = D.cp(3) ;
            D.prat(16) = 1.0 ;
            D.pt(16)   = D.pt(6) ;
            D.trat(16) = 1.0 ;
            D.tt(16)   = D.tt(6) ;
            D.gam(16)  = D.gam(6) ;
            D.cp(16)   = D.cp(6) ;
        end
        
        if(D.entype == 2)                         %{ turbofan }%
            D.dela = .2 ;                           %{iterate to get t5t4 }%
            D.trat(6) = 1.0 ;
            D.t5t4n = .5 ;
            D.itcount = 0 ;
            while(abs(D.dela) > .001 && D.itcount < 20)
                D.itcount = D.itcount;
                D.delan = a4p/a4 - sqrt(t5t4n)*...
                    pow((1.0-(1.0/D.eta(6))*(1.0-D.t5t4n)), ...
                            -D.gam(5)/(D.gam(5)-1.0)) ;
                D.deriv = (D.delan-D.dela)/(D.t5t4n-D.trat(6)) ;
                D.dela = D.delan ;
                D.trat(6) = D.t5t4n ;
                D.t5t4n = D.trat(6) - D.dela/D.deriv ;
            end
            D.tt(6) = D.tt(5) * D.trat(6) ;
            D.gam(6) = getGama(D.tt(6),D.gamopt) ;
            D.cp(6)  = getCp(D.tt(6),D.gamopt);
            D.deltht = D.tt(6) - D.tt(5) ;
            D.delhht  = D.cp(5) * D.deltht ;
            D.prat(6) = pow((1.0-(1.0/D.eta(6))*(1.0-D.trat(6))), D.gam(5)/(D.gam(5)-1.0)) ;
            %{iterate to get t15t14 }%
            D.dela = .2 ;
            D.trat(16) = 1.0 ;
            D.t5t4n = .5 ;
            D.itcount = 0 ;
            while(abs(D.dela) > .001 && D.itcount < 20)
                D.itcount =D.itcount + 1;
                D.delan = D.a8d/D.a4p - sqrt(D.t5t4n)* ...
                         pow((1.0-(1.0/D.eta(6))*(1.0-D.t5t4n)),-D.gam(6)/(D.gam(6)-1.0)) ;
                D.deriv = (D.delan-D.dela)/(D.t5t4n-D.trat(16)) ;
                D.dela = D.delan ;
                D.trat(16) = D.t5t4n ;
                D.t5t4n = D.trat(16) - D.dela/D.deriv ;
            end
            D.tt(16) = D.tt(6) * D.trat(16) ;
            D.gam(16) = getGama(D.tt(16),D.gamopt) ;
            D.cp(16)  = getCp(D.tt(16),D.gamopt);
            D.deltlt = D.tt(16) - D.tt(6) ;
            D.delhlt = D.cp(6) * D.deltlt ;
            D.prat(16) = pow((1.0-(1.0/D.eta(6))*(1.0-D.trat(16))), D.gam(6)/(D.gam(6)-1.0)) ;
            D.byprat =  D.afan / D.acore - 1.0  ;
            D.delhf = D.delhlt / (1.0 + D.byprat) ;              %{fan work }%
            D.deltf =  - D.delhf / D.cp(3) ;
            D.tt(14) = D.tt(3) + D.deltf ;
            D.gam(14) = getGama(D.tt(14),D.gamopt) ;
            D.cp(14)  = getCp(D.tt(14),D.gamopt);
            D.trat(14) = D.tt(14)/D.tt(3) ;
            D.prat(14) = pow((1.0+D.eta(14)*(D.trat(14)-1.0)), D.gam(3)/(D.gam(3)-1.0)) ;
            D.delhc = D.delhht  ;                         %{compressor work }%
            D.deltc = -D.delhc / D.cp(14) ;
            D.tt(4) = D.tt(14) + D.deltc ;
            D.gam(4) = getGama(D.tt(4),D.gamopt) ;
            D.cp(4)  = getCp(D.tt(4),D.gamopt);
            D.trat(4) = D.tt(4)/D.tt(14) ;
            D.prat(4) = pow((1.0+D.eta(4)*(D.trat(4)-1.0)),D.gam(14)/(D.gam(14)-1.0)) ;
            D.trat(5) = D.tt(5)/D.tt(4) ;
            D.pt(14)  = D.pt(3)  * D.prat(14) ;
            D.pt(4)   = D.pt(14) * D.prat(4) ;
            D.pt(5)   = D.pt(4)  * D.prat(5) ;
            D.pt(6)   = D.pt(5)  * D.prat(6) ;
            D.pt(16)  = D.pt(6)  * D.prat(16) ;
        end
        
        if (D.entype == 3)         %{ramjet }%
            D.prat(4) = 1.0 ;
            D.pt(4) = D.pt(3) * D.prat(4) ;
            D.tt(4) = D.tt(3) ;
            D.trat(4) = 1.0 ;
            D.gam(4) = getGama(D.tt(4),D.gamopt) ;
            D.cp(4)  = getCp(D.tt(4),D.gamopt);
            D.tt(5) = D.tt4 * D.throtl/100.0  ;
            D.trat(5) = D.tt(5) / D.tt(4) ;
            D.pt(5) = D.pt(4) * D.prat(5) ;
            D.tt(6) = D.tt(5) ;
            D.gam(6) = getGama(D.tt(6),D.gamopt) ;
            D.cp(6)  = getCp(D.tt(6),D.gamopt);
            D.trat(6) = 1.0 ;
            D.prat(6) = 1.0 ;
            D.pt(6) = D.pt(5) ;
            %{fan conditions }%
            D.prat(14) = 1.0 ;
            D.trat(14) = 1.0 ;
            D.tt(14)   = D.tt(3) ;
            D.pt(14)   = D.pt(3) ;
            D.gam(14)  = D.gam(3) ;
            D.cp(14)   = D.cp(3) ;
            D.prat(16) = 1.0 ;
            D.pt(16)   = D.pt(6) ;
            D.trat(16) = 1.0 ;
            D.tt(16)   = D.tt(6) ;
            D.gam(16)  = D.gam(6) ;
            D.cp(16)   = D.cp(6) ;
        end
        
        if (D.abflag == 1)
            D.tt(8) = D.tt7 ;
        end
    end
    
    D.prat(7) = 1.0;
    D.pt(7) = D.pt(16);
    D.trat(7) = 1.0 ;
    D.tt(7) = D.tt(16) ;
    D.gam(7) = getGama(D.tt(7),D.gamopt) ;
    D.cp(7)  = getCp(D.tt(7),D.gamopt);
    if (D.abflag > 0)                    %{afterburner }%
        D.trat(8) = D.tt(8) / D.tt(7) ;
        D.m5 = getMach(0,getAir(1.0,D.gam(6))*D.a4/D.acore,D.gam(6)) ;
        D.prat(8) = getRayleighLoss(D.m5,D.trat(8),D.tt(7),D) ;
    end
    D.tt(8) = D.tt(7) * D.trat(8) ;
    D.pt(8) = D.pt(7) * D.prat(8) ;
    D.gam(8) = getGama(D.tt(8),D.gamopt) ;
    D.cp(8)  = getCp(D.tt(8),D.gamopt);
    %{engine press ratio EPR}%
    D.epr = D.prat(8)*D.prat(16)*D.prat(6)*D.prat(5)*D.prat(4)*D.prat(14);
    %{engine temp ratio ETR }%
    D.etr = D.trat(8)*D.trat(16)*D.trat(6)*D.trat(5)*D.trat(4)*D.trat(14);
    
    %this.packVariables;
    this.DATA = D;
end