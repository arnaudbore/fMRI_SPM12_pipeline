function o_matlabbatch = p_smooth(i_files, i_kernel)
% 
% function o_matlabbatch = p_smooth(i_files)
% 
%   i_files:    [string] files to smooth
% 
%   o_matlabbatch:  [struc] SPM output structure 
% 
%   abore: 5 octobre 2015
%       - creation of p_smooth

o_matlabbatch = [];

o_matlabbatch{end+1}.spm.spatial.smooth.data = i_files;
o_matlabbatch{end}.spm.spatial.smooth.fwhm = i_kernel;
o_matlabbatch{end}.spm.spatial.smooth.dtype = 0;
o_matlabbatch{end}.spm.spatial.smooth.im = 0;
o_matlabbatch{end}.spm.spatial.smooth.prefix = 's';
