function number = getRayleighLoss(mach1, ttrat, tlow, DATA)
    %{analysis for rayleigh flow }%
    g1 = getGama(tlow,DATA.gamopt);
    gm1 = g1 - 1.0 ;
    wc1 = getAir(mach1,g1);
    g2 = getGama(tlow*ttrat,DATA.gamopt);
    gm2 = g2 - 1.0 ;
    number = .95 ;
    %{iterate for mach downstream }%
    mgueso = .4 ;                 %{initial guess }%
    mach2 = .5 ;
    while (abs(mach2 - mgueso) > .0001)
        mgueso = mach2 ;
        fac1 = 1.0 + g1 * mach1 * mach1 ;
        fac2 = 1.0 + g2 * mach2 * mach2 ;
        fac3 = pow((1.0 + .5 * gm1 * mach1 * mach1),(g1/gm1)) ;
        fac4 = pow((1.0 + .5 * gm2 * mach2 * mach2),(g2/gm2)) ;
        number = fac1 * fac4 / fac2 / fac3 ;
        wc2 = wc1 * sqrt(ttrat) / number ;
        mach2 = getMach(0,wc2,g2) ;
    end
end