function o_matlabbatch = p_review_design(i_design, o_folder, i_subject)
%     
%   function o_matlabbatch = p_review_design(i_design)
% 
%   i_design:   [string]  
%   o_folder:   [string]
%   i_subject:  [string]
% 
%   o_matlabbatch:  [struct]
% 
%   abore: 30 septembre 2015
%       - creation of p_review_design
% 
    if nargin < 3 i_subject='';end
    
    o_matlabbatch = [];
   
    o_matlabbatch{end+1}.spm.stats.review.spmmat = cellstr(i_design);
    o_matlabbatch{end}.spm.stats.review.display.matrix = 1;
    o_matlabbatch{end}.spm.stats.review.print = 'png';

    spm_jobman('run',o_matlabbatch);
    
    % Move 
    o_matlabbatch = [];
    current_folder = [pwd, filesep];
    png_to_move = p_get_files(current_folder,'png','spm');
    o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(png_to_move);
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.moveto = cellstr(o_folder);
    if ~isempty(i_subject)
        o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.patrep = struct('pattern', {'spm'}, 'repl', {[i_subject,'_spm']});
        o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.unique = true;
    end
    
    spm_jobman('run',o_matlabbatch);
 