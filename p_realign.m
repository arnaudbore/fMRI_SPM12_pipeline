function o_matlabbatch = p_realign(i_folder, bk)
%
%   o_matlabbatch = realign(i_folder, i_matlabbatch)
%
%   i_folder:      [string]  Folder where to find files to realign
%   bk:            [boolean] Do you want to backup your file before
%   o_matlabbatch: [array]   SPM structure output  
% 
%   abore: 10 septembre 2015
%       - creation realign_4d
%   abore: 11 septembre 2015
%       - rename to realign
%       - add: extension, dependancy or not to previous SPM module
%   abore: 14 septembre 2015
%       - add backup option
%       - add dependancy btw modules
%   abore: 22 septembre 2015
%       - add nargin condition
%       @TODO: bk need to be rewritten

if nargin < 2 bk=false; end;

o_matlabbatch = [];

files = p_get_files(i_folder, 'nii'); % Get 4D file

if bk
    o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(files);
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.copyto = cellstr(i_folder);
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.patrep.pattern = 'f';
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.patrep.repl = 'raw_f';
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.unique = false;
end

if size(files,1)>1 % Multiple files
    o_matlabbatch{end+1}.spm.spatial.realign.estwrite.data = {cellstr(files)};
else % One 4D file
    o_matlabbatch{end+1}.spm.util.exp_frames.files = cellstr(files);
    o_matlabbatch{end}.spm.util.exp_frames.frames = Inf;
    dependancy = length(o_matlabbatch); % dependancy for next module
    o_matlabbatch{end+1}.spm.spatial.realign.estwrite.data{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}), substruct('.','files'));
end
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.sep = 4;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.interp = 2;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.weight = '';
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.which = [2 1];
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.interp = 4;
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.mask = 1;
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.prefix = 'r_';

