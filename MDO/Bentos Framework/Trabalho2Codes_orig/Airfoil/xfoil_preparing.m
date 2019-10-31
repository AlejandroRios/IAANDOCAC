function output_file_name=xfoil_preparing(xfoil_sim_data)

%WRITING THE BATCH FILE

file_id=fopen('xfoil_batch.bat','w');%Starting batch file
% fprintf(file_id,'plop\ng\n\n');%Figures won't show up
output_file_name = cell(1,length(xfoil_sim_data));%Initializing variable

for set_id = 1:length(xfoil_sim_data)   
    %General simulation parameters
    airfoil_name=xfoil_sim_data(set_id).airfoil_name;
    Re=xfoil_sim_data(set_id).Re;
    Mach=xfoil_sim_data(set_id).Mach;
    N=xfoil_sim_data(set_id).N; %Number of panel nodes (integer)
    P=xfoil_sim_data(set_id).P; %Panel bunching parameter
    T=xfoil_sim_data(set_id).T; %TE/LE panel density ratio (decimal)
    R=xfoil_sim_data(set_id).R; %Refined area/LE panel density ratio (decimal)
    XT=xfoil_sim_data(set_id).XT; %Top side refined area x/c limits (decimal) (vector(2))
    XB=xfoil_sim_data(set_id).XB; %Bottom side refined area x/c limits (decimal )(vector(2))
    iter=xfoil_sim_data(set_id).iter;
    min_alpha=xfoil_sim_data(set_id).min_alpha;
    max_alpha=xfoil_sim_data(set_id).max_alpha;
    step_alpha=xfoil_sim_data(set_id).step_alpha;
    
% Loading airfoil
    if length(airfoil_name)>=9 && strcmp(airfoil_name(1:4),'NACA')
        naca_number=airfoil_name(6:end);
        fprintf(file_id,'naca %s\n',naca_number);
        if ~exist(sprintf('NACA_%s.dat\n',naca_number),'file') %&& plot_mode
            fprintf(file_id,'save\nNACA_%s.dat\n',naca_number); %Save airfoil coordinates for plotting
        end
    else
        fprintf(file_id,'load %s.dat\n',airfoil_name);
    end
    
% Setting general simulation parameters
    fprintf(file_id,'ppar\n');
    if ~isempty(N)
        fprintf(file_id,'N\n%g\n',N);
    end
    if ~isempty(P)
        fprintf(file_id,'P\n%g\n',P);
    end
    if ~isempty(T)
        fprintf(file_id,'T\n%g\n',T);
    end
    if ~isempty(R)
        fprintf(file_id,'R\n%g\n',R);
    end
    if ~isempty(XT)
        fprintf(file_id,'XT\n%g\n%g\n',XT(1),XT(2));
    end
    if ~isempty(XB)
        fprintf(file_id,'XB\n%g\n%g\n',XB(1),XB(2));
    end
    fprintf(file_id,'\n\n');
    
    fprintf(file_id,'oper\n');
    if ~isempty(iter)
        fprintf(file_id,'iter\n%g\n',iter);
    end
    
% Setting viscous simulation parameters
    if ~isempty(Re)
        fprintf(file_id,'visc\n');
        fprintf(file_id,'Re\n%g\n',Re);
        fprintf(file_id,'vpar\n');
        fprintf(file_id,'xtr\n');
        fprintf(file_id,'%g\n',0.05); % flow transition on upper side
        fprintf(file_id,'%g\n\n',1.00); % flow transition on lower side
    end
    %Setting compressibility simulation parameters
    if ~isempty(Mach)
        fprintf(file_id,'M\n%g\n',Mach);
    end
    
    %Creating output_id (name of results file)
    output_file_name{set_id}=sprintf('XFOIL_set%g.out',xfoil_sim_data.id);
    
    %Verifying if the name was already used
    if exist(output_file_name{set_id},'file')
        delete(output_file_name{set_id});
    end
    
    %Polar accumulation
    fprintf(file_id,'pacc\n');
    fprintf(file_id,'%s\n\n',output_file_name{set_id});
    fprintf(file_id,'aseq\n%g\n%g\n%g\n',min_alpha*180/pi,max_alpha*180/pi,step_alpha*180/pi);
    fprintf(file_id,'pacc\n');
    
    %Returning to default parameters
    fprintf(file_id,'iter\n%g\n',10);
    fprintf(file_id,'M\n%g\n',0);
    fprintf(file_id,'Re\n%g\n',0);
    if ~isempty(Re)
        fprintf(file_id,'visc\n\n'); %Returned to main menu, ready for another!!!
    else
        fprintf(file_id,'\n');
    end
    
end

fprintf(file_id,'quit\n');
fclose(file_id);

end