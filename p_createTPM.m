function [o_templateFileName, o_matlabbatch] = p_createTPM(i_dir, i_anat)
% 
% [o_templateFileName, o_matlabbatch] = p_createTPM(i_dir, i_anat)
% 
% i_dir:    [string]  Where to put the new TPM
% i_anat:   [string] An anatomical image to get its resolution
% 
% o_templateFileName: [string] output filename of the new TPM
% 
% COMMENTS: TPM - Tissue Probability Maps 4D image
% 
% - abore: 10 decembre 2015
%   - Creation of p_createTPM
% - abore: 11 decembre 2015
%   - Modification + add comments
% 


template = fullfile(spm('dir'),'tpm','TPM.nii');

o_matlabbatch = [];

hdr = load_nifti_hdr(i_anat);
o_templateFileName = strcat('TPM_', ...
                            num2str(hdr.pixdim(2)), ...
                            '_', ...
                            num2str(hdr.pixdim(3)), ...
                            '_', ...
                            num2str(hdr.pixdim(4)));

% Copy TPM file to i_dir
o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(template);
o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyto = cellstr(i_dir);


% Use 4D file
o_matlabbatch{end+1}.spm.util.exp_frames.files = cellstr(fullfile(i_dir,'TPM.nii'));
o_matlabbatch{end}.spm.util.exp_frames.frames = inf;

dependancy = length(o_matlabbatch);

% Normalisation of TPM.nii with itself to change voxel resolution 
% Dummy way (SPM way) to do upsampling/downsamplint
o_matlabbatch{end+1}.spm.spatial.normalise.estwrite.subj.vol = cellstr(fullfile(i_dir, 'TPM.nii,1'));
o_matlabbatch{end}.spm.spatial.normalise.estwrite.subj.resample = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.biasreg = 0.0001;
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 60;
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.tpm = cellstr(template);
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.affreg = 'mni';
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.reg = [0 0.001 0.5 0.05 0.2];
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.fwhm = 0;
o_matlabbatch{end}.spm.spatial.normalise.estwrite.eoptions.samp = 3;
o_matlabbatch{end}.spm.spatial.normalise.estwrite.woptions.bb = [-78 -112 -70
                                                             78 76 85];
o_matlabbatch{end}.spm.spatial.normalise.estwrite.woptions.vox = [hdr.pixdim(2) hdr.pixdim(3) hdr.pixdim(4)];
o_matlabbatch{end}.spm.spatial.normalise.estwrite.woptions.interp = 4;

% Rename output depending on the resolution of anat
o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(fullfile(i_dir, 'wTPM.nii'));
o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.moveto = cellstr(i_dir);
o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.patrep = struct('pattern', {'wTPM'}, 'repl', o_templateFileName);
o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.unique = false;


% Delete Field
o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(fullfile(i_dir, 'y_TPM.nii'));
o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.delete = false;
