function o_matlabbatch = p_create_secondlevel_design(i_spm_files, o_dir, ...
                                                    i_smoothing, i_mask, i_cov)
% 
% function o_matlabbatch = p_create_secondlevel_design(i_spm_files, i_cov)
% 
%   i_spm_files: [cell]
%   i_smoothing: [boolean]
%   i_mask: [string]
%   i_cov: [cell]
% 
%   o_matlabbatch: [struct]
% 
%   abore 5 octobre 2015
%       - creation of p_create_secondlevel_design
%   

if nargin < 3 i_smoothing=false;end
if nargin < 4 i_mask='';end
if nargin < 5 i_cov=[];end

i_con_list = {};  % list of every contrasts computed from 1st level
i_con_files = {}; % list of every files
o_matlabbatch = {};

for nSPM=1:length(i_spm_files)
    load(i_spm_files{nSPM});
    for nCon=1:length(SPM.xCon)
        i_con_files{nCon,nSPM} = fullfile(SPM.swd,SPM.xCon(nCon).Vcon.fname);
        if isempty(find(cellfun(@(x) strcmp(x,SPM.xCon(nCon).name), i_con_list), 1))
            i_con_list{end+1} = SPM.xCon(nCon).name;
        end
    end
end

% Get lists of contrasts to compute
o_con_list = create_contrasts_second_level(i_con_list);

for nCon=1:size(o_con_list,2)
    Match=cellfun(@(x) strcmp(o_con_list{1,nCon}, x), i_con_list, 'UniformOutput', 0);
    tmp_index = find(cell2mat(Match));
    o_folder = fullfile(o_dir,o_con_list{2,nCon});
    if ~exist(char(o_folder),'dir')
        mkdir(char(o_folder));
    end
    i_files = i_con_files(tmp_index,:)';
    
    if i_smoothing % Get scon files instead of con
        i_files = strrep(i_files, '/con', '/scon'); 
    end
    
    o_matlabbatch{end+1} = p_set_secondlevel_design(o_folder, i_files, i_mask, i_cov);
end



