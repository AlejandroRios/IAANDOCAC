function number = getMach (sub, corair, gamma)
    %{Utility to get the Mach number given the corrected airflow per area }%
    chokair = getAir(1.0, gamma) ;
    if (corair > chokair)
        number = 1.0 ;
    else
        airo = 0.25618 ;                 %{initial guess }%
        if (sub == 1)
            macho = 1.0 ;   %{sonic }%
        else
            if (sub == 2)
                macho = 1.703 ; %{supersonic }%
            else
                macho = .5;                %{subsonic }%
            end
            iter = 1 ;
            machn = macho - .2  ;
            while (abs(corair - airo) > .0001 && iter < 20)
                airn =  getAir(machn,gamma) ;
                deriv = (airn-airo)/(machn-macho) ;
                airo = airn ;
                macho = machn ;
                machn = macho + (corair - airo)/deriv ;
                iter = iter + 1 ;
            end
        end
        number = macho ;
    end
end