function o_matlabbatch = p_create_design_new(o_folder, i_file, i_nVolstart, ...
        i_nVolstop, i_TR, i_cond, i_pmod, i_reg, i_multireg, i_matlabbatch)
% 
%   function o_matlabbatch = create_design(o_folder, i_file, i_cond, ...
%                                i_pmod, i_reg, i_multireg, i_matlabbatch)
%   o_folder:       [string] Folder where to put SPM.mat
%   i_file:         [cell]    data to 
%   i_TR:           [float]   TR data acquisition
%   i_cond:         [struct]
%   i_pmod:         [struct]
%   i_reg:          [struct]
%   i_multireg:     [string]
%   i_matlabbatch:  [struct]
% 
%   o_matlabbatch:  [struct]
% 
%   abore: 24 september 2015
%       - creation of create_design
%       

if nargin < 9 i_multireg={};end
if nargin < 10 i_matlabbatch=[];end

o_matlabbatch = [];

if isempty(i_matlabbatch) % New subject
    
    if size(i_file,1)==1
        o_matlabbatch{end+1}.spm.util.exp_frames.files = cellstr(i_file);
        if isempty(i_nVolstart) && isempty(i_nVolstop)
            o_matlabbatch{end}.spm.util.exp_frames.frames = inf;
        elseif ~isempty(i_nVolstart) && ~isempty(i_nVolstop)
            o_matlabbatch{end}.spm.util.exp_frames.frames = [i_nVolstart:1:i_nVolstop];
        else
            disp('ERRRRORRRR');
        end
    end
    
    o_matlabbatch{end+1}.spm.stats.fmri_spec.dir = cellstr(o_folder);
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.units = 'scans';
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.RT = i_TR;
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.fmri_t = 16;
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
    o_matlabbatch{end}.spm.stats.fmri_spec.fact = struct('name', {}, ...
                                                         'levels', {});
    o_matlabbatch{end}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    o_matlabbatch{end}.spm.stats.fmri_spec.volt = 1;
    o_matlabbatch{end}.spm.stats.fmri_spec.global = 'None';
    o_matlabbatch{end}.spm.stats.fmri_spec.mthresh = 0.8;
    o_matlabbatch{end}.spm.stats.fmri_spec.mask = {''};
    o_matlabbatch{end}.spm.stats.fmri_spec.cvi = 'AR(1)';
    
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(1).scans = ...
    cfg_dep('Expand image frames: Expanded filename list.', ...
    substruct('.','val', '{}',{1}, '.','val', '{}',{1}, ...
    '.','val', '{}',{1}), substruct('.','files'));

    nSess = length(o_matlabbatch{end}.spm.stats.fmri_spec.sess);

else % New session / same subject
    
    current_session = length(i_matlabbatch)-1;
    for nSess=1:current_session
        o_matlabbatch{end+1} = i_matlabbatch{nSess};
    end
    
    if size(i_file,1)==1
        o_matlabbatch{end+1}.spm.util.exp_frames.files = cellstr(i_file);
        if isempty(i_nVolstart) && isempty(i_nVolstop)
            o_matlabbatch{end}.spm.util.exp_frames.frames = inf;
        elseif ~isempty(i_nVolstart) && ~isempty(i_nVolstop)
            o_matlabbatch{end}.spm.util.exp_frames.frames = [i_nVolstart:1:i_nVolstop];
        else
            disp('ERRRRORRRR');
        end
    end
    
    
    o_matlabbatch{end+1} = i_matlabbatch{end};
    
    nSess = length(o_matlabbatch{end}.spm.stats.fmri_spec.sess) + 1 ;
    
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).scans = ...
    cfg_dep('Expand image frames: Expanded filename list.', ...
    substruct('.','val', '{}',{nSess}, '.','val', '{}',{nSess}, ...
    '.','val', '{}',{nSess}), substruct('.','files'));
end

o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).multi = {''};
o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).hpf = 128;

for nCond=1:length(i_cond)  % Set Conditions
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).name = ...
        i_cond{nCond}.name;     %NAME
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).onset = ...
        i_cond{nCond}.onsets;    %ONSETS
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).duration = ...
        i_cond{nCond}.duration; %DURATION
    
   
    if ~isempty(i_pmod)
        if ~isempty(i_pmod{nCond}.name)   % Set modulation if exist
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).tmod = 0;
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).pmod.name = ...
                i_pmod{nCond}.name;     %NAME
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).pmod.param = ...
                i_pmod{nCond}.onsets;    %ONSETS
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).pmod.poly = 1;
        end
    end
end

for nReg=1:length(i_reg)    % Set regressors
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).regress(end+1).name = ...
        i_reg{nReg}.name;   %NAME
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).regress(end).val = ...
        i_reg{nReg}.onsets; %ONSETS
end

if ~isempty(i_multireg)     % Set multi regressors - movement
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).multi = ...
        cellstr(i_multireg);%MULTI REG - MOVEMENT
end

