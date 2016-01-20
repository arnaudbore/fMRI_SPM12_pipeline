function o_matlabbatch = p_convert_dcm2nii(i_folder, o_folder, convert_to_4D, ...
    o_filename, delete_3D)
%
%   convert_dcm2nii(i_folder, o_folder, convert_to_4D, o_filename, 
%                   delete_3D, i_matlabbatch)
% 
%   i_folder:       [string]  Folder where to find dicom files to convert
%                             if not exist return error
%   o_folder:       [string]  Folder where to put nifti converted files
%                             if not exist return error
%   convert_to_4D:  [boolean] Do we convert into 4D nifti 
%   o_4D_filename:  [string]  Filename of the 4D nifti
%   delete_3D:      [boolean] Do we delete 3D files (will be use if 
%                   convert_to_4D)
%   o_matlabbatch   [array]   SPM structure
%
%   abore : 11 septembre 2015
%       - Creation of convert_dcm2nii
%   abore : 14 septembre 2015
%       - check btw convert_to_4D and delete_3D (false && true)
%       - modification of the dependancy btw modules
%

    if isempty(strfind(lower(path),'spm12')) %Check if spm12 in path
         error('MyComponent:missingPath',...
       'SPM12 is not part of your matlab path')
    end
    
    if ~p_check_folder(i_folder) || ~p_check_folder(o_folder) %folder exists
        return
    end
    
    if nargin < 3 convert_to_4D = false; end
    if nargin < 4 o_filename = ''; end
    if nargin < 5 delete_3D = false; end

    if ~convert_to_4D delete_3D=false; end; % never delete 3D volumes if you 
%                                            dont create 4D volume
       
    o_matlabbatch = [];

    files = p_get_files(i_folder, 'dcm');

    %     files to convert
    o_matlabbatch{end+1}.spm.util.import.dicom.data = cellstr(files);
    o_matlabbatch{end}.spm.util.import.dicom.root = 'flat';
    o_matlabbatch{end}.spm.util.import.dicom.outdir = cellstr(o_folder);
    o_matlabbatch{end}.spm.util.import.dicom.protfilter = '.*';
    o_matlabbatch{end}.spm.util.import.dicom.convopts.format = 'nii';
    o_matlabbatch{end}.spm.util.import.dicom.convopts.icedims = 0;

    if convert_to_4D % conversion into a 4D nifti
        dependancy = length(o_matlabbatch); % dependancy for next module
        o_matlabbatch{end+1}.spm.util.cat.vols(1) = cfg_dep('DICOMsss Import: Converted Images', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}), substruct('.','files'));
        o_matlabbatch{end}.spm.util.cat.name = o_filename;
        o_matlabbatch{end}.spm.util.cat.dtype = 0;
    
    elseif ~strcmp(o_filename,'') 
        
        dependancy = length(o_matlabbatch);
        dcmInfo = dicominfo(files(1,:));
        
        if strfind(lower(dcmInfo.ProtocolName),'mprage') % If anat
            dcmInfo.InstanceNumber = size(files,1);
        end
            
        preFilename =  sprintf('%c%s-%0.4d-%0.5d-%0.6d-%0.2d', ...
            's', ...
            dcmInfo.PatientID, ...
            dcmInfo.SeriesNumber, ...
            dcmInfo.AcquisitionNumber, ...
            dcmInfo.InstanceNumber, ...
            dcmInfo.EchoNumber);

        o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cfg_dep('DICOMsss Import: Converted Images', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}), substruct('.','files'));
        o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.moveto = cellstr(o_folder);
        o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.patrep = struct('pattern', {preFilename}, 'repl', o_filename);
        o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.moveren.unique = false;
        
    end

    if delete_3D
        o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cfg_dep('DICOM Import: Converted Images', substruct('.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}, '.','val', '{}',{dependancy}), substruct('.','files'));
        o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.delete = false;
    end
end