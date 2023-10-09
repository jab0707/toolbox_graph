function ring = compute_vertex_face_ring(F)

% compute_vertex_face_ring - compute the faces adjacent to each vertex
%
%   ring = compute_vertex_face_ring(face);
%
%   Copyright (c) 2007 Gabriel Peyr?

nf = size(F,2);
nv = max(F(:));

ring{nv} = [];

for i=1:nf
    for k=1:3
        ring{F(k,i)}(end+1) = i;
    end
end