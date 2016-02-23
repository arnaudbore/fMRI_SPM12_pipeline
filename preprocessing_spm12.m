spm_jobman('initcfg');

import_data  

addpath('/media/borear/Projects/softwares/matlab_toolboxes/fMRI_SPM12_pipeline/')

convert_dcm = 1;

% % % % % % % % % % % % % % % % % 
% %   Convert T1

if convert_dcm==1
    o_matlabbatch = [];
    for nSub=1:length(data.subjects)
        for nSess=1:length(data.sess)
            o_anat_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
    
            if ~exist(o_anat_folder,'dir')
                mkdir(o_anat_folder)
            end
        
            anat_dcm_folder = fullfile(data.dcm_folder, data.subjects{nSub},data.sess{nSess},data.dcm_anat_folder,filesep);  
            o_filename = [data.subjects{nSub}, '_', data.sess{nSess} '_anat']; 

            o_matlabbatch{end+1} = p_convert_dcm2nii(anat_dcm_folder, ...
                                            o_anat_folder, ...
                                            false, ...
                                            o_filename);
        end
   end
        spm_jobman('run',o_matlabbatch);


    % % % % % % % % % % % % % % % % % 
    % %   Convert functional to 4D nifti
    o_matlabbatch = [];
    for nSub=1:length(data.subjects)
        for nSess=1:length(data.sess)
            dcm_folder = fullfile(data.dcm_folder, data.subjects{nSub},data.sess{nSess},data.dcm_bold_folders{1},filesep);
            nifti_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);

            o_filename = [data.subjects{nSub}, '_', data.sess{nSess} '_bold'];
            o_matlabbatch{end+1} = p_convert_dcm2nii(dcm_folder,nifti_folder,true,o_filename,true);
        end
    end
    spm_jobman('run',o_matlabbatch);

    % % % % % % % % % % % % % % % % % % 
    % %   Convert Phase and magnitude
    o_matlabbatch = [];
    for nSub=1:length(data.subjects)
        for nSess=1:length(data.sess)
            for nField=1:length(data.fieldmap)
                dcm_folder = fullfile(data.dcm_folder, ...
                                      data.subjects{nSub}, ...
                                      data.sess{nSess}, ...
                                      data.fieldmap{nField}, ...
                                      data.echo{1},filesep);

                 nifti_folder = fullfile(data.main_folder, ... 
                                         data.subjects{nSub}, ...
                                         data.sess{nSess},filesep);

                 o_filetype = strsplit(data.fieldmap{nField},'/');
                 o_filename = strcat(data.subjects{nSub}, ...
                                    '_', ...
                                    data.sess{nSess}, ...
                                    '_', ...
                                    o_filetype(2)');          

                 o_matlabbatch{end+1} = p_convert_dcm2nii(dcm_folder, ...
                                            nifti_folder, ...
                                            false, ...
                                            o_filename);
            end
        end
    end
    spm_jobman('run',o_matlabbatch);
end


% anat_folder = fullfile(data.main_folder, data.subjects{1},data.sess{1},filesep);
% anat = p_get_files(anat_folder,'anat.nii',data.subjects{1});
% [o_templateFileName, o_matlabbatch] = p_createTPM(data.main_folder,anat);
% spm_jobman('run',o_matlabbatch)

% % % % % % % % % % % % % % % 
% Reorient and segment T1
 
% for nSub =1:length(data.subjects) 
%    for nSess=1:length(data.sess)
%        fprintf(['AUTO-ORIENT SUBJECT ', data.subjects{nSub},'\n']);  
%        anat_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
%        anat = p_get_files(anat_folder,'anat.nii',data.subjects{nSub});
%        p_reorient(anat);
%        fprintf(['DONE AUTO-ORIENT SUBJECT ', data.subjects{nSub},'\n']);
%        matlabbatch = p_segment(anat);
%        save([anat_folder,data.subjects{nSub},'_matlabbatch_segment.mat'],'matlabbatch');
%        spm_jobman('run',matlabbatch);
%        
%        clear matlabbatch
%    end
% end



% % % % % % % % % % % % % % % % % 
% % DARTEL
% rc1s = {};
% rc2s = {};
% rc3s = {};
% for nSub=1:length(data.subjects)
%     for nSess=1:length(data.sess)
%         anat_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
%         rc1s{end+1} = p_get_files(anat_folder,'.nii','rc1');
%         rc2s{end+1} = p_get_files(anat_folder,'.nii','rc2');
%         rc3s{end+1} = p_get_files(anat_folder,'.nii','rc3');
%     end
% end
% 
% rcs = {rc1s',rc2s',rc3s'};
% matlabbatch = p_create_dartel(rcs);
% save([data.main_folder,'matlabbatch_dartel.mat'],'matlabbatch');
% spm_jobman('run',matlabbatch);

% 
% % % % % % % % % % % % % % % % % % 
% Normalise TO MNI
% o_matlabbatch = [];
% template_folder = fullfile(data.main_folder, data.subjects{1},data.sess{1},filesep);
% dartel_template = p_get_files(template_folder,'_6.nii','Template');
% anats = {};
% tempAnats = {};
% flowfields = {};
% for nSub =1:length(data.subjects)
%     for nSess=1:length(data.sess)
%         anat_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
%         flowfields{end+1,1} = p_get_files(anat_folder,'_Template.nii','u_rc1');
%         tempAnats{end+1,1} = p_get_files(anat_folder,'anat.nii',data.subjects{nSub});
%     end
% end
% 
% anats{1,1} = tempAnats;
% 
% o_matlabbatch = p_normalise2mni(dartel_template,flowfields,anats,[0 0 0],[1 1 1]);
% save([data.main_folder,'matlabbatch_anat_normalisation.mat'],'matlabbatch');
% spm_jobman('run',o_matlabbatch);
 
% % % % % % % % % % % % % % % % % % 
% Correction Distortion
% TE = [4.92 7.38];
% EES = 0.265;
% slices = 64;
% o_matlabbatch = [];
% c_matlabbatch = [];
% for nSub=1:length(data.subjects)
%     for nSess=1:length(data.sess)
%             current_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
%          
%             mag = p_get_files(current_folder,'mag.nii');
%             phase = p_get_files(current_folder,'phase.nii');        
%             epi = p_get_files(current_folder,'bold.nii',data.subjects{nSub});
%              
%             c_matlabbatch = p_copy(epi,current_folder,strcat('r_',data.subjects{nSub},'_',data.sess{nSess},'_','bold'));
%             spm_jobman('run',c_matlabbatch);
%             epi = p_get_files(current_folder,'bold.nii','r_');
%             
%             o_matlabbatch{end+1} = p_realign_and_correct_distortion(epi,mag,phase,TE,EES,slices);
%     end
% end
% save([data.main_folder,'matlabbatch_realign_and_correct_distortion.mat'],'o_matlabbatch');
% spm_jobman('run',o_matlabbatch);

% % % % % % % % % % % % % % % % % % 
% % Coregistration
% o_matlabbatch = [];
% for nSub=1:length(data.subjects)
%      for nSess=1:length(data.sess)
%          
%         current_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
%          
%         anat = p_get_files(current_folder,'anat.nii',data.subjects{nSub});
%                          
%         mean = p_get_files(current_folder,'bold.nii','meanu');
%         epi = p_get_files(current_folder,'bold.nii','u');
%            
%         o_matlabbatch{end+1} = p_coregister(anat,mean,epi);
%     end
% end
% spm_jobman('run',o_matlabbatch);


% % Normalise fMRI TO MNI
% o_matlabbatch = [];
% template_folder = fullfile(data.main_folder, data.subjects{1},data.sess{1},filesep);
% dartel_template = p_get_files(template_folder,'_6.nii','Template');
% epis = {};
% tempEpis = {};
% flowfields = {};
% for nSub =1:length(data.subjects)
%     for nSess=1:length(data.sess)
%         current_folder = fullfile(data.main_folder, data.subjects{nSub},data.sess{nSess},filesep);
%         flowfields{end+1,1} = p_get_files(current_folder,'_Template.nii','u_rc1');
%         tempEpis{end+1,1} = p_get_files(current_folder,'bold.nii','ur_');
% %         tempEpis{end+1,1} = p_get_files(current_folder,'bold.nii','rur_');
%     end
% end
% epis{1,1} = tempEpis;
% 
% o_matlabbatch = p_normalise2mni(dartel_template,flowfields,epis,[6 6 6], [2 2 2]);
% spm_jobman('run',o_matlabbatch);


