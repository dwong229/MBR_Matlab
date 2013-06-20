function [] = movie2imagesequence(filename,savepath)

% takes filesname and path and saves movie into .tiff images
% saves as a gray image

a = pwd;

mov = VideoReader(filename,'Tag','mov');

for i = 1:mov.NumberOfFrames
%for i = 1:2    
    % extract image
    cdata = read(mov, i); 
    
    if size(cdata,3) > 1
        img = single(rgb2gray(cdata));
    else
        img = cdata;
    end
   
    % save image
    cd(savepath)
    imgname = strcat(filename(1:end-4),sprintf('%04d',i),'.tif');
    imwrite(img,imgname,'tif')
end

cd(a)