function o_matlabbatch = p_coregister(i_ref, i_source, i_2convert)
%
%   function o_matlabbatch = coregister(i_ref, i_source, i_2convert)
% 
%   i_ref:          [string]    Reference for coregistration  (steady)
%   i_source:       [string]    Source for coregistration
%   i_2coregister:  [string]    File to coregister
% 
%   abore: 17 Septembre 2015
%       - creation of coregister
% 

o_matlabbatch = [];

if size(i_2convert,1)==1
    o_matlabbatch{end+1}.spm.util.exp_frames.files = cellstr(i_2convert);
    o_matlabbatch{end}.spm.util.exp_frames.frames = inf;

    o_matlabbatch{end+1}.spm.spatial.coreg.estwrite.ref = cellstr(i_ref);
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.source = cellstr(i_source);
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.other = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 ...
    0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.roptions.interp = 4;
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.roptions.mask = 1;
    o_matlabbatch{end}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
end