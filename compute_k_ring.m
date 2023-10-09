function [ kring ] = compute_k_ring( F, k )
%COMPUTE_K_RING compute kring

A = tri2adjmat(F);
if k > 1
	A = (A^k > 0) - speye(size(A, 1));
end
kring = adjmat2list(A);
    
end