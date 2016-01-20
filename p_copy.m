function o_matlabbatch = p_copy(i_filename,o_dir,o_filename)
%   function p_copy(i_filename,o_dir,o_filename)
% 
%   i_filename
%   o_dir
%   o_filename
% 
%   o_matlabbatch
% 
% abore: 15 Decembre 2015
%       - creation p_copy

o_matlabbatch = [];

pattern = strsplit(i_filename,filesep);
pattern = pattern(end);

o_matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(i_filename);
o_matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.copyto = cellstr(o_dir);
o_matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.patrep.pattern = pattern{1,1}(1:end-4);
o_matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.patrep.repl = o_filename;
o_matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.unique = false;