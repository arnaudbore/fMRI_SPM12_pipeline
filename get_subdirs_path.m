function subdirs_path = get_subdirs_path(dir_path, ext)
% get_subdirs_path - list all subdirectories
%
% FORMAT: subdirs_path = get_subdirs_path(dir_path)
%
% FORMAT: subdirs_path = get_subdirs_path(dir_path, ext)
%
% Inputs:
%   dir_path        [string]  the path to the directory to list its 
%                             subdirecories;
%   ext             [string]  filename extention; if is given then only 
%                             directories that contain this type of files
%                             are listed
%
% Output:
%   subdirs_path    [array]   the list with full paths to all required
%                             subdirectories

% Authors:
%   ellagab : 28 janvier 2016
%       - creation of get_subdirs_path

if nargin < 2, ext = []; end

subdirs_str = genpath(dir_path);    % string with all subdirs paths separated by ';'
subdirs_path = strsplit(subdirs_str, ';');
subdirs_path = subdirs_path(:);
subdirs_path(end) = [];

% remove path to directories that don't contain the files of the required 
% type according to the ext
if ~isempty(ext)
    for i_subdir = 1: length(subdirs_path)
        if ~any(size(dir([subdirs_path{i_subdir} '/*.' ext]),1))
            subdirs_path{i_subdir} = '';
        end
    end
    subdirs_path(ismember(subdirs_path,{''})) = [];
end

end
