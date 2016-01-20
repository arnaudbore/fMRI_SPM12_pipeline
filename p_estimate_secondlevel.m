function o_matlabbatch = p_estimate_secondlevel(i_folder)
% 
% function o_matlabbatch = p_estimate_secondlevel(i_folder)
% 
%   i_folder: [String]
% 
%   o_matlabbatch: [struct]
% 
%   abore: 9 octobre 2015 
%       - creation p_estimate_secondlevel
% 
%   @TODO: remove . and .. in 
% 
o_matlabbatch = {};

% Get a list of all files and folders in this folder.
all_files = dir(i_folder);
% Get a logical vector that tells which is a directory.
dirFlags = [all_files.isdir];
% Extract only those that are directories.
subFolders = all_files(dirFlags);

for nFolder=1:length(subFolders)
    if ~strcmp(subFolders(nFolder).name,'.') && ~strcmp(subFolders(nFolder).name,'..')
        o_matlabbatch{end+1}.spm.stats.fmri_est.spmmat = ...
           cellstr(fullfile(i_folder,subFolders(nFolder).name,'SPM.mat'));
        o_matlabbatch{end}.spm.stats.fmri_est.method.Classical = 1;
    end
end