function [normal,normalf] = compute_normal(V,F)
% compute_normal - compute the normal of a triangulation
%
%   [normal,normalf] = compute_normal(vertex,face);
%
%   normal(i,:) is the normal at vertex i.
%   normalf(j,:) is the normal at face j.


check_face_vertex(V,F);

% compute face normal
normalf = compute_face_normal(V, F);

% compute vertex normal
normal = zeros(size(V));
areas = compute_face_area(V, F);
normalfw = bsxfun(@times, normalf, areas);
for i = 1:size(F, 2)
    normal(:, F(:, i)) = normal(:, F(:, i)) + repmat(normalfw(:, i), 1, 3);
end
d = sqrt( sum(normal.^2,1) ); %d(d<eps)=1;
normal = bsxfun(@rdivide, normal, d);

end