function loadF100(this)
    this.readVariables;
    
    entype = 1 ;
    abflag = 1 ;
    fueltype = 0;
    fhvd = 18600. ;
    fhv = 18600. ;
    tt(4) = 2499. ;
    tt4 = 2499. ;
    tt4d = 2499. ;
    tt(7) = 3905. ;
    tt7 = 3905. ;
    tt7d = 3905. ;
    prat(3) = 20.04 ;
    p3p2d = 20.04 ;
    prat(13) = 1.745 ;
    p3fp2d = 1.745 ;
    byprat = 0.0 ;
    a2d = 6.00 ;
    a2 = 6.00 ;
    acore = 6.00 ;
    diameng = sqrt(4.0 * a2d / 3.14159) ;
    afan = acore * (1.0 + byprat) ;
    a4 = .472 ;
    a4p = 1.524 ;
    acap = .9*a2 ;
    gama = 1.4 ;
    gamopt = 1 ;
    pt2flag = 0 ;
    eta(2) = 1.0 ;
    prat(2) = 1.0 ;
    prat(4) = 1.0 ;
    eta(3) = .959 ;
    eta(4) = .984 ;
    eta(5) = .982 ;
    eta(7) = .92 ;
    eta(13) = 1.0 ;
    a8d = 1.524 ;
    a8max = .335 ;
    a8rat = .335 ;
    
    u0max = 1500. ;
    u0d = 0.0 ;
    altd = 0.0 ;
    arsched = 0 ;
    
    wtflag = 0; weight = 3875.;
    minlt = 1; dinlt = 170.;  tinlt = 900.;
    mfan = 2;  dfan = 293.;   tfan = 1500.;
    mcomp = 2; dcomp = 293.; tcomp = 1500.;
    mburner = 4; dburner = 515.; tburner = 2500.;
    mturbin = 4; dturbin = 515.; tturbin = 2500.;
    mnozl = 5; dnozl = 400.2 ; tnozl = 4100. ;
    ncflag = 0; ntflag = 0;
    
    
    this.packVariables;
    this.compute;
    this.DATA.lunits = 1; %Switch to metric
    this.setUnits;
    this.compute;
end