function W = compute_mesh_weight(V,F,type,options)

% compute_mesh_weight - compute a weight matrix
%
%   W is sparse weight matrix and W(i,j)=0 is vertex i and vertex j are not
%   connected in the mesh.
%
%   type is either 
%       'combinatorial': W(i,j)=1 is vertex i is conntected to vertex j.
%       'distance': W(i,j) = 1/d_ij^2 where d_ij is distance between vertex
%           i and j.
%       'conformal': W(i,j) = 0.5*(cot(alpha_ij)+cot(beta_ij)) where alpha_ij
%           and beta_ij are the adjacent angle to edge (i,j)
%
%   If options.normalize=1, the the rows of W are normalize to sum to 1.

%% check input
options.null = 0;
check_face_vertex(V,F);
if nargin<3, type = 'conformal'; end

%% calc
wi = [ F(1,:) F(2,:) F(3,:) ];
wj = [ F(2,:) F(3,:) F(1,:) ];

switch lower(type)
    case 'combinatorial'
        W = sparse(wi, wj, 1);   
        
    case 'distance'        
        ws = 1 ./ sqrt(sum((V(:, wi) - V(:, wj)).^2));
        W = sparse(wi, wj, ws); 
        
    case 'conformal'
        % sinA
        sinA = sqrt(sum(cross( V(:, F(1, :)) - V(:, F(2, :)), ...
                               V(:, F(3, :)) - V(:, F(2, :)) ).^2));
        % cosA
        cosA(1, :) = dot( V(:, F(2, :)) - V(:, F(1, :)), ...
                          V(:, F(3, :)) - V(:, F(1, :)) );
        cosA(2, :) = dot( V(:, F(1, :)) - V(:, F(2, :)), ...
                          V(:, F(3, :)) - V(:, F(2, :)) );
        cosA(3, :) = dot( V(:, F(2, :)) - V(:, F(3, :)), ...
                          V(:, F(1, :)) - V(:, F(3, :)) );
        
        % cotA
        idx = find(sinA < eps); % check for divide by zero
        sinA(idx) = 1; cosA(:, idx) = 0;
        cotA = bsxfun(@rdivide, cosA, sinA);

        % the angle index opposite to the edge
        ws = [ cotA(3,:) cotA(1,:) cotA(2,:) ];

        W = sparse(wi, wj, ws); 
        W = 0.5*( W + W' );
    otherwise
        error('Unknown type.')
end

if isfield(options, 'normalize') && options.normalize==1
    W = diag(sum(W,2).^(-1)) * W;
end

end