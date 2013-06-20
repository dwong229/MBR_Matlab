function imgFilt = imageFilter(filename,bounds)

% image filter loads the image filename and returns an image between 0 and 1 
% that filters the image such that the pixels values are centered within the
% bounds.  The pixel values are linearly filtered such that the lower value
% of bounds is set to 0 and the higher value of bounds is set to 1.  Values
% out size these bounds are rounded to the limits [0,1].  

lo = min(bounds);
hi = max(bounds);

img = imread(filename);

% bin for 16-bit image
imgtype = class(img);
if isequal(imgtype,'uint16')
    pixelbins = 1:1:2^16;
elseif isequal(imgtype,'uint8')
    pixelbins = 1:1:2^8;
else
    inputQuery = strcat('Image class is ',imgtype,'.\n Max value for histogram?')
    pixelLim = input(inputQuery,'n');
    pixelbins = 1:pixelLim;
end

figure
hist(double(img(:)),pixelbins);
hold on
plot([lo lo],[0 1800],'-k')
plot([hi hi],[0 1800],'-k')

imgFilt = zeros(size(img));

imgFilt(:) = (double(img(:)) - lo)*1/range(bounds);
%imgFilt(imgFilt(:)<0) = 0;

%imgFilt(imgFilt(:)>1) = 1;

figure
subplot(1,2,1);
imshow(img);
subplot(1,2,2)
imshow(imgFilt);