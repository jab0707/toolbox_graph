function write_obj(filename, V, F, options)
% write_obj - write a mesh to an OBJ file
%
%   write_obj(filename, vertex, face, options)
%
%   V : vertex must be of size [3, n]
%   F : face must be of size [3, f]
%   options.texture : texture cooridate must be of size [2, t]

% check input
if nargin<4
    options.null = 0;
end

% check vertex
if size(V,2)~=3
    V=V';
end
if size(V,2)~=3
    error('vertex does not have the correct format.');
end

% check face
if size(F,2)~=3
    F=F';
end
if size(F,2)~=3
    error('face does not have the correct format.');
end

% open file
fid = fopen(filename,'wt');
if( fid==-1 )
    error('Can''t open the file.');
    return;
end

% face and vertex number
fprintf(fid, '# %d vertex\n', size(V,1));
fprintf(fid, '# %d faces\n', size(F,1));

% vertex position
fprintf(fid, 'v %f %f %f\n', V');

% vertex texture
if isfield(options, 'texture')
    % texture
    fpringf(fid, 't %f %f \n', options.texture');
    
    % face
    face_texcorrd = [F(:,1), F(:,1), F(:,2), F(:,2), F(:,3), F(:,3)];
    fprintf(fid, 'f %d/%d %d/%d %d/%d\n', face_texcorrd');
else
     % face
    fprintf(fid, '# %d faces\n', size(F,1));
    fprintf(fid, 'f %d %d %d\n', F');
end

fclose(fid);
end