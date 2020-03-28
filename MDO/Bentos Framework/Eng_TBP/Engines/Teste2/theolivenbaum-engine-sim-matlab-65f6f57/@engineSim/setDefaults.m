function setDefaults(this)
    this.readVariables;
    move = 0;
    inptype = 0 ;
    siztype = 0 ;
    lunits = 0 ;
    lconv1 = 1.0 ; lconv2 = 1.0 ;fconv  = 1.0 ;mconv1 = 1.0 ;
    pconv  = 1.0 ; econv  = 1.0 ;aconv  = 1.0 ;bconv  = 1.0 ;
    mconv2 = 1.0 ; dconv  = 1.0 ;flconv = 1.0 ;econv2 = 1.0 ;
    tconv  = 1.0 ;  tref = 459.6;
    g0 = 32.2 ;
    g0d = 32.2 ;
    
    counter = 0 ;
    showcom = 0 ;
    plttyp  = 2 ;
    pltkeep = 0 ;
    entype  = 0 ;
    inflag  = 0 ;
    varflag = 0 ;
    pt2flag = 0 ;
    wtflag  = 0 ;
    fireflag = 0 ;
    gama = 1.4 ;
    gamopt = 1 ;
    u0d = 0.0 ;
    altd = 0.0 ;
    throtl = 100. ;
    
    for i=0:19
        trat(i+1) = 1.0 ;
        tt(i+1)   = 518.6 ;
        prat(i+1) = 1.0 ;
        pt(i+1)   = 14.7 ;
        eta(i+1)  = 1.0 ;
    end
    tt(5) =2500. ;
    tt4 = 2500. ;
    tt4d = 2500. ;
    tt(8) = 2500. ;
    tt7 = 2500. ;
    tt7d = 2500. ;
    prat(4) =  8.0 ;
    p3p2d = 8.0 ;
    prat(14) = 2.0 ;
    p3fp2d = 2.0 ;
    byprat = 1.0 ;
    abflag = 0 ;
    
    fueltype = 0 ;
    fhvd = 18600. ;
    fhv = 18600. ;
    a2d = 2.0 ;
    a2 = 2.0 ;
    acore = 2.0 ;
    diameng = sqrt(4.0 * a2d / 3.14159) ;
    acap = .9*a2 ;
    a8rat = .35 ;
    a8 = .7 ;
    a8d = .40 ;
    arsched = 0 ;
    afan = 2.0 ;
    a4 = .418 ;
    
    athsched = 1 ;
    aexsched = 1 ;
    arthmn = 0.1;     arthmx = 1.5 ;
    arexmn = 1.0;     arexmx = 10.0 ;
    arthd = .4 ;
    arth = .4 ;
    arexit = 3.0 ;
    arexitd = 3.0 ;
    
    u0min  = 0.0 ;   u0max = 1500.;
    altmin = 0.0 ;   altmax = 60000. ;
    thrmin = 30;     thrmax = 100 ;
    etmin  = .5;     etmax  = 1.0 ;
    cprmin = 1.0;   cprmax = 50.0 ;
    bypmin = 0.0;   bypmax = 10.0 ;
    fprmin = 1.0;   fprmax = 2.0 ;
    t4min = 1000.0;   t4max = 3200.0 ;
    t7min = 1000.0;   t7max = 4000.0 ;
    a8min = 0.1;      a8max = 0.4 ;
    a2min = .001;       a2max = 50.;
    diamin = sqrt(4.0*a2min/3.14159);
    diamax = sqrt(4.0*a2max/3.14159);
    pmax = 20.0;  tmin = -100.0 + tref;  tmax = 100.0 + tref ;
    vmn1 = u0min ;     vmx1 = u0max ;
    vmn2 = altmin ;    vmx2 = altmax ;
    vmn3 = thrmin ;    vmx3 = thrmax ;
    vmn4 = arexmn ;    vmx4 = arexmx ;
    
    xtrans = 125.0 ;
    ytrans = 115.0 ;
    factor = 35. ;
    sldloc = 75 ;
    
    xtranp = 80.0 ;
    ytranp = 180.0 ;
    factp = 27. ;
    sldplt = 138 ;
    
    weight = 1000. ;
    minlt = 1; dinlt = 170.2 ;  tinlt = 900. ;
    mfan = 2;  dfan = 293.02 ; tfan = 1500. ;
    mcomp = 2; dcomp = 293.02 ; tcomp = 1500. ; lcomp = 1;
    mburner = 4 ; dburner  = 515.2 ; tburner = 2500. ; lburn = 1;
    mturbin = 4 ; dturbin = 515.2 ; tturbin = 2500. ; lturb = 1;
    mnozl = 3; dnozl = 515.2 ; tnozl = 2500. ; lnoz = 1;
    mnozr = 5; dnozr = 515.2 ; tnozr = 4500. ;
    ncflag = 0 ; ntflag = 0 ;
    this.packVariables;
end