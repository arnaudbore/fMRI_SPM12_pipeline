function o_matlabbatch = p_normalise2mni(i_template, i_flowfield, i_files2normalise, fwhm, voxSize)
% 
%   function o_matlabbatch = normalise2mni(i_template, i_flowfield, i_files2normalise)
% 
%   i_template: [string]
%   i_flowfield:    [cell]
%   i_files2normalise:  [cell]
%   i_fwhm: [array] smoothing
%   o_matlabbatch: [array]
% 
%   abore: 17 Septembre 2015
%       - creation of normalise2mni
%   abore: 15 Decembre 2015
%       - Mettre tous les flowfield et tous les anats
% 
%   abore: 22 janvier 2016
%       - Voxel size depend on input file2normalise
% 

o_matlabbatch = [];

o_matlabbatch{end+1}.spm.tools.dartel.mni_norm.template = cellstr(i_template);
o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subjs.flowfields = cellstr(i_flowfield);
o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subjs.images = i_files2normalise;
% o_matlabbatch{end}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
%                                                NaN NaN NaN];

if nargin < 5
    hdr = load_nifti_hdr(i_files2normalise{1}{1});
    voxSize = [hdr.pixdim(2), hdr.pixdim(3), hdr.pixdim(4)];
end

o_matlabbatch{end}.spm.tools.dartel.mni_norm.vox = voxSize;
o_matlabbatch{end}.spm.tools.dartel.mni_norm.preserve = 0;
o_matlabbatch{end}.spm.tools.dartel.mni_norm.fwhm = fwhm;
