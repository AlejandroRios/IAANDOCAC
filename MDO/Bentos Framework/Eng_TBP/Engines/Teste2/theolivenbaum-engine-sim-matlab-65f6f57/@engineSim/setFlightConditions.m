function setFlightConditions(this) %flight conditions
    %this.readVariables;
    D = this.DATA;

    v1 = this.INPUTS.TAS;
    v2 = this.INPUTS.altitude;
    v3 = this.INPUTS.throttle;
    v4 = this.INPUTS.gamma;
    v5 = this.INPUTS.Mach;
    v6 = this.INPUTS.pressure;
    v7 = this.INPUTS.temperature;
    
    if (D.lunits <= 1)
        % Airspeed
        if (D.inptype == 0 || D.inptype == 2)
            D.u0d = v1 ;
            vmn1 = D.u0min;
            vmx1 = D.u0max ;
            if(v1 < vmn1)
                D.u0d = vmn1;
                v1 = vmn1 ;
                fl1 =  v1 ;
                %f1.setText(String.valueOf(fl1)) ;
            end
            if(v1 > vmx1)
                D.u0d = vmx1 ; 
                v1 = vmx1 ;
                fl1 =  v1 ;
                %f1.setText(String.valueOf(fl1)) ;
            end
        end
        % Mach
        if (D.inptype == 1 || D.inptype == 3)
            D.fsmach = v5 ;
            if (D.fsmach < 0.0)
                D.fsmach = 0.0 ;
                v5 = 0.0 ;
                fl1 =  v5 ;
                %o1.setText(String.valueOf(fl1)) ;
            end
            if (D.fsmach > 2.25 && D.entype <=2)
                D.fsmach = 2.25 ;
                v5 = 2.25 ;
                fl1 =  v5 ;
                %o1.setText(String.valueOf(fl1)) ;
            end
            if (D.fsmach > 6.75 && D.entype ==3)
                D.fsmach = 6.75 ;
                v5 = 6.75 ;
                fl1 =  v5 ;
                %o1.setText(String.valueOf(fl1)) ;
            end
        end
        % Altitude
        if (D.inptype <= 1)
            D.altd = v2 ;
            vmn2 = D.altmin;
            vmx2 = D.altmax ;
            if(v2 < vmn2)
                D.altd =  vmn2 ;
                v2 =  vmn2 ;
                fl1 =  v2 ;
                %f2.setText(String.valueOf(fl1)) ;
            end
            if(v2 > vmx2)
                D.altd = vmx2 ;
                v2 =  vmx2 ;
                fl1 =  v2 ;
                %f2.setText(String.valueOf(fl1)) ;
            end
        end
        % Pres and Temp
        if (D.inptype >= 2)
            D.altd = 0.0 ;
            v2 = 0.0 ;
            fl1 =  v2 ;
            %f2.setText(String.valueOf(fl1)) ;
            D.ps0 = v6 ;
            if (v6 <= 0.0)
                D.ps0 = 0.0 ;
                v6 = 0.0 ;
                fl1 =  v6 ;
                %o2.setText(String.valueOf(fl1)) ;
            end
            if (v6 >= D.pmax)
                D.ps0 = D.pmax ;
                v6 = D.pmax ;
                fl1 =  v6 ;
                %o2.setText(String.valueOf(fl1)) ;
            end
            D.ps0 = D.ps0 / D.pconv ;
            D.ts0 = v7 + D.tref ;
            if (D.ts0 <= D.tmin)
                D.ts0 = D.tmin ;
                v7 = D.ts0 - D.tref ;
                fl1 =  v7 ;
                %o3.setText(String.valueOf(fl1)) ;
            end
            if (D.ts0 >= D.tmax)
                D.ts0 = D.tmax ;
                v7 = D.ts0 - D.tref ;
                fl1 =  v7 ;
                %o3.setText(String.valueOf(fl1)) ;
            end
            D.ts0 = D.ts0 / D.tconv ;
        end
        % Throttle
        D.throtl = v3 ;
        vmn3 = D.thrmin;  vmx3 = D.thrmax ;
        if(v3 < vmn3)
            D.throtl = vmn3 ;
            v3 =  vmn3 ;
            fl1 =  v3 ;
            %f3.setText(String.valueOf(fl1)) ;
        end
        if(v3 > vmx3)
            D.throtl = vmx3 ;
            v3 = vmx3 ;
            fl1 =  v3 ;
            %f3.setText(String.valueOf(fl1)) ;
        end
    end
    if (D.lunits == 2)
        % Airspeed
        vmn1 = -10.0;   vmx1 = 10.0 ;
        if(v1 < vmn1)
            v1 = vmn1 ;
            fl1 =  v1 ;
            %f1.setText(String.valueOf(fl1)) ;
        end
        if(v1 > vmx1)
            v1 = vmx1 ;
            fl1 =  v1 ;
            %f1.setText(String.valueOf(fl1)) ;
        end
        D.u0d = v1 * D.u0ref/100. + D.u0ref ;
        % Altitude
        vmn2 = -10.0;  vmx2 = 10.0 ;
        if(v2 < vmn2)
            v2 =  vmn2 ;
            fl1 =  v2 ;
            %f2.setText(String.valueOf(fl1)) ;
        end
        if(v2 > vmx2)
            v2 =  vmx2 ;
            fl1 =  v2 ;
            %f2.setText(String.valueOf(fl1)) ;
        end
        D.altd = v2 * D.altref/100. + D.altref ;
        % Throttle
        vmn3 = -10.0;  vmx3 = 10.0 ;
        if(v3 < vmn3)
            v3 =  vmn3 ;
            fl1 =  v3 ;
            %f3.setText(String.valueOf(fl1)) ;
        end
        if(v3 > vmx3)
            v3 = vmx3 ;
            fl1 =  v3 ;
            %f3.setText(String.valueOf(fl1)) ;
        end
        D.throtl = v3 * D.thrref/100. + D.thrref ;
    end
    % Gamma
    D.gama = v4 ;
    if(v4 < 1.0)
        D.gama =  1.0 ;
        v4 =  1.0 ;
        fl1 =  v4 ;
        %f4.setText(String.valueOf(fl1)) ;
    end
    if(v4 > 2.0)
        D.gama = 2.0 ;
        v4 = 2.0 ;
        fl1 =  v4 ;
        %f4.setText(String.valueOf(fl1)) ;
    end
    %this.packVariables;

    this.DATA = D;
    
    this.compute() ;
   
    this.INPUTS.TAS         = v1;
    this.INPUTS.altitude    = v2;
    this.INPUTS.throttle    = v3;
    this.INPUTS.gamma       = v4;
    this.INPUTS.Mach        = v5;
    this.INPUTS.pressure    = v6;
    this.INPUTS.temperature = v7;
    
    
end