  cells = 1%[1,3,4,5,6,7,9,10,11,12,13]; 

 depths = [3]; 
 
 root = 'I:\Nada\cropped';
 for i = [1 3 4 5 6 7 9 11 12 14 17 19]
    
%      if i == 7 || i == 14 || i ==20
%          continue; 
%      end 
     for j= 1:size(depths,2)
         
         
      celldir = ([root, filesep, strcat(num2str(i)),filesep, strcat('output', filesep,'edge_vels', filesep, 'edge vel mapping_', num2str(3))]);       
         
         
     getEdgeVelStats_edits(celldir,1,2.5,-2.5,25);
     
     
     end 
     
     
     
     
 end 