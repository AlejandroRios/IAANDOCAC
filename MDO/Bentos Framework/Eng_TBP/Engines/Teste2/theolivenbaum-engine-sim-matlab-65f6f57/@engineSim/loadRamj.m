function loadRamj(this)
    this.readVariables;
    
    entype = 3 ;
    athsched = 1  ;
    aexsched = 1 ;
    arthd = .4 ;
    arexitd = 3.0 ;
    abflag = 0 ;
    fueltype = 0;
    fhvd = 18600. ;
    fhv = 18600. ;
    tt(4) = 4000. ;
    tt4 = 4000. ;
    tt4d = 4000. ;
    t4max = 4500. ;
    tt(7) = 4000. ;
    tt7 = 4000. ;
    tt7d = 4000. ;
    prat(3) = 1.0 ;
    p3p2d = 1.0 ;
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
    prat(4) = 1.0 ;
    eta(3) = 1.0 ;
    eta(4) = .982 ;
    eta(5) = 1.0 ;
    eta(7) = 1.0 ;
    eta(13) = 1.0 ;
    a8 = a8d = 2.00 ;
    a8max = 15. ;
    a8rat = 4.0 ;
    a7 = .50 ;
    
    u0max = 4500. ;
    u0d = 2200.0 ;
    altd = 10000.0 ;
    arsched = 0 ;
    
    wtflag = 0; weight = 976.;
    minlt = 2; dinlt = 293.;  tinlt = 1500.;
    mfan = 2;  dfan = 293.;   tfan = 1500.;
    mcomp = 2; dcomp = 293.; tcomp = 1500.;
    mburner = 7; dburner = 515.; tburner = 4500.;
    mturbin = 4; dturbin = 515.; tturbin = 2500.;
    mnozr = 5; dnozr = 515.2 ; tnozr = 4500. ;
    ncflag = 0; ntflag = 0;
    
    
    this.packVariables;
    this.compute;
    this.DATA.lunits = 1; %Switch to metric
    this.setUnits;
    this.compute;
end