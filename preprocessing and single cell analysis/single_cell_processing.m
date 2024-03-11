% single cell analysis before edge tracking
%% initiatialization
clear; clc; 
 root = 'D:\ARHGAP29\Random motility\GAP29 overexpression\mScarlet3-CAAX marked\03-05-24\with mCit-R707A_40X';
 
 tiffDir = ([root, filesep,'tiff_stacks']); 
 if ~exist(tiffDir)
         mkdir(tiffDir); 
     end  
 
%  cellDir = ([root, filesep, 'cropped',filesep,'siERM', num2str(cell)]); 
%      if ~exist(cellDir)
%          mkdir(cellDir); 
%      end      
     
cropdir=[root,filesep,'cropped'];
if ~exist(cropdir)
         mkdir(cropdir); 
     end  
bgpath=[root,filesep,'background'];
   
    %% crop cell files and accompanying background 
% currently configured for just FRET and CFP, add in channels as needed 

% run this section as many times as needed, just change the cell number 
% which specifies which folder to save under and filekey which specifies 
% which orginal tiff stack to draw from 
   clc; 
cell=20;
filekey = '1_1_12'; 


 cellDir = ([cropdir,filesep, num2str(cell)]); 
     if ~exist(cellDir)
         mkdir(cellDir); 
     end   
     
     
% bgcyto = ([root, filesep, 'background\AVG_bgcyto.tif']); 
bgmCit= ([root, filesep, 'background\AVG_bgmCit.tif']); 
%bgCFP = ([bgpath, filesep, 'AVG-BG-CFP.tif']); 
bgmScarlet3 = ([root, filesep, 'background\AVG_bgmScarlet3.tif']);
%bgFRET = ([bgpath, filesep, 'AVG-BG-YFP-FRET.tif']);
% bgmRuby=([root, filesep, 'background\AVG_bgmRuby.tif']);
          
 mScarlet3 = ([tiffDir,filesep, strcat(filekey,'_mScarlet3_stacked.tif')]);  
 mCit= ([tiffDir,filesep, strcat(filekey,'_mCit_stacked.tif')]); 
%   mRuby= ([tiffDir,filesep, strcat(filekey,'_mRuby_stacked.tif')]); 
%     cyto= ([tiffDir,filesep, strcat(filekey,'_cyto_stacked.tif')]); 

%FRET = ([tiffDir,filesep, strcat('230816-03-20-WT-CPD31-YFP-FRET.tif')]);  
%CFP= ([tiffDir,filesep, strcat('230816-03-20-WT-CPD31-CFP.tif')]); 

bg_mScarlet3_image = double(readTIFFstack(bgmScarlet3)); 
bg_mCit_image = double(readTIFFstack(bgmCit)); 
% bg_mRuby_image = double(readTIFFstack(bgmRuby)); 
% bg_cyto_image = double(readTIFFstack(bgcyto)); 
     
            cropSite = 0;

                     
%          FRET_stack=double(readTIFFstack(FRET));
%          
%          FRET_stack_1 = FRET_stack(:,:,1); 
%                
%          fg = figure;
%               
%          axis image;  
%              
%             
%       [stackFRET, cropArea] = serimcropold(FRET_stack,mean(FRET_stack,3));
%       
%                 
%       Stack2TIFF(stackFRET, [cellDir, filesep,'FRET.tif']);

 mScarlet3_stack=double(readTIFFstack(mScarlet3));
         
        mScarlet3_stack_1 = mScarlet3_stack(:,:,1); 
               
         fg = figure;
              
         axis image;  
             
            
      [stackmScarlet3, cropArea] = serimcropold(mScarlet3_stack,mean(mScarlet3_stack,3));
      
                
      Stack2TIFF(stackmScarlet3, [cellDir, filesep,'mScarlet3.tif']);
                    
%        stackCFP = readFileToStack(CFP); 
%        stackCFP = imcrop3(stackCFP, [cropArea(1), cropArea(2), 1,...
%        cropArea(3), cropArea(4), size(stackFRET,3)-1]);                    
%        Stack2TIFF(stackCFP, [cellDir, filesep, 'CFP.tif']);
       
       stackmCit = readFileToStack(mCit); 
       stackmCit = imcrop3(stackmCit, [cropArea(1), cropArea(2), 1,...
       cropArea(3), cropArea(4), size(stackmScarlet3,3)-1]);                    
       Stack2TIFF(stackmCit, [cellDir, filesep, 'mCit.tif']);
            
    
