function mov = vid2img(filename,path,colormap)

% IMG = VID2IMG(FILENAME,COLORMAP)

addpath(genpath(path))

vid = VideoReader(filename,'Tag','mov');

if isequal(colormap,'gray')
    colorchannels = 1;
else
    colorchannels = 3;
end

% Read one frame at a time.
% Preallocate movie structure.
mov(1:vid.NumberOfFrames) = struct('imgdata', zeros(vid.Height, vid.Width, colorchannels, 'uint8'),'colormap', colormap);

% Read one frame at a time.
for k = 1 : vid.NumberOfFrames
    cdata = read(vid, k);
    if size(cdata,3) == 1 
        mov(k).imgdata = 255 - cdata;
    else
        mov(k).imgdata = 255 - single(rgb2gray(cdata));
    end
end

