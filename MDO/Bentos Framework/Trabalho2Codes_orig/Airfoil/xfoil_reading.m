function airfoil=xfoil_reading(xfoil_sim_data,output_file_name)
%
%Initializing results structure
length_data = length(xfoil_sim_data);
airfoil = struct('name',cell(1,length_data),'results',cell(1,length_data),'xfoil_sim_data',cell(1,length_data));

for set_id = 1:length(xfoil_sim_data)
    
    %Reading parameters
    delete_source=xfoil_sim_data(set_id).delete_source;
    turn_bijective=xfoil_sim_data(set_id).turn_bijective;
    
    %Opening the file
    [file_id, message]=fopen(output_file_name{set_id},'r');
    
    %Storing airfoil name
    airfoil(set_id).name = xfoil_sim_data(set_id).airfoil_name;
    
    if isempty(message)
        %Jump irrevelant lines
        for i=1:9
            line=fgetl(file_id);
        end
        
        %Store Mach and Reynolds info
        numbers_from_line = sscanf(line,'%*s %*s %g %*s %*s %g %*s %g %*s %*s %*g');
        polar.Mach = numbers_from_line(1);
        polar.Reynolds = numbers_from_line(2)*10^numbers_from_line(3);
        
        %More irrevelant lines...
        for i=1:3
            fgetl(file_id);
        end
        
        %Finding the maximum size of data arrays
        min_alpha=xfoil_sim_data(set_id).min_alpha;
        max_alpha=xfoil_sim_data(set_id).max_alpha;
        step_alpha=xfoil_sim_data(set_id).step_alpha;
        max_num=floor((max_alpha-min_alpha)/step_alpha)+1;
        
        %Start-up polar structure
        alpha=ones(1,max_num)*9999;
        cl=zeros(1,max_num);
        cd=zeros(1,max_num);
        cdp=zeros(1,max_num);
        cm=zeros(1,max_num);
        Top_Xtr=zeros(1,max_num);
        Bot_Xtr=zeros(1,max_num);
        
        sim_id=0;
        
        while ~feof(file_id)
            sim_id=sim_id+1;
            
            line=fgetl(file_id);
            data=sscanf(line,'%g %g %g %g %g %g %g');
            
            alpha(sim_id)=data(1)*pi/180;
            cl(sim_id)=data(2);
            cd(sim_id)=data(3);
            cdp(sim_id)=data(4);
            cm(sim_id)=data(5);
            Top_Xtr(sim_id)=data(6);
            Bot_Xtr(sim_id)=data(7);
        end
        
        %Shrinking excessive lines
        correct_indexes=find(alpha<9999);
        polar.alpha=alpha(correct_indexes);
        polar.cl=cl(correct_indexes);
        
        if turn_bijective
            [~,n_min]=min(polar(set_id).cl);
            [~,n_max]=max(polar(set_id).cl);
            correct_indexes=correct_indexes(n_min:n_max);
        end
        
        polar.alpha=alpha(correct_indexes);
        polar.cl=cl(correct_indexes);
        polar.cd=cd(correct_indexes);
        polar.cdp=cdp(correct_indexes);
        polar.cm=cm(correct_indexes);
        polar.Top_Xtr=Top_Xtr(correct_indexes);
        polar.Bot_Xtr=Bot_Xtr(correct_indexes);
        
        %Closing the file
        fclose(file_id);
        
        %Deleting file
        if delete_source
            delete(output_file_name{set_id});
        end
        
    else
        fprintf('Results for %s were not found!\n',xfoil_sim_data(set_id).airfoil_name);
        polar = 'No results available';
    end
    
    %Storing simulation data
    airfoil(set_id).xfoil_sim_data = xfoil_sim_data(set_id);
    
    %Storing simulation results
    airfoil(set_id).results = polar;
    
end

if delete_source
    delete('xfoil_batch.bat');
end


end