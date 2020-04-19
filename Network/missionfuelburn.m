function [FF, fracs]=missionfuelburn(varargin)
% MISSIONFUELBURN does the cumulative product of the input weight fractions
%   [FF, fracs] = MISSIONFUELBURN(W1/W0,W2/W1,W3/W2,...,Wn/Wn-1)
% 
%   MISSIONFUELBURN takes as inputs any number of mission segment weight
%   fractions. 
% 
%   Frac is a n+1 by 1 cell array with the value of Wi/W0 in each location,
%   where i is the start or end point of a mission segment.
%   
%   FF is Wfuel/W0.
%   
%   MISSIONFUELBURN is vectorized and can take an multidimensional matrix
%   as input for any or all of the mission segment weight fractions. FF and
%   the elements of frac will be this size, though if early mission segment
%   weight fractions are scalar, those early elements of frac will also be
%   scalar. 
% 
%   see also FUELFRACTIONSIZING, BREGUET, CUMPROD, PROD.
% 
%   [FF, fracs] = MISSIONFUELBURN(W1/W0,W2/W1,W3/W2,...,Wn/Wn-1)

%   Copyright 2012-2013 Sky Sartorius
%   www.mathworks.com/matlabcentral/fileexchange/authors/101715

n=length(varargin);
fracs = cell(n+1,1);
fracs{1} = 1;
for ii = 1:n
    fracs{ii+1} = fracs{ii}.*varargin{ii};
end

FF = 1-fracs{end};