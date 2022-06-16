clear
clc 

%% Reading image
im = imread('Treasure_easy.jpg'); % change name to process other images
red_channel = im(:, :, 1);
green_channel =im(:, :, 2);
blue_channel = im(:, :, 3);
yellow_map = green_channel > 220 & red_channel > 220 & blue_channel < 30;
yellow_dots = bwlabel(yellow_map);
yellow_cent = regionprops(yellow_dots);
n_objects = numel(yellow_cent);
figure;
imshow(im);
hold on;
for object_id = 1 : n_objects
    rectangle('Position', yellow_cent(object_id).BoundingBox, 'EdgeColor', 'b');
end
hold off;