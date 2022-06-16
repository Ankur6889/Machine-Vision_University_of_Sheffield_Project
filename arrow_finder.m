function [modified_props] = arrow_finder(im,props)
len=length(props);
arrow_number=0;
for i=1:len
    sect=imcrop(im,props(i).BoundingBox);
    % extract RGB channels separatelly
    red_channel = sect(:, :, 1);
    green_channel = sect(:, :, 2);
    blue_channel = sect(:, :, 3);
    % label pixels of yellow colour
    yellow_map = green_channel > 220 & red_channel > 220 & blue_channel < 30;
    parameter=regionprops(yellow_map);
    if isempty(parameter)== 0
        props(i).arrow_id=arrow_number;
        arrow_number=arrow_number+1;
    else 
        props(i).arrow_id='Not_arrow'
    end
end 
modified_props=props;
end