%                     FRET_bg_crop = imcrop(uint16(bg_FRET_image), [cropArea(1), cropArea(2), cropArea(3), cropArea(4)]); 
%                    % saveas(FRET_bg_crop, [cellDir, filesep, 'FRET_bg.tif']); 
%                     imwrite(FRET_bg_crop,[cellDir, filesep, 'FRET_bg.tif'] , "WriteMode", "overwrite", "Compression", "none");
%                     
%                      CFP_bg_crop = imcrop(uint16(bg_CFP_image), [cropArea(1), cropArea(2), cropArea(3), cropArea(4)]); 
%                  %   saveas(CFP_bg_crop, [cellDir, filesep, 'CFP_bg.tif']); 
%             imwrite(CFP_bg_crop,[cellDir, filesep, 'CFP_bg.tif'] , "WriteMode", "overwrite", "Compression", "none");
%             
              mScarlet3_bg_crop = imcrop(uint16(bg_mScarlet3_image), [cropArea(1), cropArea(2), cropArea(3), cropArea(4)]); 
                 %   saveas(CFP_bg_crop, [cellDir, filesep, 'CFP_bg.tif']); 
            imwrite(mScarlet3_bg_crop,[cellDir, filesep, 'mScarlet3_bg.tif'] , "WriteMode", "overwrite", "Compression", "none");
            
            
              mCit_bg_crop = imcrop(uint16(bg_mCit_image), [cropArea(1), cropArea(2), cropArea(3), cropArea(4)]); 
                 %   saveas(CFP_bg_crop, [cellDir, filesep, 'CFP_bg.tif']); 
            imwrite(mCit_bg_crop,[cellDir, filesep, 'mCit_bg.tif'] , "WriteMode", "overwrite", "Compression", "none");
                    
                    %close(fg);
            clear stack;
  close all; 
  
    
    
%% background alignment 
    
 for i=1:20  %par

channels={'mCit' 'mScarlet'};
 
    cellPath=strcat(num2str(i));
    cellFiles=getFilenames([cropdir,filesep,cellPath, filesep, 'drift_correct'],'.tif');
    
    %note: need to change numbers here depending on if you have an extra
    %channel like myosin- changes order of files in cropped folder
    mCit_stack=double(readTIFFstack([cropdir,filesep,cellPath,filesep,cellFiles{3}]));
    cyto_stack=double(readTIFFstack([cropdir,filesep,cellPath,filesep,cellFiles{4}]));
  
    
alignStack(:,:,2)=(cyto_stack(:,:,60)); % choose arbitrary framenumber, here 75, to generate the alignment parameters 
alignStack(:,:,1)=(CFP_stack(:,:,60));
[pX,pY,dxMat1,dyMat1]=dualviewComputeAlignmentFromGridImages(alignStack);
figure;
subplot(1,2,1); imagesc(dxMat1); colorbar
subplot(1,2,2); imagesc(dyMat1); colorbar

%parsave([cropdir,filesep,cellPath,filesep,'alignment parameters pX pY.mat'],pX,pY,dxMat1,dyMat1);
save([cropdir,filesep,cellPath,filesep,'drift_correct', filesep, 'alignment parameters pX pY.mat'],'pX','pY','dxMat1','dyMat1');


alignStack = []; 
CFP_stack= []; 
cyto_stack = []; 
dxMat1=[]; 
dyMat1 = []; 
end 



%% FRET data 

clc;
root = 'F:\231113_RhoB_ezrin_ WTvsT567_10umNOC';
cellNum=1;% for now manually select cell folder 

bleachdir=([root,filesep,'data']);
bgdir=[root,filesep,'background'];
% load([bleachdir,filesep,'bleachingcurve.mat']);
% load([bleachdir,filesep,'bleachingcurve_mRuby.mat']);
% load([bgpath, filesep, 'alignment parameters pX pY.mat']); 
% load([bleachdir,filesep,'bleachingcurve_cyto.mat']);


%% Parallel loop
% number of cells you have in a for loop 
for k=17
    rawdir=[root,filesep,'cropped', filesep, strcat( num2str(k))]; 
    %load([rawdir,filesep,'alignment parameters pX pY.mat']);
    
   datadir=[rawdir,filesep,'output'];

 if ~exist(datadir)
    mkdir(datadir);
 end
 
 %choose which one you need here 
 
 % this one has FRET/CFP configured, commented out are options for a 3rd
 % and 4th channel if you want 
%getFRETDataHCS_stacked(k,rawdir,datadir,4); 
 %getFRETDataHCS_stacked_3chan(k,rawdir,datadir,3.5, pX, pY); % FRET, CFP, mRuby
 getFRETDataHCS_stacked_4_chan(k,rawdir,datadir, 2.5); % FRET, CFP, mRuby


% choose which one you want 
%correctBleachingExp2_stacked_YFP_cyto(fitpara,datadir); %fitpara_mRuby
%correctBleachingExp2_stacked(fitpara, datadir, fitpara_mRuby); %  % does FRET, and mRuby
  %correctBleachingExp2_FRET_stacked(fitpara, datadir); %only does FRET
% correctBleachingExp2_cyto_ratio_stacked(datadir, fitpara_mRuby, fitpara_cyto); % for ezrin ratio calculations 
 
    
end
disp('done!');

%% stupid little function to let you save in a parrallel loop 
function parsave(fname, w,x,y,z)
  save(fname, 'w', 'x', 'y', 'z')
end

