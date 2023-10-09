function fring = compute_face_ring(F)

% compute_face_ring - compute the 1 ring of each face in a triangulation.

%   fring{i} is the set of faces that are adjacent
%   to face i.
% 
%   F is of size (3,nface)

nf = size(F,2);
A = compute_edge_face_ring(F);
[i,j,s1] = find(A);     % direct link
[i,j,s2] = find(A');    % reverse link

I = find(i<j);
s1 = s1(I); s2 = s2(I);

fring{nf} = [];
for k=1:length(s1)
    if s1(k)>0 && s2(k)>0
        fring{s1(k)}(end+1) = s2(k);
        fring{s2(k)}(end+1) = s1(k);
    end
end

end
