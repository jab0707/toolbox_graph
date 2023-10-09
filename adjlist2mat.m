function A = adjlist2mat(adj_list)

%   adjmatrix2list - convert from list adjacency representation
%       to matrix adjacency. 
%
%   A = adjlist2mat(adj_list);
%
%   adj_list is a cell array of vector, adj_list{i}
%   is the set of vertices linked to i.


% compute the number of non-zeros elements
n = length(adj_list);
m = 0;
for i = 1:n
    m = m + length(adj_list{i});
end

% compute the sparse matrix
ai = zeros(m, 1);
aj = zeros(m, 1);
n2 = 0;
for i=1:n
    n1 = n2 + 1;
    n2 = n2 + length(adj_list{i});
    ai(n1:n2) = i;
    aj(n1:n2) = adj_list{i};
end
A = sparse(ai, aj, 1);