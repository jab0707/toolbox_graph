function h = plot_mesh(vertex,face,options)

% plot_mesh - plot a 3D mesh.
%
%   plot_mesh(vertex,face, options);
%
%   'options' is a structure that may contains:
%       - 'normal' : a (nvertx x 3) array specifying the normals at each vertex.
%       - 'edge_color' : a float specifying the color of the edges.
%       - 'face_color' : a float specifying the color of the faces.
%       - 'face_vertex_color' : a color per vertex or face.
%       - 'vertex'
%
%   See also: mesh_previewer.
%
%   Copyright (c) 2004 Gabriel Peyré


%% check input
if nargin<2, error('Not enough arguments.'); end
options.null = 0;
check_face_vertex(vertex,face);


light = getoptions(options, 'light', true);
face_vertex_color = getoptions(options, 'face_vertex_color',  ones(size(vertex))'*0.5); 
edge_color = getoptions(options, 'edge_color', 'none');

%% 2D triangulation
if size(vertex,1)==2
    % vertex = cat(1,vertex, zeros(1,size(vertex,2)));
    plot_graph(triangulation2adjacency(face),vertex);
    return;
end

%% tet mesh 
if size(face,1)==4
    % normal to the plane <x,w><=a
    w = getoptions(options, 'cutting_plane', [0.2 0 1]');
    w = w(:)/sqrt(sum(w.^2));
    t = sum(vertex.*repmat(w,[1 size(vertex,2)]));
    a = getoptions(options, 'cutting_offs', median(t(:)) );
    b = getoptions(options, 'cutting_interactive', 0);
    
    while true;

        % in/out
        I = ( t<=a );
        % trim
        e = sum(I(face));
        J = find(e==4);
        facetrim = face(:,J);
        K = find(e==0);
        K = face(:,K); K = unique(K(:));

        % convert to triangular mesh
        hold on;
        if not(isempty(facetrim))
            face1 = tet2tri(facetrim, vertex, 1);
            options.method = 'fast';
            face1 = perform_faces_reorientation(vertex,face1, options);
            h{1} = plot_mesh(vertex,face1);
        end
        view(3); camlight;
        shading faceted;
        h{2} = plot3(vertex(1,K), vertex(2,K), vertex(3,K), 'k.');
        hold off;
        
        if b==0
            break;
        end

        [x,y,b] = ginput(1);
        
        if b==1
            a = a+.03;
        elseif b==3
            a = a-.03;
        else
            break;
        end
    end
    return;    
end

%% 3D mesh
vertex = vertex';
face = face';

if size(face_vertex_color,1)==size(vertex,1)
    shading_type = 'interp';
else
    shading_type = 'flat';
end

h = patch('vertices',vertex,'faces',face,'FaceVertexCData',face_vertex_color, ...
    'FaceColor',shading_type, 'EdgeColor', edge_color);

% plot the vertex normals
normal = getoptions(options, 'normalv', []);
if ~isempty(normal)   
    n = size(vertex,1);
    if size(normal, 1) ~= n, normal = normal'; end
    
    normal_scaling  = getoptions(options, 'normal_scaling', .8);
    subsample_normal = getoptions(options, 'subsample_normal', min(4000/n,1) );
    sel = randperm(n); sel = sel(1:floor(end*subsample_normal));    
    
    hold on;
    quiver3(vertex(sel,1),vertex(sel,2),vertex(sel,3), ...
        normal(sel,1), normal(sel,1), normal(sel,1), normal_scaling);
    hold off;
end

%% camera options
% cameramenu;
cameratoolbar('show');
cameratoolbar('SetMode', 'orbit');
cameratoolbar('SetCoordSys','none');
 
lighting phong;

camproj('perspective');
axis square; axis off; axis tight; axis equal;

if light % || strcmp(shading_type, 'interp')
%     shading interp;
    camlight left;
    camlight right;
%     camlight infinite; 
%     camlight(135, 60); camlight(225, 30);
%     camlight(180, -60); 
    material([0.4 0.5 0.5])
end


