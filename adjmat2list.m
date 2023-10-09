function adj_list = adjmat2list(A)

%   adjmatrix2list - convert from matrix adjacency representation
%       to list adjacency. The adjacency can be a weighted matrix, 
%       and unlinked vertices should have weight either 'Inf' or '<=0'.
%
%   adj_list = adjmatrix2list(A);
%
%   adj_list is a cell array of vector, adj_list{i}
%   is the set of vertices linked to i.

adj_list = cell(1, size(A,2));

[Ai, Aj, ~] = find(A);

j = 1; j2 = 1;
for i=1:length(Ai);
	if Aj(i) ~= j
		j1 = j2;
		j2 = i;
		adj_list{j} = Ai(j1:j2-1);
		j = j + 1;
	end
end

adj_list{j} = Ai(j2:end);