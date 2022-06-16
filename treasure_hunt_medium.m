clear
clc 

%% Reading image
im = imread('Treasure_medium.jpg'); % change name to process other images
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



%% Adding the centroid of arrows with their other properties 

for loop1=1:15
    dist=[];
    disp(dist)
    for loop2=1:17
        dist(loop2)=eucledian_dist(yellow_cent(loop1).Centroid,props(loop2).Centroid);
    end 
    [M,I]=min(dist);
    props(I).Cetroid_of_yellow_dot=yellow_cent(loop1).Centroid;
    props(I).BoundingBox_of_yellow_dot=yellow_cent(loop1).BoundingBox;
 end

%% Drawing bounding boxes
n_objects = numel(props);
figure;
imshow(im);
hold on;
for object_id = 1 : n_objects
    rectangle('Position', props(object_id).BoundingBox, 'EdgeColor', 'b');
    if props(object_id).arrow_id ~= 'Not_arrow'
    text(props(object_id).Centroid(1),props(object_id).Centroid(2)-35,sprintf("%d",props(object_id).arrow_id),Color='r');
    end
end
hold off;


%% Finding the object 
current_object=1;
co_ordinates=props(current_object).Cetroid_of_yellow_dot;
go=true;
figure();
imshow(im);
hold on;
arrow_count=1;
while go
     current_object_direction=direction(props(current_object).Centroid,props(current_object).Cetroid_of_yellow_dot);
      rectangle('Position', props(current_object).BoundingBox, 'EdgeColor', 'r',LineWidth=1.5);
      if props(current_object).arrow_id ~= 'Not_arrow'
         text(props(current_object).Centroid(1),props(current_object).Centroid(2)-40,sprintf("%d",arrow_count),Color='r');
      end
     co_ordinates=co_ordinates+(current_object_direction*0.5);
     for loop3=1:17
         if co_ordinates(1) > props(loop3).BoundingBox(1) & co_ordinates(2) > props(loop3).BoundingBox(2) & co_ordinates(1) < props(loop3).BoundingBox(1)+props(loop3).BoundingBox(3) & co_ordinates(2) < props(loop3).BoundingBox(2)+props(loop3).BoundingBox(4) & loop3~=current_object
             disp(loop3)
             disp(co_ordinates)
             disp(props(loop3).BoundingBox(1))
             disp(props(loop3).BoundingBox(2))
             disp(props(loop3).BoundingBox(1)+props(loop3).BoundingBox(3))
             disp(props(loop3).BoundingBox(2)+props(loop3).BoundingBox(4))
             pause(2)
             if props(loop3).arrow_id == 'Not_arrow'
                 rectangle('Position', props(loop3).BoundingBox, 'EdgeColor', 'b','LineWidth',2);
                 text(props(loop3).Centroid(1)-120,props(loop3).Centroid(2)+50,sprintf("This is the Treasure!!"),Color='b',FontSize=15);
                 go=false
             else
                 current_object=loop3;
                 disp(current_object)
                 disp(loop3)
                 arrow_count=arrow_count+1;
                 co_ordinates=props(current_object).Cetroid_of_yellow_dot;
             end

         end
     end
end    

    