%clear; clc; 

root = 'F:\Seph\research paper\Fig 1'; 
f1 = figure; 
hold on; 
%load('F:\Seph\code\supporting_functions\trackingcode\CMAP_blue_grey_yellow.mat');

%load('F:\Seph\data\data_210127 - Trial 4 Rac\cropped\16\edge vel mapping_6\Protrusion and FRET Values.mat');

%ax1=subplot(1,2,1);imagesc(protvalsWindowF,[-13,13]);title(' (i) Edge Velocity');
imagesc(protvalsWindowF,[-13,13]);title('Edge Velocity');
colormap(f1,cmap);
%xline(29,'--k','LineWidth',2); 

xticks([0 24 48 71 95 120 144]); 
xticklabels({'0','10','20','30', '40','50', '60'}); 
yticks([50 100 150])
yticklabels({'50','100','150'}); 

% ax =gca; 
% ax.FontSize =10; 
% %ax.FontWeight= 'bold'; 
% ax.TitleFontSizeMultiplier = 1.5;

axis ij; 

ylim([0 180]); 
xlim([0 130])
 set(f1, 'Renderer', 'painters');

%saveas(f1,strcat(root,'\','E_i.svg'))

f2=figure; 
% ax2=subplot(1,2,2);
 imagesc(fretvalsF,[0.7 1.3]);title('Raichu-Rac');
% xline(29,'--k','LineWidth',2); 
 xticks([0 24 48 71, 95 120 144 ])
xticklabels({'0','10','20','30','40','50', '60'}); 

yticks([50 100 150])
yticklabels({'50','100','150'}); 


% ax =gca; 
% ax.FontSize =10; 
% %ax.FontWeight= 'bold'; 
% ax.TitleFontSizeMultiplier = 1.5;


axis ij; 

ylim([0 180]); 
xlim([0 130])

 set(f2, 'Renderer', 'painters');
% set(gca,'YColor', 'none'); 


%saveas(f2,strcat(root,'\','E_ii.svg'))

 
%  load('F:\Seph\data\data_200116 - Trial 3 Rho, Myosin\cropped\cell_5\edge vel mapping\Protrusion and FRET Values.mat');
% 
%  ax3=subplot(2,2,3);imagesc(protvalsWindowF,[-13,13]);title(' (ii) Edge Velocity');
% colormap(ax3,cmap);
% xline(16,'--k','LineWidth',2); 
% xticks([0 24 48 71 95 120])
% xticklabels({'0','10','20','30','40','50'}); 
% 
% 
%  ax4=subplot(2,2,4);imagesc(fretvalsF,[0.7 1.3] );title('(ii) RhoA FRET');
%  xline(16,'--k','LineWidth',2); 
%  
% xticks([0 24 48 71 95 120])
% xticklabels({'0','10','20','30','40','50'}); 
% 
%  