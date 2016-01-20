function o_matlabbatch = p_set_con(i_spm_file, i_con_matrix, ...
                                   i_con_name, i_cond_name, i_matlabbatch)
% 
%   function p_set_con(i_spm_file, i_con_matrix, i_con_name, i_cond_name)
% 
%   i_spm_file: [structure]
%   i_con_matrix: [array]
%   i_con_name: [cell]
%   i_cond_name: [cell]
%   i_matlabbatch: [struct]


if nargin<5 i_matlabbatch={};end

o_matlabbatch = i_matlabbatch;

o_matlabbatch{end+1}.spm.stats.con.spmmat = cellstr(i_spm_file);
o_matlabbatch{end}.spm.stats.con.delete = 1; % delete previous constrats

load(i_spm_file)

for nCon=1:length(i_con_name)
    C = zeros(1,size(SPM.xX.X,2));
    for nCond=1:length(i_cond_name)
        for ii=1:size(SPM.xX.X,2)
            if ~isempty(strfind(SPM.xX.name{ii},i_cond_name{nCond}))
                C(1,ii) = i_con_matrix(nCon,nCond);
            end
        end
    end
    if ~all(C == 0)
        o_matlabbatch{end}.spm.stats.con.consess{nCon}.tcon.name = i_con_name{nCon};
        o_matlabbatch{end}.spm.stats.con.consess{nCon}.tcon.convec = C;
        o_matlabbatch{end}.spm.stats.con.consess{nCon}.tcon.sessrep = 'none';
    end
end

