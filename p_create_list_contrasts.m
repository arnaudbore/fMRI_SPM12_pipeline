function [o_con_matrix, o_con_name, o_cond_name, answer] = p_create_list_contrasts(i_spm_files)
% 
%   function o_con_list = p_create_list_contrasts(i_spm_files)
% 
%   i_spm_files: [cell] list of spm files
% 
%   o_con_list: [cell] list of contrasts choosen 
% 
%   abore: 1 octobre 2015
%       - creation of p_create_list_contrasts
% 
%   abore: 18 janvier 2016
%       - Bug fix SPM.Sess(nSess).U instead of SPM.Sess(nSess).U.name
% 
o_cond_list = {};
for nSPM=1:length(i_spm_files)
    load(i_spm_files{nSPM});
    for nSess=1:length(SPM.Sess)
        for nCond=1:length(SPM.Sess(nSess).U)
            tmp_cond_name = strcat('Sn(', num2str(nSess), {') '}, SPM.Sess(nSess).U(nCond).name);
             if isempty(find(cellfun(@(x) strcmp(x,tmp_cond_name), o_cond_list), 1))
                 o_cond_list{end+1} = tmp_cond_name;
             end
        end
    end
end

contrasts_list = create_contrasts(o_cond_list);

% Get contrats name
o_con_name={};
for i=1:size(contrasts_list,2)
    o_con_name{end+1} = contrasts_list{2,i};
end


% Get condition name
o_cond_name = {};
for i=1:length(o_cond_list)
    o_cond_name{end+1} = o_cond_list{1,i}{1,1};
end

o_con_matrix = p_convert_contrasts2matrix(contrasts_list,o_cond_name);

answer = p_create_png_from_matrix(o_con_matrix , o_con_name, o_cond_name);


