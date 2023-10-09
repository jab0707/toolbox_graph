function e2f = compute_edge_face_ring(F)

% compute_edge_F_ring - compute Fs adjacent to each edge
%
%   e2f = compute_edge_F_ring(F);
%
%   e2f(i,j) and e2f(j,i) are the number of the two Fs adjacent to
%   edge (i,j).

nf = size(F, 2);
i = [F(1,:) F(2,:) F(3,:)];
j = [F(2,:) F(3,:) F(1,:)];
s = [1:nf 1:nf 1:nf];
e2f = sparse(i,j,s); 

% fill missing point
A = (e2f > 0) - ((e2f + e2f')>0);
e2f = e2f + A;

% I = find( e2f'~=0 );
% I = I( e2f(I)==0 ); 
% e2f( I ) = -1;
end