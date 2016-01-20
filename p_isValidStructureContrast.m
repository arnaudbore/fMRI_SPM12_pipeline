function o_answer = p_isValidStructureContrast(i_structure,i_conlist)
% 
%   i_structure: [cell]
%   i_conlist: [cell]
% 
% 
%   o_answer: [boolean]
% 
%   abore:  15 octobre 2015
%       - creation of p_isValidStructureContrast
% 
%   abore: 18 janvier 2016
%       - bug fix with multiple sessions (space in conditions name)
% 
% 
% split i_structure
% compare split_structure with i_conlist

structure = i_structure;
conlist = i_conlist;


operators = {'(',')','+','-',''};

o_answer = true;

if size(i_structure.list_contrasts,2) == size(i_structure.list_contrasts2display,2)
    for nCon=1:size(i_structure.list_contrasts,2)
        currentCon = i_structure.list_contrasts(1,nCon);
        
        disp(currentCon)
        formule_split = strsplit(char(currentCon),' ');
        
        
        % Find different sessions Sn
        sessions = strfind(formule_split,'Sn');
        for ind=length(sessions):-1:1
            if sessions{ind}
                formule_split{ind+1} = strcat(formule_split{ind},{' '},formule_split{ind+1});
                formule_split(ind) = [];
            end
        end
                
        for ind=length(formule_split):-1:1
            if ismember(formule_split{ind},operators)
                formule_split(ind) = [];
            end
        end
        
        for ind=1:length(formule_split)
            if ~ismember(formule_split{ind},i_conlist)
                errordlg([char(formule_split(ind)),' doesnt exist'], 'Wrong contrast');
                o_answer = false;
                return 
            end
        end
    end
else
    o_answer = false;
end







