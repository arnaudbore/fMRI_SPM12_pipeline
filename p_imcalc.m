function o_matlabbatch = p_imcalc(i_files, i_outputfile, i_outputdir, ...
    i_expression)
% 
%   function o_matlabbatch = p_create_mean_image(i_files, i_mask)
% 
%   i_files: [String]
%   i_outputdir:    [string]
%   i_mask: [boolean]
% 
%   o_matlabbatch:`[struct] SPM structure to run
% 
%   abore: 5 octobre 2015
%       - creation of p_imcalc
% 

if nargin<2 i_mask='';end

o_matlabbatch = [];

expression = '(';
for nFiles=1:length(i_files)
    expression = strcat(expression,['i' num2str(nFiles) '+']);
end
expression(end) = ')';

expression = strcat(expression,i_expression);

o_matlabbatch{end+1}.spm.util.imcalc.input = cellstr(i_files);
o_matlabbatch{end}.spm.util.imcalc.output = i_outputfile;
o_matlabbatch{end}.spm.util.imcalc.outdir = cellstr(i_outputdir);
o_matlabbatch{end}.spm.util.imcalc.expression = expression;
o_matlabbatch{end}.spm.util.imcalc.options.dmtx = 0;
o_matlabbatch{end}.spm.util.imcalc.options.mask = 0;
o_matlabbatch{end}.spm.util.imcalc.options.interp = 1;
o_matlabbatch{end}.spm.util.imcalc.options.dtype = 4;
