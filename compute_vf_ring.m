function VFr = compute_vf_ring(F)
% compute_vf_ring - compute the faces adjacent to each vertex

nf = size(F,2);
si = reshape(repmat(1:nf, 3, 1), 3*nf, 1);
sj = reshape(F, 3*nf, 1);

matFV = sparse(si, sj, 1);
VF = adjmat2list(matVF);