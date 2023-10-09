function [ areas ] = compute_face_area(V, F)
%COMPUTE_FACE_AREA compute the face area of triangles
%   vertex must be of size [n,3]
%   face must be of size [p,3]

normalf = cross( V(:,F(2,:))-V(:,F(1,:)), V(:,F(3,:))-V(:,F(1,:)));
areas = 0.5 * sqrt( sum(normalf.^2) );

end

