function check_face_vertex(V,F)

% check_face_vertex - check that vertices and faces have the correct size
%   check the first dimension of V and F   

if size(V,1)<2 ||  size(V,1)>4
    error('Vertices are not of correct size.');
end

if size(F,1)<3 ||  size(F,1)>4
    error('Faces are not of correct size.');
end

end