clear
clc 

%% Reading image
im = imread('Treasure_hard.jpg'); % change name to process other images
figure;
imshow(im);

%% Binarisation
bin_threshold = 0.05; % parameter to vary
bin_im = im2bw(im, bin_threshold);
figure;
imshow(bin_im);


%% Extracting connected components
con_com = bwlabel(bin_im);
figure;
imshow(label2rgb(con_com));


%% Computing objects properties
props = regionprops(con_com);

props=arrow_finder(im,props);

%% computing the centroid of yellow regions 
red_channel = im(:, :, 1);
green_channel =im(:, :, 2);
blue_channel = im(:, :, 3);
yellow_map = green_channel > 220 & red_channel > 220 & blue_channel < 30;
yellow_dots = bwlabel(yellow_map);
yellow_cent = regionprops(yellow_dots);
imshow(yellow_map)

%% Adding the centroid of arrows with their other properties 

for loop1=1:28
    dist=[];
    disp(dist)
    for loop2=1:11
        dist(loop2)=eucledian_dist(yellow_cent(loop1).Centroid,props(loop2).Centroid);
    end 
    [M,I]=min(dist);
    props(I).Cetroid_of_yellow_dot=yellow_cent(loop1).Centroid;
    props(I).BoundingBox_of_yellow_dot=yellow_cent(loop1).BoundingBox;
 end