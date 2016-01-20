function o_gains = p_compute_gains_sleepeeg_msl(data, nBlocs)

%   function o_gains = p_compute_gains_sleepeeg_msl(data, nBlocs)
% 
%  
% 
% 
% 
% 


t_gains_training = zeros(1, length(data.subjects));
t_gains_retest = zeros(1, length(data.subjects));
t_gains = zeros(1, length(data.subjects));

o_gains = struct('c',[],...
                'name',[],...
                'icfi',[],...
                'icc',[]);

for nSub=1:length(data.subjects)
    onset_file = p_get_files(data.onset_folder,[data.subjects{nSub} '.mat'],'onsets_msl_training');
    i_training = load(onset_file{1,1});
    onset_file = p_get_files(data.onset_folder,[data.subjects{nSub} '.mat'],'onsets_msl_retest');
    i_retest = load(onset_file{1,1});

    t_gains_training(nSub) = (mean(i_training.performance(1,1:nBlocs)) ... 
                        - mean(i_training.performance(1,end-nBlocs:end)))/ ...
                        mean(i_training.performance(1,1:nBlocs))*100;
    
    t_gains_retest(nSub) = (mean(i_retest.performance(1,1:nBlocs)) ... 
                        - mean(i_retest.performance(1,end-nBlocs:end)))/ ...
                        mean(i_retest.performance(1,1:nBlocs))*100;

    t_gains(nSub) = (mean(i_training.performance(1,end-nBlocs:end)) ... 
                        - mean(i_retest.performance(1,1:nBlocs)))/ ...
                        mean(i_training.performance(1,end-nBlocs:end))*100;
end  

o_gains(1).name = 'Gtraining';
o_gains(1).c = t_gains_training;
o_gains(1).icfi = 1;
o_gains(1).icc = 1;

o_gains(2).name = 'Gretest';
o_gains(2).c = t_gains_retest;
o_gains(2).icfi = 1;
o_gains(2).icc = 1;

o_gains(3).name = 'GConso';
o_gains(3).c = t_gains;
o_gains(3).icfi = 1;
o_gains(3).icc = 1;