function loadCF6(this)
    this.readVariables;
    
    entype = 2 ;
    abflag = 0 ;
    fueltype = 0;
    fhvd = 18600. ;
    fhv = 18600. ;
    tt(5) = 2500. ;
    tt4 = 2500. ;
    tt4d = 2500. ;
    tt(8) = 2500. ;
    tt7 = 2500. ;
    tt7d = 2500. ;
    prat(4) = 21.86 ;
    p3p2d = 21.86 ;
    prat(14) = 1.745 ;
    p3fp2d = 1.745 ;
    byprat = 3.3 ;
    acore = 6.965 ;
    afan = acore * (1.0 + byprat) ;
    a2d = afan ;
    a2 = afan ;
    diameng = sqrt(4.0 * a2d / 3.14159) ;
    a4 = .290 ;
    a4p = 1.131 ;
    acap = .9*a2 ;
    gama = 1.4 ;
    gamopt = 1 ;
    pt2flag = 0 ;
    eta(3) = 1.0 ;
    prat(3) = 1.0 ;
    prat(5) = 1.0 ;
    eta(4) = .959 ;
    eta(5) = .984 ;
    eta(6) = .982 ;
    eta(8) = 1.0 ;
    eta(14) = 1.0 ;
    a8d = 2.436 ;
    a8max = .35 ;
    a8rat = .35 ;
    
    u0max = 1500. ;
    u0d = 0.0 ;
    altd = 0.0 ;
    arsched = 0 ;
    
    wtflag = 0; weight = 8229.;
    minlt = 1; dinlt = 170.;  tinlt = 900.;
    mfan = 2;  dfan = 293.;   tfan = 1500.;
    mcomp = 0; dcomp = 293.; tcomp = 1600.;
    mburner = 4; dburner = 515.; tburner = 2500.;
    mturbin = 4; dturbin = 515.; tturbin = 2500.;
    mnozl = 3; dnozl = 515.; tnozl = 2500.;
    ncflag = 0; ntflag = 0;
    
    
    this.packVariables;
    this.compute;
    this.DATA.lunits = 1; %Switch to metric
    this.setUnits;
    this.compute;
end