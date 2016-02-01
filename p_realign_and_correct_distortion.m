function o_matlabbatch = p_realign_and_correct_distortion(i_file, i_mag, i_phase, i_TE, i_EES, i_slices)
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
%   abore : 10 decembre 2015
%       - Creation of p_realignement_and_correct_distortion
%       - @TODO check type imputs
% 
%   abore : 25 janvier 2016
%       - Add comments and change default roptions.interp to 3 (see ga)
%       - Modification of roptions.which to "Only Mean" [0 1]
% 
o_matlabbatch = [];

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

% Estimate realignment
o_matlabbatch{end+1}.spm.spatial.realignunwarp.data.scans = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
o_matlabbatch{end}.spm.spatial.realignunwarp.data.pmscan = cfg_dep('Presubtracted Phase and Magnitude Data: Voxel displacement map (Subj 1, Session 1)', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','vdmfile', '{}',{1}));
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.sep = 4;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.rtm = 0;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.einterp = 2;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.weight = '';

% Reslice realignment
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.jm = 0;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.sot = [];
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.rem = 1;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.noi = 5;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';

% Option which:
% Only mean [0 1]
% All images and mean [2 1]
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];

% default spm 4 - GA=> 3
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.rinterp = 3;


o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.mask = 1;
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';