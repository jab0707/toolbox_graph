function [ fring ] = compute_face_ringv(faces)
%COMPUTE_FACE_RINGV compute face ring (face adjency by vertex)

ring = compute_vertex_face_ring(faces);

n = size(faces, 2);
fring = cell(1, n);
for i = 1:n
    ff = [];
    for j = faces(:, i)'
        for k = ring{j}
            if k ~= i
                ff = [ff, k];
            end
        end
    end
    fring{i} = unique(ff);
end

end

