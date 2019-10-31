function executing_fpwb(time2check,checks2kill,arq_input)
% 
    %This function is responsible to kill crashed Xfoil programs
% 
comando=['fpwb ' arq_input];
 if isempty(time2check) || isempty(checks2kill) || time2check == 0 || checks2kill == 0
%     
     %Just run FPWB
     
     [~,~] = system(comando);
   
else
    
    %Verify prior fpwb tasks
    [~,b] = system('tasklist');
    index_before = strfind(b,'fpwb');
    comando1=[comando ' &'];
    %Running fpwb independently
    [~,~] = system(comando1);
    
    %Verify new tasks list
    [~,b] = system('tasklist');
    index_later = strfind(b,'fpwb');
    
    %Verify which indicator corresponds to the current fpwb task
    index_current = index_later(~logical(ismember(index_later,index_before)));
    
    %Get the current process ID
    current_PID = sscanf(b(index_current:index_current+40),'%*s %g');
    
    %Iteration to monitor the process
    fpwb_is_running = 1;
    check = 0;
    while fpwb_is_running
        %Checked one more time
        check = check + 1;
        %Wait for xfoil to process
        pause(time2check);
        %Verify if it is time to kill the process
        if check == checks2kill
            eval(sprintf('!taskkill -F /PID %g',current_PID));
        end
        %Verify if fpwb is still running
        [~,b] = system('tasklist');
        index_later = strfind(b,'fpwb');
        fpwb_is_running = ismember(index_current,index_later);
    end
    
    %Kill the remaining window
    !taskkill /IM cmd.exe
    
 end
 clear comando comando1
end % function