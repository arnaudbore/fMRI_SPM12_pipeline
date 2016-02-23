spm_jobman('initcfg');

data.subjects   =   {'07MG', ...
                '08MP', ...
                '09SH', ...
                '15MG', ...
                '16VA', ...
                '34IC', ...
                '53DB', ...
                '57SH', ...
                '60AL', ...
                '76SP', ...
                '80BK', ...
                '81MP', ...
                '155GE', ...
                    };
                
data.condition = {'ctrl', ...
                  'msl'};

data.modulation = {'retest', ...
                  'training'};


data.onsets = {'onsets'};

data.ffx = {'ffx_temp'};

data.onset_folder = {'/media/Data/Projets/sleep_msl_eeg/analyse/onsets/'};

% % % % % % % % % % % % % % % % 
%   Create design FFX
for nSub =1%:length(data.subjects)
    
    o_matlabbatch = [];
    onset_structure = {};
    
    o_folder = fullfile('analyse', data.subjects{nSub},data.ffx{1},filesep);
    if ~exist(o_folder,'dir')
        mkdir(o_folder)    
    end
    
    for nCond=1:length(data.condition)
        for nMod=1:length(data.modulation)
            onset_file = p_get_files(data.onset_folder,[data.subjects{nSub} '.mat'],['onsets_' data.condition{nCond} '_' data.modulation{nMod}]);
            onset_file = load(onset_file{1,1});
            onset_structure = p_create_structure_regressors([data.condition{nCond} '-' data.modulation{nMod}],onset_file.onsets,onset_file.durations);
            onset_modulation = p_create_structure_regressors('performance',onset_file.performance);
            
            epi_folder = fullfile('analyse', ...
                            data.subjects{nSub}, ...
                            data.condition{nCond}, ...
                            data.modulation{nMod}, ...
                            filesep);
        
            epi = p_get_files(epi_folder,'nii','swrur_');
            
            o_matlabbatch = p_create_design(o_folder, epi, {}, {}, 2.16,  ...
                            onset_structure, {}, {}, {}, o_matlabbatch);
        end
    end
    spm_jobman('run',o_matlabbatch);
    
%     spm_file = p_get_files(o_folder,'.mat');
%     p_review_design(spm_file, o_folder, data.subjects{nSub});
end

% 
% tmp = 1;
% 
% estimation of the design
% o_matlabbatch = [];
% for nSub =1%:length(data.subjects)
%     o_folder = fullfile('analyse', data.subjects{nSub},data.ffx{1},filesep);
%     spm_file = p_get_files(o_folder,'.mat');
%     o_matlabbatch = p_estimate_design(spm_file,o_matlabbatch);
% end
% spm_jobman('run',o_matlabbatch);
% % 
% tmp = 1;
% 
% % Get all spm files
% spm_files = [];
% for nSub =1%:length(data.subjects)
%     o_folder = fullfile('analyse', data.subjects{nSub},data.ffx{1},filesep);
%     spm_files{end+1} = p_get_files(o_folder,'.mat');
% end
% 
% tmp = 1;
% % 
% % create list of contrasts
% [o_con_matrix, o_con_name, o_cond_name, answer] = p_create_list_contrasts(spm_files);
% 
% o_matlabbatch = [];
% if answer % Check if contrasts were correct
%     for nSub =1:length(data.subjects)
%         o_folder = fullfile('analyse', data.subjects{nSub},data.ffx{1},filesep);
%         spm_file = p_get_files(o_folder,'.mat');
%         o_matlabbatch = p_set_con(spm_file, o_con_matrix, o_con_name, o_cond_name, o_matlabbatch);
%     end
%     spm_jobman('run',o_matlabbatch);
% end


