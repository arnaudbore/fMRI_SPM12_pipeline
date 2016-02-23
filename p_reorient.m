function p_reorient(i_file)
% 
% reorient(i_file) - automatically reorient a T1 structural image to
% the T1 template, provided by SPM. AS a result the origin of the T1
% structural image is at [0 0 0], i.e., is alighned with the MNI space.
% Should be used prior to segmentation/normalisation because successful 
% segmentation/normalisation depends on the starting orienation of the 
% image.
% 
% Input:
%   i_file      [string]    the full path to the T1 structural image to 
%                           perform the reorientation
% 
% Authors:
%   bore: 17 Septembre 2015
%       - creation of reorient
%   EllaGab: Feb. 4th, 2016
%       - Error using spm_conv_vol. What do I do with this? Solved.

if ~nargin
    [i_file, sts] =spm_select(inf,'image');
    if ~sts, return; end
end
i_file = cellstr(i_file);
vg=spm_vol(fullfile(spm('Dir'),'canonical','avg152T1.nii'));
tmp = 'temp.nii';
for i=1:numel(i_file)
    spm_smooth(i_file{i}, tmp, [12 12 12]);
    vf=spm_vol(tmp);
    [M,~] = spm_affreg(vg,vf,struct('regtype','rigid'));
    [u, ~, v]=svd(M(1:3,1:3));
    M(1:3,1:3)= u*v';
    N= nifti(i_file{i});
    N.mat=M*N.mat;
    create(N);
end

spm_unlink(tmp);

end