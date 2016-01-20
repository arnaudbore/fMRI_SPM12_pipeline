function o_matlabbatch = p_correct_distortion(i_file, i_mag, i_phase, i_TE, i_EES, i_slices)
% 
%   o_matlabbatch = correct_distortion(i_file, i_mag, i_phase)
% 
%   i_file: [string]    files to correct
%   i_mag:  [string]    magnitude
%   i_phase:  [string]    phase
%   i_TE:   [float float] short and long TE
%   i_EES:      [float]     Effective Echo Spacing
%   i_slices:      [float]     Effective Echo Spacing
% 
%   o_matlabbatch: [array]   SPM structure output  
% 
%   abore : 14 septembre 2015
%       - Creation of correct_distortion
%   abore : 24 septembre 2015
%       -   @TODO check type imputs
% 

if isempty(strfind(lower(path),'spm12')) %Check if spm12 in path
         error('MyComponent:missingPath',...
       'SPM12 is not part of your matlab path')
end

o_matlabbatch = [];

if size(i_file,1)==1
    o_matlabbatch{end+1}.spm.util.exp_frames.files = cellstr(i_file);
    o_matlabbatch{end}.spm.util.exp_frames.frames = inf;

o_matlabbatch{end+1}.spm.tools.fieldmap.presubphasemag.subj.phase = cellstr(i_phase);    % Phase image
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.magnitude = cellstr(i_mag);    % Magnitude Image
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.et = i_TE;   %[short TE long TE]
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.maskbrain = 1;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.blipdir = -1; % AP:-1  , PA:1
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.tert = i_slices * i_EES;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.epifm = 0;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.ajm = 0;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.uflags.method = 'Mark3D';
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.uflags.fwhm = 10;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.uflags.pad = 0;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.uflags.ws = 1;
template = fullfile(spm('dir'),'toolbox','FieldMap','T1.nii');
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.mflags.template = cellstr(template);
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.mflags.fwhm = 5;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.mflags.nerode = 2;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.mflags.ndilate = 4;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.mflags.thresh = 0.5;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.defaults.defaultsval.mflags.reg = 0.02;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.session.epi =  cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.matchvdm = 0;
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.sessname = 'session';
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.writeunwarped = 0; % write unwarped image
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.anat = []; % Structural T1 anat
o_matlabbatch{end}.spm.tools.fieldmap.presubphasemag.subj.matchanat = 0; % Match T1 with EPI


dependancy = length(o_matlabbatch);
o_matlabbatch{end+1}.spm.tools.fieldmap.applyvdm.data.scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.data.vdmfile(1) = cfg_dep('Presubtracted Phase and Magnitude Data: Voxel displacement map (Subj 1, Session 1)', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','vdmfile', '{}',{1}));
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.roptions.pedir = 2;
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.roptions.which = [2 1];
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.roptions.rinterp = 4;
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.roptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.roptions.mask = 1;
o_matlabbatch{end}.spm.tools.fieldmap.applyvdm.roptions.prefix = 'u';
end