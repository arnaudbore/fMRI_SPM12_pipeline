function o_matlabbatch = p_normalise2mni(i_template, i_flowfield, i_files2normalise, fwhm)
% 
%   function o_matlabbatch = normalise2mni(i_template, i_flowfield, i_files2normalise)
% 
%   i_template: [string]
%   i_flowfield:    [string]
%   i_files2normalise:  [string]
%   i_fwhm: [array] smoothing
%   o_matlabbatch: [array]
% 
%   abore: 17 Septembre 2015
%       - creation of normalise2mni
%   abore: 15 Decembre 2015
%       - @TODO mettre tous les flowfield et tous les anats

o_matlabbatch = [];

o_matlabbatch{end+1}.spm.tools.dartel.mni_norm.template = cellstr(i_template);
o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subjs.flowfields = cellstr(i_flowfield);
o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subjs.images = i_files2normalise;
% o_matlabbatch{end}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
%                                                NaN NaN NaN];
o_matlabbatch{end}.spm.tools.dartel.mni_norm.vox = [1 1 1];
o_matlabbatch{end}.spm.tools.dartel.mni_norm.preserve = 0;
o_matlabbatch{end}.spm.tools.dartel.mni_norm.fwhm = fwhm;
