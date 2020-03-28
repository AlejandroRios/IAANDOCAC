classdef engineSim < handle
    properties (Hidden)
        DATA
        INPUTS
    end
    
    methods
        function this = engineSim
            this.DATA.numeng = 1 ;
            this.DATA.fireflag = 0 ;
            this.DATA.ncomp = 0 ;
            this.DATA.nturb = 0;
            this.DATA.gamopt  = 1; %Calculate gamma instead of fixed at 1.4
            this.DATA.inptype = 0;
            
            this.INPUTS.TAS         = 0;
            this.INPUTS.altitude    = 0;
            this.INPUTS.throttle    = 100;
            this.INPUTS.gamma       = 1.4;
            this.INPUTS.Mach        = 0;
            this.INPUTS.pressure    = 0;
            this.INPUTS.temperature = 0;

            this.setDefaults;
            this.loadCF6;
        end
        
        function ff = getFuelFlow(this) %in kg/s
            ff = this.DATA.fuelrat * this.DATA.mconv1 / 3600; %lb/hr - > kg/hr -> kg/s;
        end
        
        function ff = getNetThrust(this) %in N
            ff = this.DATA.fnlb* this.DATA.fconv; % lbf -> N;
        end        

        function ff = getGrossThrust(this) %in N
            ff = this.DATA.fglb* this.DATA.fconv; % lbf -> N;
        end        
        
        function ff = getRamDrag(this) %in N
             ff = this.DATA.drlb* this.DATA.fconv; % lbf -> N;
        end   
        
        function ff = getTSFC(this) %in kg/(s*N)
             ff = this.DATA.sfc* this.DATA.mconv1/this.DATA.fconv/3600; % lb/(hr*lbf) -> kg/(hr*N) -> kg/(s*N);
             %the same as 
             %  s.getFuelFlow/s.getNetThrust
        end 
        
        function ff = getCoreAirflow(this) %in kg/s
             ff = this.DATA.eair* this.DATA.mconv1; % lb/s-> kg/s;
        end         
        
        
        function setTAS_Altitude(this,TAS,Altitude) %TAS in m/s and Altitude in m
            this.DATA.inptype = 0;
            this.INPUTS.TAS         = TAS * 3.6;  %convert to km/h
            this.INPUTS.altitude    = Altitude;   
            this.setFlightConditions;
        end
        
        function setMach_Altitude(this,Mach,Altitude) %Altitude in m
            this.DATA.inptype = 1;
            this.INPUTS.Mach        = Mach;
            this.INPUTS.altitude    = Altitude;             
            this.setFlightConditions;
        end
        
        function setTAS_Pressure_Temperature(this,TAS,Pressure,Temperature)  %TAS in m/s, Pressure in Pa, Temperature in °C
            this.DATA.inptype = 2;
            this.INPUTS.TAS         = TAS * 3.6;    %convert to km/h
            this.INPUTS.pressure    = Pressure/1e3; %convert to kPa
            this.INPUTS.temperature = Temperature;
            this.setFlightConditions;
        end
        
        function setMach_Pressure_Temperature(this,Mach,Pressure,Temperature) %Pressure in Pa, Temperature in °C
            this.DATA.inptype = 3;
            this.INPUTS.Mach        = Mach;
            this.INPUTS.pressure    = Pressure/1e3; %convert to kPa
            this.INPUTS.temperature = Temperature;
            this.setFlightConditions;
        end        
        
        function setThrottle(this,Throttle)
            this.INPUTS.throttle = Throttle*100; % to percentage
            this.setFlightConditions;
        end
        
        function setThrottleSafe(this,Throttle)
            persistent LastInputs minThrottle 
            recalc = false;
            if ~isempty(LastInputs)
                fn = setdiff(fieldnames(this.INPUTS),'throttle');
                for i = 1:numel(fn)
                    if this.INPUTS.(fn{i}) ~= LastInputs.(fn{i})
                        recalc = true;
                        break
                    end
                end
            else
                recalc = true;
            end
            
            if recalc
                minThrottle = this.getMinThrottle;
                LastInputs = this.INPUTS;
            end
            this.setThrottle((1-minThrottle) * Throttle + minThrottle);
        end        
        
        function minThrottle = getMinThrottle(this)
            T = 1;
            origThrottle = this.INPUTS.throttle / 100;
            this.setThrottle(T);
            delta = [0.1 0.01 0.001];
            for i = 1:3
                while isreal(this.getNetThrust)
                    T = T - delta(i);
                    this.setThrottle(T);
                    if T < 0
                        minThrottle = 0;
                        return
                    end
                end
                T = T + delta(i);
                this.setThrottle(T);
            end
            minThrottle = T;
            this.setThrottle(origThrottle);
        end
        
        function minThrottle = getMinThrottle2(this)
            origThrottle = this.INPUTS.throttle / 100;
            T = this.getMinThrottle;
            this.setThrottle(T);
            delta = [0.01 0.001];
            
            if this.getRamDrag==0
                minThrottle = nan;
                return
            end
            
            for i = 1:2
                while isreal(this.getCoreAirflow)
                    fprintf('T %1.3f CAF %g \n',T,this.getCoreAirflow);
                    T = T - delta(i);
                    this.setThrottle(T);
                    if T < 0
                        minThrottle = 0;
                        return
                    end
                end
                T = T + delta(i);
                this.setThrottle(T);
            end
            minThrottle = T;
            this.setThrottle(origThrottle);
        end        
            
        
    end
    
    methods (Access = private)
        setUnits(this)
        getThermo(this)
        getFreeStream(this)
        setFlightConditions(this)
        compute(this)
        getDrawGeo(this) 
        getGeo (this)
        getPerform (this)
        setDefaults(this)
        
        function readVariables(this)
            D = this.DATA;
            p = fieldnames(D);
            for i = 1:numel(p)
                assignin('caller',p{i},D.(p{i}));
            end
        end
        function packVariables(this)
            v = evalin('caller','whos');
            np = {v.name};
            np = setdiff(np,'this');
            D = this.DATA;
            for i = 1:numel(np)
                D.(np{i}) = evalin('caller',np{i});
            end
            this.DATA = D;
        end
    end
end