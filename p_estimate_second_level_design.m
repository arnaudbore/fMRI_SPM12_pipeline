function o_matlabbatch = p_estimate_second_level_design(i_spm, ...
                                                            i_matlabbatch)
% 
% function o_matlabbatch = p_estimate_second_level_design()
%   
%   i_spm: [String]
%   i_matlabbatch: [struct]
% 
%   o_matlabbatch: [struct]
% 
%   abore: 5 octobre 2015
%       - creation p_estimate_second_level_design
% 

o_matlabbatch = i_matlabbatch;

o_matlabbatch{end+1}.spm.stats.fmri_est.spmmat = cellstr(i_spm);
o_matlabbatch{end}.spm.stats.fmri_est.method.Classical = 1;
