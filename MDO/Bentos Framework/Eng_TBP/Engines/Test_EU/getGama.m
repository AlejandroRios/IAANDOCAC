function number = getGama(temp, opt)
    % Utility to get gamma as a function of temp
    a =  -7.6942651e-13;
    b =  1.3764661e-08;
    c =  -7.8185709e-05;
    d =  1.436914;
    if(opt == 0)
        number = 1.4 ;
        
    else
        number = a*temp*temp*temp + b*temp*temp + c*temp +d ;
    end
end
        