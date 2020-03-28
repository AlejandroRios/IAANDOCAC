function compute(this)
    
    this.DATA.numeng = 1 ;
    this.DATA.fireflag = 0 ;
    
    this.getFreeStream ();
    
    this.getThermo() ;
    
    if (this.DATA.inflag == 0)
        this.getGeo (); %determine engine size and geometry
%         this.getDrawGeo (); %determine engine size and geometry
    end
    if (this.DATA.inflag == 1)
        if (this.DATA.entype < 3)
            this.DATA.a8 = this.DATA.a8d * sqrt(this.DATA.trat(8)) / this.DATA.prat(8) ;
        end
    end
    
    this.getPerform() ;
end