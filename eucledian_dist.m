function [distance] = eucledian_dist(centroid_1,centroid_2)
distance=sqrt((centroid_1(1)-centroid_2(1))^2 + (centroid_1(2)-centroid_2(2))^2 );
end