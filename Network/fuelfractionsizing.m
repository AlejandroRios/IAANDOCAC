function W0 = fuelfractionsizing(EWfunc,fixedW,FF,tol,maxW)
% FUELFRACTIONSIZING finds gross weight using fuel fraction sizing method.
% 
%   W0 = FUELFRACTIONSIZING(EWfunc, fixedW, FF, tol, maxW)
%
%   W0     - Gross weight.
%   EWfunc - Function handle where EWF = EWfunc(W0) (should be monotonic
%            decreasing for best convergence results) -OR- 1- to 3-element
%            cell array {A C K} where EWF = A*W0, A*W0^C, or (A*W0^C)*K
%            (elements of EWfunc may be arrays).
%   fixedW - Fixed weights that don't scale with aircraft gross weight, 
%            e.g. payload + crew.
%   FF     - Fuel fraction, Wfuel/W0 (usually from mission simulation using
%            Breguet range equation). If FF is a cell vector,
%            MISSIONFUELBURN(FF{:}) is used.
%   tol    - Absolute convergence tolerance on W0. Default is tol =
%            1e-5*minW, where minW = fixedW/(1-FF), a weight representing
%            an aircraft with 100% useful load.
%   maxW   - Optional upper bound in the search for gross weight. A smaller
%            value hastens convergence and a larger value increases
%            likelihood that the correct value is captured. Default is maxW
%            = 1e6*minW, in which case any returned NaNs may be interpreted
%            as "too heavy to care."
%
%   W0 will have the same units as fixedW. The provided EWfunc must be
%   designed to accept those same units.
%
%   FUELFRACTIONSIZING and associated functions are vectorized and can
%   accept arrays for most inputs - useful for conducting elegant trade
%   studies.
%
%   Example 1: Find gross weight of a light sport aircraft with 600 nmi
%   range, PSFC of .4 lb/hr/bhp, and fixed weights (pilot, passenger,
%   cargo) of 400 lbs.
%
%   Single line:
%       W0 = fuelfractionsizing({3.03 -.235}, 400, 1.06*missionfuelburn...
%         (.98,.99,breguet('Prop','Cruise',1111200,10,6.628e-07,0,.8),.99))
%
%   Verbose:
%       fixedW = 400;
%       R = 600*1852;         %convert nmi to m
%       L_over_D = 10;
%       PSFC = 0.4*1.657e-06; %convert lbm/hr/bhp to 1/m
%       eta_prop = 0.8;
% 
%       segments = {.98  %startup, runup, taxi, takeoff
%                   .99          %climb
%              breguet('Prop','Cruise', R, L_over_D, PSFC, false, eta_prop)
%                   .99};        %decent, landing, taxi, shutdown
% 
%       fuel_safety_margin = 0.06;
%       FF = (1+fuel_safety_margin)*missionfuelburn(segments{:});
% 
%       EWfunc = @(W0) 3.03*W0.^-.235;
%       W0 = fuelfractionsizing(EWfunc, fixedW, FF)
%
%   Example 2: Evaluate sensitivity of W0 to variations in historical
%   trendline parameter A.
%       A0 = 3.03; A = linspace(.8*A0,1.2*A0,30);
%       W0 = fuelfractionsizing({A -0.235}, 400, 1.06*missionfuelburn...
%        (.98,.99,breguet('Prop','Cruise',1111200,10,6.628e-07,0,.8),.99));
%       plot(A,W0); xlabel('A'); ylabel('W0 (lb)')
%
%   Example 3: Take advantage of vectorization to do a gross weight trade
%   study for the effect of range and fixed weights on gross weight,
%   ignoring aircraft that are heavier than the light sport category limit
%   of 1,320 pounds.
%       R = 1852*(300:2:1000)'; %convert nmi to m
%       fixedW = 200:2:600;
%       [R, fixedW] = meshgrid(R,fixedW);
%       W0 = fuelfractionsizing({3.03 -.235},fixedW,1.06*missionfuelburn...
%      (.98,.99,breguet('Prop','Cruise',R,10,6.628e-07,0,.8),.99),[],1320);
%       surfc(R/1852,fixedW,W0,'LineStyle','none')
%       xlabel('Range (nmi)'); ylabel('Fixed Weights (lb)')
%       zlabel('Gross Weight (lb)')
%
%   See also MISSIONFUELBURN, BREGUET, GROSSWEIGHT,
%    BISECTION - http://www.mathworks.com/matlabcentral/fileexchange/28150.
%
%   W0 = FUELFRACTIONSIZING(EWfunc,fixedW,FF,tol,maxW)

%   Copyright 2012-2013 Sky Sartorius
%   www.mathworks.com/matlabcentral/fileexchange/authors/101715

%   References to read more about fuel fraction sizing:
%       Raymer - "Aircraft Design: A Conceptual Approach"
%       Brandt - "Introduction to Aeronautics: A Design Perspective"
%       Roskam - "Airplane Design"  


if ~isa(EWfunc,'function_handle')
    switch numel(EWfunc)
        case 1 %easy closed-form solution
            W0 = fixedW./(1-FF-EWfunc{1});
            return
        case 2
            EWfunc = @(w0) EWfunc{1}.*w0.^EWfunc{2};
        case 3
            EWfunc = @(w0) EWfunc{3}.*EWfunc{1}.*w0.^EWfunc{2};
        otherwise
            error('invalid empty weight function EWfunc')
    end
end

if iscell(FF)
    FF = missionfuelburn(FF{:});
end

% minW represents an aircraft with no empty weight and 100% useful load
minW = fixedW./(1-FF);

% default maxW represents an aircraft with a terrible fixedW fraction
if (nargin < 5) || isempty(maxW)
    maxW = minW*1e6;
