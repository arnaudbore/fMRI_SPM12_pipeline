function o_contrasts_list = p_convert_contrasts2matrix( ...
                                    i_contrasts_list, i_cond_name)
% function o_contrasts_list = p_convert_contrasts2matrix( ...
%                                     i_contrasts_list, i_cond_list)
% 
% i_contrasts_list: [cell]
% i_cond_list:  [cell]
% 
% o_constrasts_list: [array]
% 
% abore: 1 octobre 2015
%   - creation of o_contrasts_list
% 

operators = {'(',')','+','-',''};

o_contrasts_list = zeros(size(i_contrasts_list,2),length(i_cond_name));

for nCon=1:size(i_contrasts_list,2)

    % Initialise variable to read formula
    currentSign = 1;
    signBeforeParenthesis = 0;
    inParenthesis = false;
    
    formule = i_contrasts_list{1,nCon};
    formule_split = strsplit(formule,' ');
    
    % Find different sessions Sn
    sessions = strfind(formule_split,'Sn');
    for ind=length(sessions):-1:1
        if sessions{ind}
            formule_split{ind+1} = strcat(formule_split{ind},{' '},formule_split{ind+1});
            formule_split(ind) = [];
        end
    end
    
    if length(formule_split)==1
        ind=find(ismember(i_cond_name,formule_split{1}));
        o_contrasts_list(nCon, ind) = 1;
    else
        for nPart=1:length(formule_split)
            ind=find(ismember(operators,formule_split{nPart}));
            if ind==1 % (
                if inParenthesis
                    disp('Wrong contrast')
                else
                    inParenthesis = true;
                end
                if nPart>1
                    if find(ismember(operators,formule_split{nPart-1}))==4 % -
                        signBeforeParenthesis = -1;
                    end
                end
            elseif ind==2 % )
                if inParenthesis
                    inParenthesis = false;
                    signBeforeParenthesis = 0;
                else
                    disp('Wrong contrast');
                end
            elseif ind==3 % +
                if ~inParenthesis 
                    currentSign = 1;
                elseif signBeforeParenthesis
                    currentSign = -1;
                end
            elseif ind==4 % -
                if ~inParenthesis 
                    currentSign = -1;
                elseif signBeforeParenthesis
                    currentSign = 1;
                else
                    currentSign = -1;
                end
            elseif ind==5
                continue    
            else
                 indCond=find(ismember(i_cond_name,formule_split{nPart}));
                 o_contrasts_list(nCon, indCond) = currentSign;
            end
        end
    end
end


