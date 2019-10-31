function temps=temperature(h)
%
temps = 518.67;
%
      if  0 <= h && h < 36089 
      satheta = 1.0 - h/145442;

      elseif 36089 <= h && h < 65617
      satheta = 0.751865;
    
      elseif 65617 <= h && h < 104987
      satheta = 0.682457 + h/945374;
     
      elseif 104987 <= h && h < 154199
      satheta = 0.482561 + h/337634;
      
      elseif 154199 <= h && h < 167323
      satheta = 0.939268;

      elseif 167323 <= h && h < 232940
      satheta = 1.434843 - h/337634;
      end
% 
temps=temps*satheta;
end % function temperature