end    
if (nargin < 4) || isempty(tol)
    tol = 1e-5*minW;
end

f = @(W) 1 - EWfunc(W) - FF - fixedW./W;

try 
    opt.TolX = tol./(maxW-minW);
    W0 = fzero(f,[minW maxW],opt);
catch ME1
    try
        W0 = bisection(f, minW, maxW, 0, tol);
    catch ME2
        if ~strncmp(ME2.message,'Undefined function ''bisection''',30)
            rethrow(ME1);
        end
        link = 'http://www.mathworks.com/matlabcentral/fileexchange/28150';
        
        error('%s\n\n%s\n%s %s\n%s%s%s',ME2.message,...
         'BISECTION on MATLAB path required for vector problems.',...
         ['Option 1: <a href="' link '">BISECTION on MatlabCentral</a>'],...
         ['(<a href="' link '?download=true">direct download</a>).'],...
         'Option 2: Uncomment simplified <a href="matlab:opentoline(',...
         [mfilename('fullpath') '.m'],...
         ',148,0)">BISECTION in FUELFRACTIONSIZING</a>.');
    end
end
end

% Simplified BISECTION:

function x = bisection(f,LBin,UBin,~,tol)
% The BISECTION subfunction is necessary for stand-alone usage. For
% modularity use the full version from
% http://www.mathworks.com/matlabcentral/fileexchange/28150.

% ----- Check and size inputs -----
LB = LBin; UB = UBin;

if isscalar(LB) && isscalar(UB)
    jnk = f((UB+LB)/2); % test if f returns multiple outputs
    if ~isscalar(jnk)
        UB = UB*ones(size(jnk));
    end
end

if isscalar(LB) && ~isscalar(UB) %make LB array?
    LB = LB*ones(size(UB));
elseif ~isscalar(LB) && isscalar(UB) %make UB array?
    UB = UB*ones(size(LB));
end

% ----- Iterate -----
while any( (UB(:) - LB(:)) > tol(:) )
    bigger = (f((UB+LB)/2)).*f(UB) > 0;
    UB(bigger)=(UB(bigger)+LB(bigger))/2;
    LB(~bigger)=(UB(~bigger)+LB(~bigger))/2;
end
x=(LB+UB)/2;

% ----- Final check -----
ul = f(min(x+tol,UBin)); %check f(x +/- tol) bounds target
ll = f(max(x-tol,LBin));
x(((ll > 0) & (ul > 0)) | ((ll < 0) & (ul < 0)))=NaN;
end


% REVISION HISTORY
%{
V0.1
  1st version, including breguet and missionfuelburn functions
  uploaded to file exchange (with bisection included) 8 Nov 2012
V1.0
  added example using dimensioned variables
  added link to DimensionedVarible MATLAB class in breguet help
  created more options for EWfunc input to allow for constant, 2-factor,
   or 3-factor (AW^C + K)
  huge improvement in case handling in breguet
  reminder in documentation about drag polar link between speed and L/D
  reminder in documentation about INSTALLED sfc
  updated BISECTION for array EWfunc handling
  added example for array EWfunc
  uploaded to file exchange
V1.1
  fixed typo in example 2 problem statement
  added a . to missionfuelburn so it can handle array inputs
  tested convergence speed in terms of number of EWfunc evals for
   different search methods, including bisection, fzero, and conventional
   textbook iteration - the latter is the fastest vectorizable method,
   and fzero is usually the fastest for all-scalar input cases. However,
   the stability of convergence of textbook iteration leaves much to be
   desired. Bisection and FZERO are very reliable and stable. Still,
   here's some code if you want to use old-school iteration:
                    Wold = 0;
                    while any(abs(W0-Wold)>tol)
                        Wold = W0;
                        W0 = (2*fixedW./(1-FF-EWfunc(Wold))+Wold)/3;
                    end
                    %add a catch for instability
                    if ~isreal(W0)
                          ...
  since BISECTION is only used in fuelfractionsizing, it was added as a
   subfunction and the unused features were removed. it is still
   available stand-alone with more features, documentation, examples,
   etc. at http://www.mathworks.com/matlabcentral/fileexchange/28150
  uploaded to file exchange
V2.0
  changed the function fed to search method from @(W) W -
   fixedW./(1-FF-EWfunc(W)) to @(W) EWfunc(W)+FF+fixedW./W-1. This vastly
   increased the robustness of the method and makes it converge for much
   more cases
  renamed Wfixed to fixedW, Wmin to minW, etc. to try and get more
   variable names to comply with style guidelines
  added maxW as optional input
  note: try adding 
        if isscalar(minW) && isscalar(tol) && isscalar(maxW) ...
                && exist('fzero','file') && isscalar(EWfunc(minW))
            W0 = fzero(f, [minW maxW], optimset('TolX',tol/(maxW-minW)));
   in front of bisection for single case runs with very expensive EWfunc
  changed example three to utilize maxW input
  uploaded to file exchange
V2.1
  fixed premature convergence bug in iteration while line
  more testing confirmed that bisection is better than classic iteration
  uploaded 20 nov 2012
V2.2
  nov 30 2012: fixed jnk = ... line bug that sometimes might evaluate f
  outside of the bounds.
V2.3
    made bisection usage syntax consistent with full function.
    made breguet help non unit system specific
2013-03-21
    added options to do breguet range equation forwards or backwards and
    updated documentation and help accordingly
    moved example with DimensionedVariable class to BREGUET help block
    separated string inputs on BREGUET - old syntax invalid!
2013-04-07 added try catch block with error link
2013-04-19 added automatic call of missionfuelburn for cell FF input
2013-05-15
    changed if exist('bisection','file') >= 2 block to try/catch error
    handling
    uploaded new version to FEX along with missionfuelburn and new breguet
%}