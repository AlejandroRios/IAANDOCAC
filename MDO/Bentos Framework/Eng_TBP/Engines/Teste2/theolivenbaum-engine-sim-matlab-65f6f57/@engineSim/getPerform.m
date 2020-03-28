function getPerform (this)       %{determine engine performance }%
    %this.readVariables;
    D = this.DATA;

    D.rg1 = 53.3 ;
    D.rg = D.cpair * (D.gama-1.0)/D.gama ;
    D.cp3 = getCp(D.tt(4),D.gamopt);                  %BTU/lbm R
    D.g0 = 32.2 ;
    D.ues = 0.0 ;
    D.game = getGama(D.tt(6),D.gamopt) ;
    D.fac1 = (D.game - 1.0)/D.game ;
    D.cpe = getCp(D.tt(6),D.gamopt) ;
    if (D.eta(8) < .8)
        D.eta(8) = .8 ;    %{protection during overwriting }%
    end
    if (D.eta(5) < .8)
        D.eta(5) = .8 ;
    end
    
    %{ specific net thrust  - thrust / (D.g0*airflow) -   lbf/lbm/sec  }%
    % turbine engine core
    if (D.entype <=2)
        %{airflow determined at choked nozzle exit }%
        D.pt(9) = D.epr*D.prat(3)*D.pt(1) ;
        D.eair = getAir(1.0,D.game) * 144.*D.a8 * D.pt(9)/14.7 / sqrt(D.etr*D.tt(1)/518.)   ;
        D.m2 = getMach(0,D.eair*sqrt(D.tt(1)/518.)/ (D.prat(3)*D.pt(1)/14.7*D.acore*144.),D.gama) ;
        D.npr = D.pt(9)/D.ps0;
        D.uexit = sqrt(2.0*D.rgas/D.fac1*D.etr*D.tt(1)*D.eta(8)*(1.0-pow(1.0/D.npr,D.fac1)));
        if (D.npr <= 1.893)
            D.pexit = D.ps0 ;
        else
            D.pexit = .52828 * D.pt(9) ;
        end
        D.fgros = (D.uexit + (D.pexit - D.ps0) * 144. *  D.a8 /D.eair) / D.g0 ;
        
    end
    
    % turbo fan -- added terms for fan flow
    if (D.entype == 2)
        D.fac1 = (D.gama - 1.0)/D.gama ;
        D.snpr = D.pt(14)/D.ps0;
        D.ues = sqrt(2.0*D.rgas/D.fac1*D.tt(14)*D.eta(8)*(1.0-pow(1.0/D.snpr,D.fac1)));
        D.m2 = getMach(0,D.eair*(1.0+D.byprat)*sqrt(D.tt(1)/518.)/(D.prat(3)*D.pt(1)/14.7*D.afan*144.),D.gama) ;
        if (D.snpr <= 1.893)
            D.pfexit = D.ps0 ;
        else
            D.pfexit = .52828 * D.pt(14) ;
        end
        D.fgros = D.fgros + (D.byprat*D.ues + (D.pfexit - D.ps0)*144. * D.byprat*D.acore / D.eair)/D.g0 ;
    end
    
    % ramjets
    if (D.entype == 3)
        %{airflow determined at nozzle throat }%
        D.eair = getAir(1.0,D.game)*144.0*D.a2*D.arthd * D.epr*D.prat(3)*D.pt(1)/14.7 /sqrt(D.etr*D.tt(1)/518.)   ;
        D.m2 = getMach(0,D.eair*sqrt(D.tt(1)/518.)/(D.prat(3)*D.pt(1)/14.7*D.acore*144.),D.gama) ;
        D.mexit = getMach(2,(getAir(1.0,D.game) / D.arexitd),D.game) ;
        D.uexit = D.mexit * sqrt(D.game * D.rgas * D.etr * D.tt(1) *D.eta(8) /(1.0 + .5 *(D.game-1.0) * D.mexit *D.mexit)) ;
        D.pexit = pow((1.0 + .5 *(D.game-1.0) * D.mexit *D.mexit),(-D.game/(D.game-1.0)))* D.epr * D.prat(3) * D.pt(1) ;
        D.fgros = (D.uexit + (D.pexit - D.ps0)*D.arexitd*D.arthd*D.a2/D.eair/144.) / D.g0 ;
    end
    
    % ram drag
    D.dram = D.u0 / D.g0 ;
    if (D.entype == 2)
        D.dram = D.dram + D.u0 * D.byprat / D.g0 ;
    end
    
    % mass flow ratio
    if (D.fsmach > .01)
        D.mfr = getAir(D.m2,D.gama)*D.prat(3)/getAir(D.fsmach,D.gama) ;
    else
        D.mfr = 5.;
    end
    
    % net thrust
    D.fnet = D.fgros - D.dram;
    if (D.entype == 3 && D.fsmach < .3)
        D.fnet = 0.0 ;
        D.fgros = 0.0 ;
    end
    
    % thrust in pounds
    D.fnlb = D.fnet * D.eair ;
    D.fglb = D.fgros * D.eair ;
    D.drlb = D.dram * D.eair ;
    
    %fuel-air ratio and D.sfc
    D.fa = (D.trat(5)-1.0)/(D.eta(5)*D.fhv/(D.cp3*D.tt(4))-D.trat(5)) + (D.trat(8)-1.0)/(D.fhv/(D.cpe*D.tt(16))-D.trat(8)) ;
    if ( D.fnet > 0.0)
        D.sfc = 3600. * D.fa /D.fnet ;
        D.flflo = D.sfc*D.fnlb ;
        D.isp = (D.fnlb/D.flflo) * 3600. ;
    else
        D.fnlb = 0.0 ;
        D.flflo = 0.0 ;
        D.sfc = 0.0 ;
        D.isp = 0.0 ;
    end
    
    % plot output
    D.tt(9) = D.tt(8) ;
    D.t8 = D.etr * D.tt(1) - D.uexit * D.uexit /(2.0*D.rgas*D.game/(D.game-1.0)) ;
    D.trat(9) = D.tt(9)/D.tt(8) ;
    D.p8p5 = D.ps0 / (D.epr * D.prat(3) *D.pt(1)) ;
    D.cp(9) = getCp(D.tt(9),D.gamopt) ;
    D.pt(9) = D.pt(8) ;
    D.prat(9) = D.pt(9)/D.pt(8) ;
    %{thermal efficiency }%
    if (D.entype == 2)
        D.eteng = (D.a0*D.a0*((1.0+D.fa)*(D.uexit*D.uexit/(D.a0*D.a0)) + D.byprat*(D.ues*D.ues/(D.a0*D.a0)) - (1.0+D.byprat)*D.fsmach*D.fsmach))/(2.0*D.g0*D.fa*D.fhv*778.16)    ;
    else
        D.eteng = (D.a0*D.a0*((1.0+D.fa)*(D.uexit*D.uexit/(D.a0*D.a0)) - D.fsmach*D.fsmach))/(2.0*D.g0*D.fa*D.fhv*778.16)    ;
    end
    
    D.s(1) = .2 ;
    D.s(2) = .2 ;
    D.v(1) = D.rg1*D.ts0/(D.ps0*144.) ;
    D.v(2) = D.rg1*D.ts0/(D.ps0*144.) ;
    for index=2:7
        %{compute entropy }%
        D.s(index+1) = D.s(index) + D.cpair*log(D.trat(index+1)) - D.rg*log(D.prat(index+1))  ;
        D.v(index+1) = D.rg1*D.tt(index+1)/(D.pt(index+1)*144.) ;
    end
    D.s(14) = D.s(3) + D.cpair*log(D.trat(14))-D.rg*log(D.prat(14));
    D.v(14) = D.rg1*D.tt(14)/(D.pt(14)*144.) ;
    D.s(16) = D.s(6) + D.cpair*log(D.trat(16))-D.rg*log(D.prat(16));
    D.v(16) = D.rg1*D.tt(16)/(D.pt(16)*144.) ;
    D.s(9)  = D.s(8) + D.cpair*log(D.t8/(D.etr*D.tt(1)))- D.rg*log(D.p8p5)  ;
    D.v(9)  = D.rg1*D.t8/(D.ps0*144.) ;
    D.cp(1) = getCp(D.tt(1),D.gamopt) ;
    
    D.fntot   = D.numeng * D.fnlb ;
    D.fuelrat = D.numeng * D.flflo ;
    % D.weight  calculation
    if (D.wtflag == 0)
        if (D.entype == 0)
            D.weight = .132 * sqrt(D.acore*D.acore*D.acore) * (D.dcomp * D.lcomp + D.dburner * D.lburn + D.dturbin * D.lturb + D.dnozl * D.lnoz);
        end
        if (D.entype == 1)
            D.weight = .100 * sqrt(D.acore*D.acore*D.acore) * (D.dcomp * D.lcomp + D.dburner * D.lburn + D.dturbin * D.lturb + D.dnozl * D.lnoz);
        end
        if (D.entype == 2)
            D.weight = .0932 * D.acore * ((1.0 + D.byprat) * D.dfan * 4.0 + D.dcomp * (D.ncomp -3) + D.dburner + D.dturbin * D.nturb + D.dburner * 2.0) * sqrt(D.acore / 6.965) ;
        end
        if (D.entype == 3)
            D.weight = .1242 * D.acore * (D.dburner + D.dnozr *6. + D.dinlt * 3.) * sqrt(D.acore / 1.753) ;
        end
    end
    % check for temp limits
    if (D.entype < 3)
        if (D.tt(3) > D.tinlt)
            D.fireflag =1 ;
        end
        if (D.tt(14) > D.tfan)
            D.fireflag =1 ;
        end
        if (D.tt(4) > D.tcomp)
            D.fireflag =1 ;
        end
        if (D.tt(5) > D.tburner)
            D.fireflag =1 ;
        end
        if (D.tt(6) > D.tturbin)
            D.fireflag =1 ;
        end
        if (D.tt(8) > D.tnozl)
            D.fireflag =1 ;
        end
    end
    if (D.entype == 3)
        if (D.tt(4) > D.tinlt)
            D.fireflag =1 ;
        end
        if (D.tt(5) > D.tburner)
            D.fireflag =1 ;
        end
        if (D.tt(8) > D.tnozr)
            D.fireflag =1 ;
        end
    end
    %this.packVariables;
    
    this.DATA = D;
end
