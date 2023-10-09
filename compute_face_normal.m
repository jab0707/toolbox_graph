function [normalf] = compute_face_normal(V, F)
% compute_face_normal - compute the normal of the face

normalf = cross( V(:,F(2,:))-V(:,F(1,:)), V(:,F(3,:))-V(:,F(1,:)));
d = sqrt( sum(normalf.^2) ); d(d<eps)=1;
normalf =  bsxfun(@rdivide, normalf, d);

end