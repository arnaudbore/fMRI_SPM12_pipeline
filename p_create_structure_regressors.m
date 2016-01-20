function o_structure = p_create_structure_regressors(i_name, i_onsets, ...
                                                   i_duration, i_structure)
% 
%   o_structure = create_structure_regressors(i_name, i_onsets, ...
%                                             i_duration, i_structure)
% 
%   i_name: [string]
%   i_onsets: [array]
%   i_duration: [array]
% 
%   o_structure:    [cell]
% 
if nargin < 3 i_duration = [];end
if nargin < 4 i_structure = {};end

o_structure = i_structure;
o_structure{end+1}.name = i_name;
o_structure{end}.onsets = i_onsets;
o_structure{end}.duration = i_duration;