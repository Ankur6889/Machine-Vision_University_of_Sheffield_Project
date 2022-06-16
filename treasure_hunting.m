clear
clc 

%% Reading image
im = imread('Treasure_easy.jpg'); % change name to process other images
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


%% Arrow/non-arrow determination
% You should develop a function arrow_finder, which returns the IDs of the arror objects. 
% IDs are from the connected component analysis order. You may use any parameters for your function. 

% arrow_ind = arrow_finder();
% 
% %% Finding red arrow
% n_arrows = numel(arrow_ind);
% start_arrow_id = 0;
% % check each arrow until find the red one
% for arrow_num = 1 : n_arrows
%     object_id = arrow_ind(arrow_num);    % determine the arrow id
%     
%     % extract colour of the centroid point of the current arrow
%     centroid_colour = im(round(props(object_id).Centroid(2)), round(props(object_id).Centroid(1)), :); 
%     if centroid_colour(:, :, 1) > 240 && centroid_colour(:, :, 2) < 10 && centroid_colour(:, :, 3) < 10
% 	% the centroid point is red, memorise its id and break the loop
%         start_arrow_id = object_id;
%         break;
%     end
% end
% 
% 
% %% Hunting
% cur_object = start_arrow_id; % start from the red arrow
% path = cur_object;
% 
% % while the current object is an arrow, continue to search
% while ismember(cur_object, arrow_ind) 
%     % You should develop a function next_object_finder, which returns
%     % the ID of the nearest object, which is pointed at by the current
%     % arrow. You may use any other parameters for your function.
% 
%     cur_object = next_object_finder(cur_object);
%     path(end + 1) = cur_object;
% end
% 
% %% visualisation of the path
% imshow(im);
% hold on;
% for path_element = 1 : numel(path) - 1
%     object_id = path(path_element); % determine the object id
%     rectangle('Position', props(object_id).BoundingBox, 'EdgeColor', 'y');
%     str = num2str(path_element);
%     text(props(object_id).BoundingBox(1), props(object_id).BoundingBox(2), str, 'Color', 'r', 'FontWeight', 'bold', 'FontSize', 14);
% end
% 
% % visualisation of the treasure
% treasure_id = path(end);
% rectangle('Position', props(treasure_id).BoundingBox, 'EdgeColor', 'g');
