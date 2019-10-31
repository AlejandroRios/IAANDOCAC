function airfoil=xfoil_xfez(xfoil_sim_data,plot_mode)

%This function creates the batch file with comands used by Xfoil to create
%the drag polars of each surface section.
%It is recomended to use the same surface used as input and output. The
%function will refresh the .airf.pol_source information.
%
%INPUTS
%xfoil_sim_data
%   .name: string containing the airfoil file name, without extension.
%       NOTE: the extension of the coordinates file must be .dat, and it must
%       be stored in the same directory of the program. It is also possible to
%       use a 4-5 digits NACA airfoil without the coordinates file, just use
%       'NACA_XXXXX' where XXXXX represents the airfoil numbers.
%   .Re: Reynolds number (use .Re=[] for inviscid flow)
%   .Mach: Mach number (use .Mach=[] for incompressible flow)
%   .N: Number of panel nodes (integer)
%   .P: Panel bunching parameter
%   .T: TE/LE panel density ratio (decimal)
%   .R: Refined area/LE panel density ratio (decimal)
%   .XT: Top side refined area x/c limits (decimal) (vector(2))
%   .XB: Bottom side refined area x/c limits (decimal )(vector(2))
%   .iter: Maximum number of iteration allowed
%   .min_alpha: First alpha value of the interval [rad]
%   .max_alpha: Last alpha value of the interval [rad]
%   .step_alpha: Steps between the alpha values of the interval [rad]
%   .delete_source: if different from zero, the source file will be erased
%       after the data is retrieved
%   .turn_bijective: in order to use interpolation, the Clxalpha curve must be
%       bijective (for one alpha, there's only one Cl and for one Cl, there's only
%       one alpha). if turn_bijective is different from zero, all values before
%       Clmin and beyond Clmax will be erased.
%   NOTE: To use default simulation parameters, use "[]" for the
%   corresponding field
%plot_mode: logical. 1 allows plotting. 0 cancels plotting
%time2check: MATLAB will perform checks to verify if Xfoil has crashed in
%                        intervals of 'time2check' seconds. Use [] or 0 to
%                        avoid this monitoring.
%checks2kill: If Xfoil hasn't terminated after 'checks2kill' checks, MATLAB
%                       will kill it. Use [] or 0 to avoid this monitoring.

%Starting clock
tic

%Preparing batch file
output_file_name=xfoil_preparing(xfoil_sim_data);

%Executing Xfoil
%executing_xfoil(time2check,checks2kill)
%
[~,~] = system('xfoil < xfoil_batch.bat');

%Reading outputs
airfoil=xfoil_reading(xfoil_sim_data,output_file_name);

%Stopping clock
time=toc;

%Ending Log
ending(airfoil,output_file_name,time,plot_mode,xfoil_sim_data.id)

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function ending(airfoil,output_file_name,time,plot_mode,id)

for set_id = 1:length(airfoil)
    
    %Selecting current data
    curr_polar = airfoil(set_id).results;
    curr_xfoil_sim_data = airfoil(set_id).xfoil_sim_data;
    
    %Opening Log
    fprintf('=======================\nxfoil_read\n');
    if ischar(curr_polar) %Check convergenge
        fprintf('Xfoil analysis for %s did not converge\n',airfoil(set_id).name);
        fprintf('=======================\n');
    else
        fprintf('Xfoil output file %s read in %g seconds\n',output_file_name{set_id},time);
        if curr_xfoil_sim_data.turn_bijective
            fprintf('Cl x alpha curve became a bijective relationship\n');
        end
        if curr_xfoil_sim_data.delete_source
            fprintf('The source file was erased\n');
        end
        fprintf('=======================\n');
        
        if plot_mode == 1
            [coordinates,~]=xfoil_get_airfoil_coord(sprintf('%s.dat',airfoil(set_id).name));
            figure('Name', ...
                sprintf('%s Re=%g M=%g',airfoil(set_id).name,curr_polar.Reynolds,curr_polar.Mach), ...
                'Color',[176/255 197/255 234/255]);
            subplot(2,2,1);
            fill(coordinates(:,1),coordinates(:,2),'r')
            %plot(coordinates(:,1),coordinates(:,2),'Linewidth',2); xlabel('x/c'); ylabel('y/c'); grid; axis equal;
            axis equal
            xlabel('x/c')
            ylabel('y/c')
            subplot(2,2,3);
            plot(curr_polar.alpha*180/pi,curr_polar.cl,'Linewidth',2); xlabel('\alpha (^o)'); ylabel('c_l'); grid;
            subplot(2,2,4);
            plot(curr_polar.cd,curr_polar.cl,'Linewidth',2); xlabel('c_d'); ylabel('c_l'); grid;
            subplot(2,2,2);
            plot(curr_polar.cl,curr_polar.cm,'Linewidth',2); xlabel('c_l'); ylabel('c_m (0.25c)'); grid;
        end
     %nameplot=['airfoil' num2str(id) '.jpg'];
     h =gcf;
%     print(h, '-djpeg','-r300', nameplot)
     close(h)
    end
    
end
%
delete(output_file_name{1})
delete('xfoil_batch.bat')
end

%%%%%%%%%%%%%%%%%%%%%%%

% function executing_xfoil(time2check,checks2kill)
% 
% %This function is responsible to kill crashed Xfoil programs
% 
% if isempty(time2check) || isempty(checks2kill) || time2check == 0 || checks2kill == 0
%     
%     %Just run Xfoil
%     [~,~] = system('xfoil < xfoil_batch.bat');
%     
% else
%     
%     %Verify prior xfoil tasks
%     [~,b] = system('tasklist');
%     index_before = strfind(b,'xfoil');
%     
%     %Running xfoil independently
%     [~,~] = system('xfoil < xfoil_batch.bat &');
%     
%     %Verify new tasks list
%     [~,b] = system('tasklist');
%     index_later = strfind(b,'xfoil');
%     
%     %Verify which indicator corresponds to the current xfoil task
%     index_current = index_later(~logical(ismember(index_later,index_before)));
%     
%     %Get the current process ID
%     current_PID = sscanf(b(index_current:index_current+40),'%*s %g');
%     
%     %Iteration to monitor the process
%     xfoil_is_running = 1;
%     check = 0;
%     while xfoil_is_running
%         %Checked one more time
%         check = check + 1;
%         %Wait for xfoil to process
%         pause(time2check);
%         %Verify if it is time to kill the process
%         if check == checks2kill
%             eval(sprintf('!taskkill -F /PID %g',current_PID));
%         end
%         %Verify if xfoil is still running
%         [~,b] = system('tasklist');
%         index_later = strfind(b,'xfoil');
%         xfoil_is_running = ismember(index_current,index_later);
%     end
%     
%     %Kill the remaining window
%     !taskkill /IM cmd.exe
%     
% end
% 
% end

%%%%%%%%%%%%%%%%%%%%%%%
%%% Ney Rafael Sêcco
%%% Techonological Institute of Aeronatuics - Brazil
%%% Aeronautical Engineering
%%% Aircraft Design Department
%%% ney@ita.br
%%% 29 June 2012
%%%%%%%%%%%%%%%%%%%%%%%