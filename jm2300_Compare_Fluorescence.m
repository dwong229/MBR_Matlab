close all
% 
% path = '/home/mrsl-think/Dropbox/060713 JM2300 Light Exposure/'
% filename{1} = 'DAPI 0.25s Everywhere 10X.tif';
% filename{2} = 'DAPI 10s Everywhere 10X.tif';
% filename{3} = 'Dark Culture 4hrs_10X.tif';
% filename{4} = 'Room Light Only During Plating 4hrs.tif';
% 
% path = '/home/mrsl-think/Dropbox/060713 JM2300 Light Exposure/20130614_JM2300IPTG_SU8/';
% 
% filename{1} = 'exposed_0.05M_IPTG_fluor_40X_Retiga_2.tif';
% filename{2} = 'exposed_0.05M_IPTG_fluor_40X_Retiga.tif';
% filename{3} = 'exposed_0.08M_IPTG_fluor_40X_Retiga.tif';
% filename{4} = 'exposed_no_IPTG_fluor_40X_Retiga_2.tif';
% filename{5} = 'exposed_no_IPTG_fluor_40X_Retiga_3.tif';
% filename{6} = 'exposed_no_IPTG_fluor_40X_Retiga_4.tif';
% filename{7} = 'exposed_no_IPTG_fluor_40X_Retiga.tif';
% filename{8} = 'not_exposed_0.01M_IPTG_fluor_40X_Retiga.tif';
% filename{9} = 'not_exposed_no_IPTG_fluor_40X_Retiga_2.tif';
% filename{10}= 'not_exposed_no_IPTG_fluor_40X_Retiga_3.tif';
% filename{11}='not_exposed_no_IPTG_fluor_40X_Retiga_4.tif';
% filename{12}='not_exposed_no_IPTG_fluor_40X_Retiga.tif';

path = '/home/mrsl-think/Dropbox/060713 JM2300 Light Exposure/20130618_EColi_2300_SU8'
cd(path)
addpath(genpath(cd))

listing = dir('*_fluor_*');

for n = 1:length(listing)
    filename{n} = listing(n).name;
end


binsize = 10;
pixelbins = binsize/2:binsize:255;

for i = 1:length(filename)
    img = imread(filename{i});
    filename{i} = regexprep(filename{i},'_',' ');
    figure
    set(gcf,'Position',[50,50,800,200])
    subplot(1,2,1)
    imshow(img);
    title(filename{i})
    subplot(1,2,2)
    hist(double(img(:)),pixelbins);
    axis([0 255 0 length(img(:))])
    xlabel('Pixel Value')
    ylabel('Frequency')
    disp(filename{i})
    val = double(img(:));
    meanPixelValue = mean(val);
    modePixelValue = mode(val);
    stdevPixel = std(val);
    fprintf('Mean: %3.1f \nMode: %3.1f \nStDev: %3.1f \n',meanPixelValue,modePixelValue,stdevPixel)
    statStr = sprintf('Mean: %3.1f \nMode: %3.1f \nStDev: %3.1f \n',meanPixelValue,modePixelValue,stdevPixel);
    text(100,length(img(:))*.8,statStr);
    saveplotstr = strcat(filename{i}(1:end-4),'Stat.eps');
    print(gcf,'-deps','-tiff','-r300',saveplotstr)
    
    
    
end