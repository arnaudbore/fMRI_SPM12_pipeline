function o_matlabbatch = p_set_secondlevel_design(o_folder, ...
                                          i_files, i_mask, i_cov)
% 
% function o_matlabbatch = p_estimate_secondlevel_design()
% 
%   o_folders: [String]
%   i_files:   [String]
%   i_mask: [String]
%   i_cov:  [cell]
% 
%   o_matlabbatch: [structure] SPM structure to run
% 
% abore: 5 octobre 2015
%   -creation of p_create_secondlevel_design

if nargin < 4 i_cov=[];end
o_matlabbatch = {};

o_matlabbatch{end+1}.spm.stats.factorial_design.dir = cellstr(o_folder);
o_matlabbatch{end}.spm.stats.factorial_design.des.t1.scans = ...
                                                    cellstr(i_files);

for nCov=1:length(i_cov) 
    if length(i_cov) == 1
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).c = ...
                                                       i_cov.c;
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).cname = ...
                                                       i_cov.name;
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).iCFI = ...
                                                       i_cov.icfi;
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).iCC = ...
                                                       i_cov.icc;
    else
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).c = ...
                                                       i_cov(i_cov).c;
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).cname = ...
                                                       i_cov(i_cov).name;
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).iCFI = ...
                                                       i_cov(i_cov).icfi;
        o_matlabbatch{end}.spm.stats.factorial_design.cov(nCov).iCC = ...
                                                       i_cov(i_cov).icc;
    end
end

% Not supported yet
o_matlabbatch{end}.spm.stats.factorial_design.multi_cov = ...
                            struct('files', {}, 'iCFI', {}, 'iCC', {});

o_matlabbatch{end}.spm.stats.factorial_design.masking.tm.tm_none = 1;
o_matlabbatch{end}.spm.stats.factorial_design.masking.im = 1;
o_matlabbatch{end}.spm.stats.factorial_design.masking.em = cellstr(i_mask);

o_matlabbatch{end}.spm.stats.factorial_design.globalc.g_omit = 1;
o_matlabbatch{end}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
o_matlabbatch{end}.spm.stats.factorial_design.globalm.glonorm = 1;
