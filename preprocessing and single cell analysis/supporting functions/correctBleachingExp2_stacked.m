function correctBleachingExp2_stacked(fitpara,datadir, fitpara_mRuby)
% What it does
% Normalizes imRatio_raw for each frame by the median intensity per frame of the entire
% time series. 
% bleaching correction by division by linear bleaching function normalized
% by the median of its values. 

%remember to add in/remove 'position' tag for all the file names depending
%on if calling the stacked versions or not 

load([datadir,filesep, 'RatioData_raw.mat'],'imRatio_raw','imFRETOutline','im_mRuby_raw','immRuby_outline');
load([datadir,filesep,'Bleach_raw.mat']);
timepts=1:length(imRatio_raw);

 corr=feval(fitpara,timepts); %use this one
%corr = fitpara; 
%corr=polyval([slope 1],timepts); have never used this one 
 corr_norm=corr./median(corr); %use this one
%plot(timepts,corr_norm);

 normfact=nanmedian(bleach_raw); %use this one
%corr=polyval([slope 1],timepts);
%corr_norm=corr./median(corr);
%colorRange=[0.8 1.2];
%normalize RatioData_raw by median value

corr_m=feval(fitpara_mRuby,timepts);

corr_norm_m=corr_m./median(corr_m);
% %plot(timepts,corr_norm);
% 
%normfact_m=nanmedian(bleach_raw_mRuby);



 imRatio= cell(1,size(imRatio_raw,2));
 %RATIO_cyto = cell(1,size(imRatio_raw,2));
 im_mRuby = cell(1,size(imRatio_raw,2));
for frameNum=1:length(imRatio_raw)
   
    imRatio{frameNum}=imRatio_raw{frameNum}./(normfact*corr_norm(frameNum));
 colorRange = [0.7 1.3]; 
 
 %colorRange3 = [0.4 1.6]; 
  %  imRatio{frameNum}=tempRATIO_corr;
   % added this in to make some max intensity projections 
   %tempRATIO_corr(tempRATIO_corr <1.1) = 0; 
    tempRATIOforstack=ratio2RGB( imRatio{frameNum},colorRange);%Cdc42
    %tempRATIOforstack2=ratio2RGB( imRatio{frameNum},colorRange3);%Cdc42
    
   
  imwrite(tempRATIOforstack,[datadir,filesep,  'Rho-FRET_0.7_1.3','.tif'],'WriteMode','append','Compression','none');
  % imwrite(tempRATIOforstack2,[datadir,filesep,  'Rho-FRET_[0.4 1.6]','.tif'],'WriteMode','append','Compression','none');
 %  imwrite(tempRATIOforstack,[datadir,filesep, 'Rho-FRET','max intensity proj2','.tif'],'WriteMode','append','Compression','none');
   
% imwrite(imFRETOutline{frameNum},[datadir,filesep,'_Outline','.tif'],'WriteMode','append','Compression','none');

%section added for cytoplasmic correction
% transform_bounds =[(prctile(im_mRuby_raw{frameNum}, 5, 'all')),prctile(im_mRuby_raw{frameNum}, 95, 'all')];
% lower = transform_bounds(1,1); 
% upper = transform_bounds(1,2); 
% A = lower*ones(1010); 
% B = upper*ones(1010); 
% mRuby_cyto_transform = 0.7 + 0.6*[im_mRuby_raw{frameNum}+ A]./ B; 
% %histogram(mRuby_cyto_transform); 
% bounds_new =[(prctile(mRuby_cyto_transform, 3, 'all')),prctile(mRuby_cyto_transform, 97, 'all')];
% mRuby_cyto{frameNum} = (1/(bleach_raw_mRuby(1,frameNum)*corr_norm_m(frameNum)))*im_mRuby_raw{frameNum}; 
% tempRATIO_cyto=tempRATIO_corr.*mRuby_cyto_transform; 
% %histogram(tempRATIO_cyto); 
% RATIO_cyto{frameNum}=tempRATIO_cyto; 
% RATIOforstack_cyto=ratio2RGB(tempRATIO_cyto, colorRange3); 

% pd_Rho = fitdist((tempRATIO_corr(tempRATIO_corr >= -10)), 'Normal'); 
% pd_Cyto = fitdist((mRuby_cyto{1}(mRuby_cyto{1} >= -100)), 'Normal'); 
% pd_Ratio = fitdist((tempRATIO_cyto(tempRATIO_cyto >= -100)), 'Normal'); 
% 
% minx = min(mRuby_cyto{1}); 
% xrange= -5:0.01:5;  
% y1= pdf(pd_Rho, xrange); 
% y2 = pdf(pd_Cyto, xrange); 
% y3 = pdf(pd_Ratio, xrange); 
% hold on; 
% plot(xrange, y1, 'Color', [1 1 0], 'LineWidth', 2); 
%     plot(xrange, y2, 'Color', [0 0 1], 'LineWidth', 2); 
   % plot(xrange, y3, 'Color', [0 0 0], 'LineWidth', 2); 

    
%imwrite(RATIOforstack_cyto,[datadir,filesep,position,  '_Rho-FRET_cyto',num2str(colorRange3(1)),'_',num2str(colorRange3(2)),'.tif'],'WriteMode','append','Compression','none');

end

for frameNum=1:length(im_mRuby_raw)
     
  
im_mRuby{frameNum}=im_mRuby_raw{frameNum}./(normfact_m*corr_norm_m(frameNum));
   

    colorRange2=[0 3];
     
  
    tempmRubyforstack=ratio2RGB(im_mRuby{frameNum},colorRange2);%Cdc42'
    
    
   tempmRubyforstack(tempmRubyforstack < 0) = 0.001; 
    
 imwrite(tempmRubyforstack,[datadir,filesep, 'mRuby_[0,3]','.tif'],'WriteMode','append','Compression','none');
  disp(num2str(frameNum)); 
% %    
%    
%    
%end

end    
load([datadir,filesep, 'RatioData_raw.mat'],'maskFinal','cellCoors');
save([datadir,filesep, 'RatioData.mat'],'-v7.3','maskFinal','cellCoors','imRatio','imFRETOutline','im_mRuby', 'immRuby_outline');

end 