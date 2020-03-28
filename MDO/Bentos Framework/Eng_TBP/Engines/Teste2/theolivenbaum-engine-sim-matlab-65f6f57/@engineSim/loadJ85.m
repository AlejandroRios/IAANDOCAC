function loadJ85(this)
    this.readVariables;
    entype = 0 ;
    abflag = 0 ;
    fueltype = 0;
    fhvd = 18600. ;
    fhv = 18600. ;
    tt(4) = 2260. ;
    tt4 = 2260. ;
    tt4d = 2260. ;
    tt(7) = 4000. ;
    tt7 = 4000. ;
    tt7d = 4000. ;
    prat(3) = 8.3 ;
    p3p2d = 8.3 ;
    prat(13) = 1.0 ;
    p3fp2d = 1.0 ;
    byprat = 0.0 ;
    a2d = 1.753 ;
    a2 = 1.753 ;
    acore = 1.753 ;
    diameng = sqrt(4.0 * a2d / 3.14159) ;
    afan = acore * (1.0 + byprat) ;
    a4 = .323 ;
    a4p = .818 ;
    acap = .9*a2 ;
    gama = 1.4 ;
    gamopt = 1 ;
    pt2flag = 0 ;
    eta(2) = 1.0 ;
    prat(2) = 1.0 ;
    prat(4) = .85 ;
    eta(3) = .822 ;
    eta(4) = .982 ;
    eta(5) = .882;
    eta(7) = .97 ;
    eta(13) = 1.0 ;
    a8d = .818 ;
    a8max = .467 ;
    a8rat = .467 ;
    
    u0max = 1500. ;
    u0d = 0.0 ;
    altd = 0.0 ;
    arsched = 1 ;
    
    wtflag = 0; weight = 561.;
    minlt = 1; dinlt = 170.;  tinlt = 900.;
    mfan = 2;  dfan = 293.;   tfan = 1500.;
    mcomp = 2; dcomp = 293.; tcomp = 1500.;
    mburner = 4; dburner = 515.; tburner = 2500.;
    mturbin = 4; dturbin = 515.; tturbin = 2500.;
    mnozl = 5; dnozl = 600.; tnozl = 4100.;
    ncflag = 0; ntflag = 0;
    
    
    this.packVariables;
    this.compute;
    this.DATA.lunits = 1; %Switch to metric
    this.setUnits;
    this.compute;
end