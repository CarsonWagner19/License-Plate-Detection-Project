
size = 256;
BlobLabels = zeros(size, size);

% Read the Blue Car Jpeg Image
BlueCarColor = imread('BlueCarClose.jpg');

% Convert RGB Image into Grayscale
BlueCar = rgb2gray(BlueCarColor);

% Display the Original Image
figure(1);
image(BlueCar); colormap(gray(256));
axis('image', 'off');
title('Original Blue Car Image');

% Histogram of Blue Car Image
%histoBlueCar = sum(hist(BlueCar, 0:255)');
%histoFigure = bar(histoBlueCar);

% THRESHOLDING
threshold = 130;

J = 255 * (BlueCar >= threshold);

% Display Thresholded Car Image
figure(2); colormap(gray(256));
image(J); axis('image', 'off');
title('Blue Car Image at Threshold of 115')

% Blob Coloring on the Thresholded Image
[BlobLabels, MaxLabel] = BlobColor(J,size,BlobLabels);
y = i2bdbx(BlobLabels,size);
figure(3); colormap(gray(size));
image(y);axis('image');
title('Result after Blob Coloring');

% Blob Counting, Remove Minor Regions and Display Result
BlobCounts = BlobCount(size,BlobLabels,MaxLabel);
J = RemoveMinorRegions(J,size,BlobLabels,BlobCounts);

figure(4);colormap(gray(256));
image(J);axis('image');
title('Result after minor region removal');

% Invert Image and Repeat Blob Coloring and Minor Region Removal
J = 255 - J;
[BlobLabels,MaxLabel] = BlobColor(J,size,BlobLabels);
BlobCounts = BlobCount(size,BlobLabels,MaxLabel);
x = RemoveMinorRegions(J,size,BlobLabels,BlobCounts);

figure(5); 
colormap(gray(256));
image(x); axis('image');
title('Minor Region Removal');

% Invert to get the final result
x = 255 - x;
figure(6); colormap(gray(256));
image(x);axis('image');
title('Final Result');

% Convert BlueCar to double
BlueCarDouble = double(BlueCar);

% Fused Final Result
y = 255 - ((x .* (255 - BlueCarDouble)) / 255);
figure(7); colormap(gray(256));
image(y);
axis('image');
title('Fused Final Result');

% Crop the License Plate Image
cropPlate = imcrop(y,[65 140 140 45]);         % PLATE CROPPED FULLY
%cropPlate = imcrop(y, [25 120 180 90]);


% Display Cropped License Plate Image
figure(8); colormap(gray(256));
image(cropPlate);axis('image');
title('Final Result');




