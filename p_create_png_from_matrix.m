function o_answer = p_create_png_from_matrix(i_contrasts_matrix, i_con_name, i_cond_name)
% 
%   function answer = p_create_png_from_matrix(i_contrasts_matrix, ...
%                                                 i_con_name, i_cond_name)
% 
% 
%   i_contrasts_matrix: []
%   i_con_name: []
%   
% 
% 
o_answer = false;
mat = i_contrasts_matrix;
imagesc(mat);            %# Create a colored plot of the matrix values
% colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
                         %#   black and lower values are white)

midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range

numColors = 3;
colormap(gray(numColors))  


i_con_name = strrep(i_con_name,'_','\_');
i_con_name = strrep(i_con_name,'^','\^');
i_cond_name = strrep(i_cond_name,'_','\_');
i_cond_name = strrep(i_cond_name,'^','\^');

ScrSize = get(0,'ScreenSize');
set(gcf,'Units','pixels','Position',ScrSize);

set(gca,'YTick',1:1:length(i_con_name),...%# Change the axes tick marks
        'YTickLabel',i_con_name,...       %#   and tick labels
        'XTick',1:1:length(i_cond_name),...
        'XTickLabel',i_cond_name,...
        'TickLength',[0 0]);
    
colorbar('YTick',linspace(-1,1,numColors+1));


contrasts_to_compute_png_name = inputdlg('A PNG with all contrast to compute will be saved.\nGive it a name (without extension):');
if ~isempty(contrasts_to_compute_png_name)
    saveas(gcf,[char(contrasts_to_compute_png_name) '.png'],'png');
    disp(['A contrast file has been saved in your main directory : ' char(contrasts_to_compute_png_name) '.png'])
end

qstring = 'Do you want to compute these contrasts ?';
options.Default = 'No';
options.Interpreter = 'tex';
choice = questdlg(qstring,'Boundary Condition','Yes','No',options);
switch choice
	case 'Yes'
        o_answer = true;
    case 'No'
end

close(gcf)