function o_matlabbatch = p_run_contrast_secondlevel(i_folder, i_cov)
% function o_matlabbatch = p_run_contrast_secondlevel()
% 
%   i_folder: [string]
%   i_cov: [struc]
% 
%   o_matlabbatch: [struct]
% 
%   abore: 9 octobre 2015
%       - creation of p_run_contrast_secondlevel
% 

if nargin < 2 i_cov=[];end

o_matlabbatch = [];

% Get a list of all files and folders in this folder.
all_files = dir(i_folder);
% Get a logical vector that tells which is a directory.
dirFlags = [all_files.isdir];
% Extract only those that are directories.
subFolders = all_files(dirFlags);

for nFolder=1:length(subFolders)
    if ~strcmp(subFolders(nFolder).name,'.') && ~strcmp(subFolders(nFolder).name,'..')
        o_matlabbatch{end+1}.spm.stats.con.spmmat = cellstr(fullfile(i_folder,subFolders(nFolder).name,'SPM.mat'));
        o_matlabbatch{end}.spm.stats.con.consess{1}.tcon.name = '+T';
        o_matlabbatch{end}.spm.stats.con.consess{1}.tcon.convec = 1;
        o_matlabbatch{end}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        o_matlabbatch{end}.spm.stats.con.consess{2}.tcon.name = '-T';
        o_matlabbatch{end}.spm.stats.con.consess{2}.tcon.convec = -1;
        o_matlabbatch{end}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

        for nCov=1:length(i_cov)
            regPos = [zeros(nCov) 1];
            o_matlabbatch{end}.spm.stats.con.consess{3}.tcon.name = strcat('+',i_cov(nCov).name);
            o_matlabbatch{end}.spm.stats.con.consess{3}.tcon.convec = regPos;
            o_matlabbatch{end}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
            o_matlabbatch{end}.spm.stats.con.consess{4}.tcon.name = strcat('-',i_cov(nCov).name);
            o_matlabbatch{end}.spm.stats.con.consess{4}.tcon.convec = -regPos;
            o_matlabbatch{end}.spm.stats.con.consess{4}.tcon.sessrep = 'none';                
        end

        o_matlabbatch{end}.spm.stats.con.delete = 0;
    end
end