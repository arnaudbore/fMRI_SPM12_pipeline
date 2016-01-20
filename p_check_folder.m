function o_state = p_check_folder(i_folder)
%
%   state = check_folder(i_folder)
%   
%   i_folder: [string]  Folder to check if exist
%   o_state:  [boolean] Return if folder exist
%
%   abore : 11 septembre 2015
%       - Creation of convert_dcm2nii
%

if ~ischar(i_folder)
   error('MyComponent:incorrectType',...
       'Input must be a string, not a %s.',class(i_folder))
elseif ~exist(i_folder,'dir')
    error('MyComponent:missingObject',...
    [i_folder , ' folder doesnt exist\n',...
    'Please provide an existing folder'])
end

o_state = exist(i_folder, 'dir');

