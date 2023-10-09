function [L, W] = compute_face_Laplacian(pos, fring)
% distance based face center laplacian
% L must be normalized for filtering
% diag(W)^-1 * L is the normalized laplacian

nf = size(fring, 2);
i = zeros(1, 4*nf);
j = zeros(1, 4*nf);
s = zeros(1, 4*nf);
W = zeros(1, nf);
weight = zeros(1, 3);
for k = 1:nf	
	for h = 1:3
		k1 = fring{k}(h);
		dp = pos(:, k1) - pos(:, k);
		weight(h) = exp( - 0.5 * (dp'*dp));
    end
    sw = sum(weight);
    
    i(4*k-3 : 4*k) = k;
	j(4*k-3 : 4*k) = [fring{k}, k];
	s(4*k-3 : 4*k) = [-weight, sw];
    W(k) = sw;
end
L = sparse(i, j, s);
end
    