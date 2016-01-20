function o_matlabbatch = p_segment(i_anat, i_TPM)
% 
%   function o_matlabbatch = segment(i_anat)
% 
%   i_anat: [string]
%   o_matlabbatch: []
% 
%   abore:  17 septembre 2015
%       - creation of segment
% 

hdr = load_nifti_hdr(i_TPM);

o_matlabbatch = [];

o_matlabbatch{end+1}.spm.spatial.preproc.channel.vols = cellstr(i_anat);
o_matlabbatch{end}.spm.spatial.preproc.channel.biasreg = 0.001;
o_matlabbatch{end}.spm.spatial.preproc.channel.biasfwhm = 60;
o_matlabbatch{end}.spm.spatial.preproc.channel.write = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.tissue(1).tpm = cellstr(strcat(i_TPM,',1'));
o_matlabbatch{end}.spm.spatial.preproc.tissue(1).ngaus = 1;
o_matlabbatch{end}.spm.spatial.preproc.tissue(1).native = [1 1];
o_matlabbatch{end}.spm.spatial.preproc.tissue(1).warped = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.tissue(2).tpm = cellstr(strcat(i_TPM,',2'));
o_matlabbatch{end}.spm.spatial.preproc.tissue(2).ngaus = 1;
o_matlabbatch{end}.spm.spatial.preproc.tissue(2).native = [1 1];
o_matlabbatch{end}.spm.spatial.preproc.tissue(2).warped = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.tissue(3).tpm = cellstr(strcat(i_TPM,',3'));
o_matlabbatch{end}.spm.spatial.preproc.tissue(3).ngaus = 2;
o_matlabbatch{end}.spm.spatial.preproc.tissue(3).native = [1 1];
o_matlabbatch{end}.spm.spatial.preproc.tissue(3).warped = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.tissue(4).tpm = cellstr(strcat(i_TPM,',4'));
o_matlabbatch{end}.spm.spatial.preproc.tissue(4).ngaus = 3;
o_matlabbatch{end}.spm.spatial.preproc.tissue(4).native = [1 1];
o_matlabbatch{end}.spm.spatial.preproc.tissue(4).warped = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.tissue(5).tpm = cellstr(strcat(i_TPM,',5'));
o_matlabbatch{end}.spm.spatial.preproc.tissue(5).ngaus = 4;
o_matlabbatch{end}.spm.spatial.preproc.tissue(5).native = [1 1];
o_matlabbatch{end}.spm.spatial.preproc.tissue(5).warped = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.tissue(6).tpm = cellstr(strcat(i_TPM,',6'));
o_matlabbatch{end}.spm.spatial.preproc.tissue(6).ngaus = 2;
o_matlabbatch{end}.spm.spatial.preproc.tissue(6).native = [1 1];
o_matlabbatch{end}.spm.spatial.preproc.tissue(6).warped = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.warp.mrf = 1;
o_matlabbatch{end}.spm.spatial.preproc.warp.cleanup = 1;
o_matlabbatch{end}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
o_matlabbatch{end}.spm.spatial.preproc.warp.affreg = 'mni';
o_matlabbatch{end}.spm.spatial.preproc.warp.fwhm = 0;
o_matlabbatch{end}.spm.spatial.preproc.warp.samp = 3;
o_matlabbatch{end}.spm.spatial.preproc.warp.write = [0 0];
o_matlabbatch{end}.spm.spatial.preproc.warp.vox = hdr.pixdim(2);
