function getGeo (this)
    %{determine geometric variables }%
    %this.readVariables;
    D = this.DATA;
    if (D.entype <= 2)           % turbine engines
        if (D.afan < D.acore)
            D.afan = D.acore ;
        end
        D.a8max = .75 * sqrt(D.etr) / D.epr ; %{limits compressor face  }%
        %{ mach number  to < .5   }%
        if (D.a8max > 1.0)
            D.a8max = 1.0 ;
        end
        if (D.a8rat > D.a8max)
            D.a8rat = D.a8max ;
            if (D.lunits <= 1)
                D.fl1 = filter3(D.a8rat) ;
%                 in.nozl.left.f3.setText(String.valueOf(fl1)) ;
                D.i1 = (((D.a8rat - D.a8min)/(D.a8max-D.a8min))*1000.) ;
%                 in.nozl.right.s3.setValue(i1) ;
            end
            if (D.lunits == 2)
                D.fl1 = filter3(100.*(D.a8rat - D.a8ref)/D.a8ref) ;
%                 in.nozl.left.f3.setText(String.valueOf(fl1)) ;
                D.i1 = ((((100.*(D.a8rat - D.a8ref)/D.a8ref) +10.0)/20.0)*1000.) ;
%                 in.nozl.right.s3.setValue(i1) ;
            end
        end
        %{   dumb down limit - a8 schedule }%
        if (D.arsched == 0)
            D.a8rat = D.a8max ;
            D.fl1 = filter3(D.a8rat) ;
%             in.nozl.left.f3.setText(String.valueOf(fl1)) ;
            D.i1 = (((D.a8rat - D.a8min)/(D.a8max-D.a8min))*1000.) ;
%             in.nozl.right.s3.setValue(i1) ;
        end
        D.a8 = D.a8rat * D.acore ;
        D.a8d = D.a8 * D.prat(8) / sqrt(D.trat(8)) ;
        %{assumes choked a8 and a4 }%
        D.a4 = D.a8*D.prat(6)*D.prat(16)*D.prat(8)/sqrt(D.trat(8)*D.trat(6)*D.trat(16));
        D.a4p = D.a8*D.prat(16)*D.prat(8)/sqrt(D.trat(8)*D.trat(16));
        D.acap = .9 * D.a2 ;
    end
    
    if (D.entype == 3)        % ramjets
        D.game = getGama(D.tt(5),D.gamopt) ;
        if (D.athsched == 0)    % scheduled throat area
            D.arthd = getAir(D.fsmach,D.gama) * sqrt(D.etr) / (getAir(1.0,D.game) * D.epr * D.prat(3)) ;
            if (D.arthd < D.arthmn)
                D.arthd = D.arthmn ;
            end
            if (D.arthd > D.arthmx)
                D.arthd = D.arthmx ;
            end
            D.fl1 = filter3(D.arthd) ;
%             in.nozr.left.f3.setText(String.valueOf(fl1)) ;
            D.i1 = (((D.arthd - D.arthmn)/(D.arthmx-D.arthmn))*1000.) ;
%             in.nozr.right.s3.setValue(i1) ;
        end
        if (D.aexsched == 0)   % scheduled exit area
            D.mexit = sqrt((2.0/(D.game-1.0))*((1.0+.5*(D.gama-1.0)*D.fsmach*D.fsmach) *pow((D.epr*D.prat(3)),(D.game-1.0)/D.game) - 1.0) ) ;
            D.arexitd = getAir(1.0,D.game) / getAir(D.mexit,D.game) ;
            if (D.arexitd < D.arexmn)
                D.arexitd = D.arexmn ;
            end
            if (D.arexitd > D.arexmx)
                D.arexitd = D.arexmx ;
            end
            D.fl1 = filter3(D.arexitd) ;
%             in.nozr.left.f4.setText(String.valueOf(fl1)) ;
            D.i1 = (((D.arexitd - D.arexmn)/(D.arexmx-D.arexmn))*1000.) ;
%             in.nozr.right.s4.setValue(i1) ;
        end
    end
    %this.packVariables;
    this.DATA = D;
end