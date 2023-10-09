function [ mat ] = vring2matrix( vring , sring)
% vring : contains adjacency information
% sring : contains value information 

n = max(size(vring));
m = 0;
for i = 1:n
	m = m + size(vring{i}, 2);
end

mi = zeros(m, 1);
mj = zeros(m, 1);
ms = zeros(m, 1);

k = 1;
for i = 1:n
	nr = size(vring{i}, 2);
	for j = 1:nr
		mi(k) = i;
		mj(k) = vring{i}(j);
		ms(k) = sring{i}(j);
		k = k + 1;
	end
end

mat = sparse(mi, mj, ms);

end

