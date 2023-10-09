function vring = compute_vertex_ring(F)

% compute_vertex_ring 

A = tri2adjmat(F);
vring = adjmat2list(A);
